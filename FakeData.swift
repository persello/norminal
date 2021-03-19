//
//  FakeLaunches.swift
//  Norminal
//
//  Created by Riccardo Persello on 10/10/2020.
//

import Foundation
import os

// swiftlint:disable line_length
let robertBehnkenJSON = """
  {
    "name": "Robert Behnken",
    "agency": "NASA",
    "image": "https://imgur.com/0smMgMH.png",
    "wikipedia": "https://en.wikipedia.org/wiki/Robert_L._Behnken",
    "launches": [
      "5eb87d46ffd86e000604b388"
    ],
    "status": "active",
    "id": "5ebf1a6e23a9a60006e03a7a"
  }
""".data(using: .utf8)!

let nrol108JSON = """
  {
    "fairings": {
      "reused": false,
      "recovery_attempt": true,
      "recovered": true,
      "ships": [
        "5ea6ed2e080df4000697c908",
        "5ea6ed2f080df4000697c90c"
      ]
    },
    "links": {
      "patch": {
        "small": "https://i.imgur.com/t9j2kJg.png",
        "large": "https://i.imgur.com/lSpAmBB.png"
      },
      "reddit": {
        "campaign": "https://www.reddit.com/r/spacex/comments/j7qqbg/nrol108_launch_campaign_thread/",
        "launch": "https://www.reddit.com/r/spacex/comments/ke9pmg/rspacex_nrol108_official_launch_discussion/",
        "media": null,
        "recovery": "https://www.reddit.com/r/spacex/comments/k2ts1q/rspacex_fleet_updates_discussion_thread/"
      },
      "flickr": {
        "small": [],
        "original": [
          "https://live.staticflickr.com/65535/50740257483_0f550f6a25_o.jpg",
          "https://live.staticflickr.com/65535/50740993291_57ef3f881b_o.jpg",
          "https://live.staticflickr.com/65535/50740257263_b41b843e85_o.jpg",
          "https://live.staticflickr.com/65535/50740993211_dc00af6dbb_o.jpg",
          "https://live.staticflickr.com/65535/50740257078_e46a6462df_o.jpg",
          "https://live.staticflickr.com/65535/50741096702_2a152bdf13_o.jpg",
          "https://live.staticflickr.com/65535/50740257323_e3e49fa2c6_o.jpg"
        ]
      },
      "presskit": null,
      "webcast": "https://youtu.be/9OeVwaFBkfE",
      "youtube_id": "9OeVwaFBkfE",
      "article": "https://spaceflightnow.com/2020/12/19/spacex-closes-out-record-year-of-launches-from-floridas-space-coast/",
      "wikipedia": "https://en.wikipedia.org/wiki/National_Reconnaissance_Office"
    },
    "static_fire_date_utc": null,
    "static_fire_date_unix": null,
    "tbd": false,
    "net": false,
    "window": null,
    "rocket": "5e9d0d95eda69973a809d1ec",
    "success": true,
    "details": "SpaceX will launch NROL-108 for the National Reconnaissance Office aboard a Falcon 9 from SLC-40, Cape Canaveral Air Force Station. The booster for this mission is expected to land at LZ-1.",
    "crew": [],
    "ships": [
      "5ea6ed2f080df4000697c90c",
      "5ea6ed2e080df4000697c908"
    ],
    "capsules": [],
    "payloads": [
      "5f839ac7818d8b59f5740d48"
    ],
    "launchpad": "5e9e4502f509094188566f88",
    "auto_update": true,
    "launch_library_id": null,
    "failures": [],
    "flight_number": 112,
    "name": "NROL-108",
    "date_utc": "2020-12-19T14:00:00.000Z",
    "date_unix": 1608386400,
    "date_local": "2020-12-19T09:00:00-05:00",
    "date_precision": "hour",
    "upcoming": false,
    "cores": [
      {
        "core": "5e9e28a7f359187afd3b2662",
        "flight": 5,
        "gridfins": true,
        "legs": true,
        "reused": true,
        "landing_attempt": true,
        "landing_success": true,
        "landing_type": "RTLS",
        "landpad": "5e9e3032383ecb267a34e7c7"
      }
    ],
    "id": "5f8399fb818d8b59f5740d43"
  }
""".data(using: .utf8)!

let crewDragonJSON = """
  {
    "fairings": null,
    "links": {
      "patch": {
        "small": "https://images2.imgbox.com/eb/0f/Vev7xkUX_o.png",
        "large": "https://images2.imgbox.com/ab/79/Wyc9K7fv_o.png"
      },
      "reddit": {
        "campaign": "https://www.reddit.com/r/spacex/comments/fjf6rr/dm2_launch_campaign_thread/",
        "launch": "https://www.reddit.com/r/spacex/comments/glwz6n/rspacex_cctcap_demonstration_mission_2_general",
        "media": "https://www.reddit.com/r/spacex/comments/gp1gf5/rspacex_dm2_media_thread_photographer_contest/",
        "recovery": "https://www.reddit.com/r/spacex/comments/gu5gkd/cctcap_demonstration_mission_2_stage_1_recovery/"
      },
      "flickr": {
        "small": [],
        "original": [
          "https://live.staticflickr.com/65535/49927519643_b43c6d4c44_o.jpg",
          "https://live.staticflickr.com/65535/49927519588_8a39a3994f_o.jpg",
          "https://live.staticflickr.com/65535/49928343022_6fb33cbd9c_o.jpg",
          "https://live.staticflickr.com/65535/49934168858_cacb00d790_o.jpg",
          "https://live.staticflickr.com/65535/49934682271_fd6a31becc_o.jpg",
          "https://live.staticflickr.com/65535/49956109906_f88d815772_o.jpg",
          "https://live.staticflickr.com/65535/49956109706_cffa847208_o.jpg",
          "https://live.staticflickr.com/65535/49956109671_859b323ede_o.jpg",
          "https://live.staticflickr.com/65535/49955609618_4cca01d581_o.jpg",
          "https://live.staticflickr.com/65535/49956396622_975c116b71_o.jpg",
          "https://live.staticflickr.com/65535/49955609378_9b77e5c771_o.jpg",
          "https://live.staticflickr.com/65535/49956396262_ef41c1d9b0_o.jpg"
        ]
      },
      "presskit": "https://www.nasa.gov/sites/default/files/atoms/files/commercialcrew_press_kit.pdf",
      "webcast": "https://youtu.be/xY96v0OIcK4",
      "youtube_id": "xY96v0OIcK4",
      "article": "https://spaceflightnow.com/2020/05/30/nasa-astronauts-launch-from-us-soil-for-first-time-in-nine-years/",
      "wikipedia": "https://en.wikipedia.org/wiki/Crew_Dragon_Demo-2"
    },
    "static_fire_date_utc": "2020-05-22T17:39:00.000Z",
    "static_fire_date_unix": 1590169140,
    "tbd": false,
    "net": false,
    "window": 0,
    "rocket": "5e9d0d95eda69973a809d1ec",
    "success": true,
    "details": "Crew Dragon Demo-2 (officially Crew Demo-2, SpaceX Demo-2, or Demonstration Mission-2)[a] was the first crewed test flight of the Crew Dragon spacecraft. The spacecraft, named Endeavour, launched on 30 May 2020 at 19:22:45 UTC[8][12][13] (3:22:45 PM EDT) on top of Falcon 9 Booster B1058.1, and carried NASA astronauts Douglas Hurley and Robert Behnken to the International Space Station in the first crewed orbital spaceflight launched from the United States since the final Space Shuttle mission, STS-135, in 2011, and the first ever operated by a commercial provider.[14] Demo-2 was also the first two-person orbital spaceflight launched from the United States since STS-4 in 1982.",
    "crew": [
      "5ebf1b7323a9a60006e03a7b",
      "5ebf1a6e23a9a60006e03a7a"
    ],
    "ships": [
      "5ea6ed30080df4000697c913",
      "5ea6ed2f080df4000697c90b",
      "5ea6ed2f080df4000697c90c",
      "5ea6ed2e080df4000697c909",
      "5ea6ed2f080df4000697c90d"
    ],
    "capsules": [
      "5e9e2c5df359188aba3b2676"
    ],
    "payloads": [
      "5eb0e4d1b6c3bb0006eeb257"
    ],
    "launchpad": "5e9e4502f509094188566f88",
    "auto_update": true,
    "failures": [],
    "flight_number": 94,
    "name": "CCtCap Demo Mission 2",
    "date_utc": "2020-05-30T19:22:00.000Z",
    "date_unix": 1590866520,
    "date_local": "2020-05-30T15:22:00-04:00",
    "date_precision": "hour",
    "upcoming": false,
    "cores": [
      {
        "core": "5e9e28a7f3591817f23b2663",
        "flight": 1,
        "gridfins": true,
        "legs": true,
        "reused": false,
        "landing_attempt": true,
        "landing_success": true,
        "landing_type": "ASDS",
        "landpad": "5e9e3032383ecb6bb234e7ca"
      }
    ],
    "id": "5eb87d46ffd86e000604b388"
  }
""".data(using: .utf8)!

struct FakeData {
    static let shared = FakeData()

    var crewDragon: Launch?
    var nrol108: Launch?
    var robertBehnken: Astronaut?

    private var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Fake data")

    init() {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.iso8601Full)
            self.crewDragon = try decoder.decode(Launch.self, from: crewDragonJSON)
            self.robertBehnken = try decoder.decode(Astronaut.self, from: robertBehnkenJSON)
            self.nrol108 = try decoder.decode(Launch.self, from: nrol108JSON)
        } catch {
            logger.error("Unhandled error while initializing fake data: \"\(error.localizedDescription)\"")
        }
    }
}
