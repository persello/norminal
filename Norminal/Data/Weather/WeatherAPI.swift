//
//  WeatherAPI.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/12/2020.
//

import Foundation
import CoreLocation

struct WeatherAPIResponse {

  // Utilities
  let dayIconCodes: [Int: String] = [1000: "sun.max",
                                     1003: "cloud.sun",
                                     1063: "cloud.sun.rain",
                                     1087: "cloud.sun.bolt",
                                     1180: "cloud.sun.rain",
                                     1186: "cloud.sun.rain",
                                     1192: "cloud.sun.rain",
                                     1273: "cloud.sun.bolt"]

  let nightIconCodes: [Int: String] = [1000: "moon.stars",
                                       1003: "cloud.moon",
                                       1063: "cloud.moon.rain",
                                       1087: "cloud.moon.bolt",
                                       1180: "cloud.moon.rain",
                                       1186: "cloud.moon.rain",
                                       1192: "cloud.moon.rain",
                                       1273: "cloud.moon.bolt"]

  let genericIconCodes: [Int: String] = [1006: "cloud",
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

  // TODO: Add wind detection
  // TODO: getIcon function

  func getIcon() {

  }
}

class WeatherAPI {
  static var shared = WeatherAPI()

  func forecast(for location: CLLocationCoordinate2D,
                at date: Date,
                completion callback: @escaping (WeatherAPIResponse?) -> Void) {

  }
}
