// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
    func betaLane() {
        desc("Push a new beta build to TestFlight")
        incrementBuildNumber(xcodeproj: "Norminal.xcodeproj")
        buildApp(scheme: "Norminal")
        
        let changelog = prompt(text: "Changelog")
        setChangelog(appIdentifier: appIdentifier, changelog: changelog)
        uploadToTestflight(username: "riccardo.persello@icloud.com", groups: ["Group A", "Group B"])
    }
    
    func alphaLane() {
        desc("Push a new alpha build to TestFlight")
        incrementBuildNumber(xcodeproj: "Norminal.xcodeproj")
        buildApp(scheme: "Norminal")
        
        let changelog = prompt(text: "Changelog")
        setChangelog(appIdentifier: appIdentifier, changelog: changelog)
        uploadToTestflight(username: "riccardo.persello@icloud.com", groups: ["Group A"])
    }
}
