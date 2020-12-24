//
//  ImageCache.swift
//  Norminal
//
//  Created by Riccardo Persello on 24/12/2020.
//

import Foundation
import os
import UIKit

struct ImageCache {
  
  private var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Image cache")
  
  /// Shared instance
  static let shared = ImageCache()
  
  /// RAM cache
  private let volatileCache = NSCache<NSString, UIImage>()
  
  // MARK: - Public functions
  
  /// Gets an image from the related URL and tag.
  /// If a tag is specified, it won't be downloaded from the internet.
  func get(fromURL url: URL, withTag tag: String?, completion callback: @escaping (UIImage?) -> Void) {
    let key = url.absoluteString.replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: ":", with: "-")
    logger.info("Getting image for URL \(url.absoluteString) with tag \(tag ?? "").")
    
    // Try to retrieve
    if let image = retrieve(fromKey: "\(key)\(tag ?? "")" as NSString) {
      logger.debug("Image for key \(key) successfully retrieved.")
      callback(image)
      return
    }
    
    if tag != nil {
      logger.debug("Image for key \(key) not found. Not downloading due to tag not nil.")
      callback(nil)
      return
    }
    
    logger.debug("Image for key \(key) not found. Downloading it now.")
    
    // Else download and save
    URLSession.shared.dataTask(with: url) { [self] data, response, error in
      if let error = error {
        logger.error("Error while downloading image: \(error as NSObject).")
        callback(nil)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        logger.error("Error while downloading image: status code not 2xx.")
        callback(nil)
        return
      }
      
      if let data = data {
        if let image = UIImage(data: data) {
          save(image: image, withKey: key as NSString)
          callback(image)
        }
      }
    }.resume()
  }
  
  /// Updates an existing image in cache with a new one (possibly tagged). The old one is removed when possible.
  func update(image: UIImage, ofURL url: URL, withTag tag: String?) {
    let key = url.absoluteString.replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: ":", with: "-")
    
    logger.info("Updating image with key \(key) to \(key)\(tag ?? "").")
    
    // Try to delete old file
    if let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first {
      
      let filename = cacheDir.appendingPathComponent("\(key).jpeg.cache")
      if FileManager.default.fileExists(atPath: filename.absoluteString) {
        do {
          try FileManager.default.removeItem(at: filename)
        } catch {
          logger.error("Error while deleting \(filename): \(error as NSObject).")
        }
      }
      
      save(image: image, withKey: "\(key)\(tag ?? "")" as NSString)
    }
  }
  
  // MARK: - Private functions
  private func save(image: UIImage, withKey key: NSString) {
    logger.info("Saving image with key \(key).")
    
    // Save to NSCache
    volatileCache.setObject(image, forKey: key)
    
    // Save to disk
    if let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first {
      if let data = image.jpegData(compressionQuality: 0.8) {
        let filename = cacheDir.appendingPathComponent("\(key).jpeg.cache")
        do {
          try data.write(to: filename)
        } catch {
          logger.error("Error while writing to \(filename): \(error as NSObject).")
        }
      }
    }
  }
  
  private func retrieve(fromKey key: NSString) -> UIImage? {
    logger.info("Retrieving image with key \(key).")
    
    // Try from NSCache
    if let image = volatileCache.object(forKey: key) {
      logger.debug("Image for key \(key) retrieved from NSCache.")
      return image
    }
    
    logger.debug("Image for key \(key) not found in NSCache.")
    
    // Try from disk
    if let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask).first {
      let filename = cacheDir.appendingPathComponent("\(key).jpeg.cache")
      if let image = UIImage(contentsOfFile: filename.path) {
        return image
      }
    }
    
    logger.debug("Image for key \(key) not found in persistent storage.")
    
    return nil
  }
}
