//
//  WeatherAPI.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/12/2020.
//

import Foundation
import CoreLocation
import os

struct WeatherAPIIcons {
    // MARK: - Utilities
    static let dayIconCodes: [Int: String] = [1000: "sun.max",
                                              1003: "cloud.sun",
                                              1063: "cloud.sun.rain",
                                              1087: "cloud.sun.bolt",
                                              1180: "cloud.sun.rain",
                                              1186: "cloud.sun.rain",
                                              1192: "cloud.sun.rain",
                                              1273: "cloud.sun.bolt"]
    
    static let nightIconCodes: [Int: String] = [1000: "moon.stars",
                                                1003: "cloud.moon",
                                                1063: "cloud.moon.rain",
                                                1087: "cloud.moon.bolt",
                                                1180: "cloud.moon.rain",
                                                1186: "cloud.moon.rain",
                                                1192: "cloud.moon.rain",
                                                1273: "cloud.moon.bolt"]
    
    static let genericIconCodes: [Int: String] = [1006: "cloud",
                                                  1009: "smoke",
                                                  1030: "cloud.fog",
                                                  1066: "cloud.snow",
                                                  1069: "cloud.sleet",
                                                  1072: "cloud.drizzle",
                                                  1114: "wind.snow",
                                                  1117: "wind.snow",
                                                  1135: "cloud.fog",
                                                  1147: "cloud.fog",
                                                  1150: "cloud.drizzle",
                                                  1153: "cloud.drizzle",
                                                  1168: "cloud.sleet",
                                                  1171: "cloud.sleet",
                                                  1183: "cloud.rain",
                                                  1189: "cloud.rain",
                                                  1195: "cloud.heavyrain",
                                                  1198: "cloud.sleet",
                                                  1201: "cloud.sleet",
                                                  1204: "cloud.sleet",
                                                  1207: "cloud.sleet",
                                                  1210: "cloud.snow",
                                                  1213: "cloud.snow",
                                                  1216: "snow",
                                                  1219: "snow",
                                                  1222: "snow",
                                                  1225: "snow",
                                                  1237: "cloud.hail",
                                                  1240: "cloud.drizzle",
                                                  1243: "cloud.rain",
                                                  1246: "cloud.heavyrain",
                                                  1249: "cloud.sleet",
                                                  1252: "cloud.sleet",
                                                  1255: "cloud.snow",
                                                  1258: "snow",
                                                  1261: "cloud.hail",
                                                  1264: "cloud.hail",
                                                  1276: "cloud.bolt.rain",
                                                  1279: "cloud.snow",
                                                  1282: "cloud.snow"]
}

struct WeatherAPIResponse: Decodable {
    
    // MARK: - Structs
    struct WeatherAPILocation: Decodable {
        var name: String
        var region: String
        var country: String
    }
    
    class WeatherAPIForecast: Decodable {
        var forecastDays: [WeatherAPIForecastDay]?
        
        enum CodingKeys: String, CodingKey {
            case forecastDays = "forecastday"
        }
    }
    
    class WeatherAPIForecastDay: Decodable {
        var hourly: [WeatherAPIForecastHour]?
        
        enum CodingKeys: String, CodingKey {
            case hourly = "hour"
        }
    }
    
    class WeatherAPIForecastHour: Decodable {
        var timeEpoch: Int
        var tempC: Double
        var tempF: Double
        var windkph: Double
        var windmph: Double
        var windDegree: Double
        var windDirection: String
        var isDay: Int
        var condition: WeatherAPICondition
        
        enum CodingKeys: String, CodingKey {
            case timeEpoch = "time_epoch"
            case tempC = "temp_c"
            case tempF = "temp_f"
            case windkph = "wind_kph"
            case windmph = "wind_mph"
            case windDegree = "wind_degree"
            case windDirection = "wind_dir"
            case isDay = "is_day"
            case condition = "condition"
        }
        
        func getIcon() -> String {
            
            // Wind detection
            if windkph > 40 {
                return "wind"
            }
            
            // Other conditions
            let iconCode = condition.code
            if isDay != 0 {
                if let icon = WeatherAPIIcons.dayIconCodes[iconCode] {
                    return icon
                }
            } else {
                if let icon = WeatherAPIIcons.nightIconCodes[iconCode] {
                    return icon
                }
            }
            
            // Not a dynamic icon
            if let icon = WeatherAPIIcons.genericIconCodes[iconCode] {
                return icon
            }
            
            // Not found (should never happen, but in case of API update, return a question mark)
            // Returned also when there is no forecast
            return "questionmark.diamond"
        }
    }
    
    struct WeatherAPICondition: Decodable {
        var text: String
        var code: Int
    }
    
    // MARK: - Properties
    var location: WeatherAPILocation
    var forecast: WeatherAPIForecast
    
    // MARK: - Functions
    func getOnlyHourlyForecast(/*unixDateTime: UInt*/) -> WeatherAPIForecastHour? {
        // return forecast.forecastDays?.first?.hourly?.first(where: {abs($0.timeEpoch - Int(unixDateTime)) < 3600})
        return forecast.forecastDays?.first?.hourly?.first
    }
}

class WeatherAPI {
    private var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Weather API")
    static var shared = WeatherAPI()
    
    func forecast(forLocation location: CLLocationCoordinate2D,
                  at date: Date,
                  completion callback: @escaping (WeatherAPIResponse?) -> Void) {
        
        let key = SecretsManager.shared.root?.weatherAPI.key ?? ""
        
        let requestString: String = "https://api.weatherapi.com/v1/forecast.json?key=\(key)&q=\(location.latitude),\(location.longitude)&days=1&unixdt=\(date.timeIntervalSince1970)&hour=\(date.get(.hour))"
        
        URLSession.shared.dataTask(with: URL(string: requestString)!) { [self] data, response, error in
            if let error = error {
                logger.info("Error while getting weather data for location (\(location.latitude), \(location.longitude)): \(error as NSObject).")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                logger.error("Error: server returned non-200 response.")
                return
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
                    callback(result)
                } catch {
                    logger.error("Error while decoding WeatherAPI response: \(error as NSObject).")
                }
            }
        }.resume()
    }
}
