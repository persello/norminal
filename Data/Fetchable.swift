//
//  Fetchable.swift
//  Norminal
//
//  Created by Riccardo Persello on 25/05/21.
//

import Alamofire
import Foundation

// MARK: - Utility extension for initializing UUID from string with no dashes

extension UUID {
    init?(stringWithoutDashes input: String) {
        var dashed = input
        while dashed.count < 32 {
            dashed.append("0")
        }

        dashed.insert("-", at: input.index(input.startIndex, offsetBy: 20))
        dashed.insert("-", at: input.index(input.startIndex, offsetBy: 16))
        dashed.insert("-", at: input.index(input.startIndex, offsetBy: 12))
        dashed.insert("-", at: input.index(input.startIndex, offsetBy: 8))

        self.init(uuidString: dashed.uppercased())
    }
}

// MARK: - Custom date formatter for extended ISO8601 support.

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

// MARK: - Custom JSON date format decoder

class CustomDecoder: JSONDecoder {
    static var `default` = CustomDecoder()

    override init() {
        super.init()
        dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            if let date = DateFormatter.iso8601Full.date(from: dateStr) {
                return date
            } else if let date = ISO8601DateFormatter().date(from: dateStr) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateStr).")
            }
        })
    }
}

// MARK: - Fetchable protocols

protocol ArrayFetchable {
    var stringID: String { get }
    static var baseURL: URL { get }
    static func load(id: String, completion handler: @escaping (Result<Self, Error>) -> Void)
    static func get(id: String?, _ completion: @escaping (Self?) -> Void)
    static func loadAll(completion handler: @escaping (Result<[Self], Error>) -> Void)
}

protocol Fetchable {
    var stringID: String { get }
    static var baseURL: URL { get }
    static func get(_ completion: @escaping (Self?) -> Void)
    static func load(completion handler: @escaping (Result<Self, Error>) -> Void)
}

class NilDataError: Error {
    var localizedDescription = "Request was successful, but returned data was nil."
}

class EmptyIDError: Error {
    var localizedDescription = "The passed ID array was nil or empty."
}

// MARK: - Fetchable implementations

extension ArrayFetchable where Self: Decodable {
    static func get(id: String?, _ completion: @escaping (Self?) -> Void) {
        guard id != nil else {
            completion(nil)
            return
        }

        load(id: id!, completion: { result in
            switch result {
            case .failure:
                completion(nil)
            case let .success(data):
                completion(data)
            }
        })
    }

    static func loadFromArrayOfIdentifiers(ids: [String]?, completion handler: @escaping (Result<[Self], Error>) -> Void) {
        guard ids?.count ?? 0 > 0 else {
            handler(.failure(EmptyIDError()))
            return
        }

        loadAll { result in
            switch result {
            case let .failure(error):
                handler(.failure(error))
            case let .success(items):
                handler(.success(items.filter({ ids?.contains($0.stringID) ?? false })))
            }
        }
    }

    static func loadAll(completion handler: @escaping (Result<[Self], Error>) -> Void) {
        AF.request(baseURL)
            .validate(statusCode: 200 ..< 300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case let .failure(error):
                    handler(.failure(error))

                case .success:
                    if let data = response.data {
                        do {
                            let result = try CustomDecoder.default.decode([Self].self, from: data)
                            handler(.success(result))
                        } catch {
                            handler(.failure(error))
                        }

                    } else {
                        handler(.failure(NilDataError()))
                        return
                    }
                }
            }
    }

    static func load(id: String, completion handler: @escaping (Result<Self, Error>) -> Void) {
        let parameters = ["id": id]
        AF.request(baseURL, parameters: parameters)
            .validate(statusCode: 200 ..< 300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case let .failure(error):
                    handler(.failure(error))

                case .success:
                    if let data = response.data {
                        do {
                            let result = try CustomDecoder.default.decode(Self.self, from: data)
                            handler(.success(result))
                        } catch {
                            handler(.failure(error))
                        }

                    } else {
                        handler(.failure(NilDataError()))
                        return
                    }
                }
            }
    }
}

extension Fetchable where Self: Decodable {
    static func get(_ completion: @escaping (Self?) -> Void) {
        load(completion: { result in
            switch result {
            case .failure:
                completion(nil)
            case let .success(data):
                completion(data)
            }
        })
    }

    static func load(completion handler: @escaping (Result<Self, Error>) -> Void) {
        AF.request(baseURL)
            .validate(statusCode: 200 ..< 300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case let .failure(error):
                    handler(.failure(error))
                    return

                case .success:
                    if let data = response.data {
                        do {
                            let result = try CustomDecoder.default.decode(Self.self, from: data)
                            handler(.success(result))
                        } catch {
                            handler(.failure(error))
                        }

                    } else {
                        handler(.failure(NilDataError()))
                        return
                    }
                }
            }
    }
}
