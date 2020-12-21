// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
  
  func sentryLane() {
    downloadDsyms(username: "riccardo.persello@icloud.com", appIdentifier: appIdentifier)
    uploadSymbolsToSentry(authToken: "efad303f07e54c3c8d5ff9095ba839e891b3c34b6b6541649abba34dd5cdcf0e", orgSlug: "riccardo-persello", projectSlug: "norminal")
  }
  
  func betaLane() {
    desc("Push a new beta build to TestFlight")
    
    let changelog = prompt(text: "Changelog")
    
    incrementBuildNumber(xcodeproj: "Norminal.xcodeproj")
    buildApp(scheme: "Norminal")
    
    uploadToTestflight(username: "riccardo.persello@icloud.com", groups: ["Group A", "Group B"])
    // setChangelog(appIdentifier: appIdentifier, changelog: changelog)
    
    sentryLane()
  }
  
  func alphaLane() {
    desc("Push a new alpha build to TestFlight")
    
    let changelog = prompt(text: "Changelog")
    
    incrementBuildNumber(xcodeproj: "Norminal.xcodeproj")
    buildApp(scheme: "Norminal")
    
    uploadToTestflight(username: "riccardo.persello@icloud.com", groups: ["Group A"])
    // setChangelog(appIdentifier: appIdentifier, username: "riccardo.persello@icloud.com", changelog: changelog)
    
    sentryLane()
  }
}
