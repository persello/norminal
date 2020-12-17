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
        
        let changelog = prompt(text: "Changelog")

        incrementBuildNumber(xcodeproj: "Norminal.xcodeproj")
        buildApp(scheme: "Norminal")

        uploadToTestflight(username: "riccardo.persello@icloud.com", groups: ["Group A", "Group B"])
        setChangelog(appIdentifier: appIdentifier, changelog: changelog)
    }
    
    func alphaLane() {
        desc("Push a new alpha build to TestFlight")
        
        let changelog = prompt(text: "Changelog")

        incrementBuildNumber(xcodeproj: "Norminal.xcodeproj")
        buildApp(scheme: "Norminal")
        
        uploadToTestflight(username: "riccardo.persello@icloud.com", groups: ["Group A"])
        setChangelog(appIdentifier: appIdentifier, username: "riccardo.persello@icloud.com", changelog: changelog)
    }
}
