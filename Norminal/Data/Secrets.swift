//
//  Secrets.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/12/2020.
//

import Foundation
import os

struct SecretsRoot: Codable {

  // Internal structs
  struct SecretsWeatherAPI: Codable {
    let key: String
  }

  // Variables
  let weatherAPI: SecretsWeatherAPI
}

class SecretsManager {

  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Secrets manager")
  private let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist")!

  lazy var shared = SecretsManager()
  var root: SecretsRoot?

  init() {
    do {
      let data = try Data(contentsOf: url)
      self.root = try PropertyListDecoder().decode(SecretsRoot.self, from: data)
    } catch {
      logger.error("Error during initialization: \(error as NSObject).")
    }
  }
}
