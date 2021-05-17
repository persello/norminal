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

let trailblazerJSON = """
    {
    "fairings": {
    "reused": false,
    "recovery_attempt": false,
    "recovered": false,
    "ships": []
    },
    "links": {
    "patch": {
    "small": "https://images2.imgbox.com/3d/86/cnu0pan8_o.png",
    "large": "https://images2.imgbox.com/4b/bd/d8UxLh4q_o.png"
    },
    "reddit": {
    "campaign": null,
    "launch": null,
    "media": null,
    "recovery": null
    },
    "flickr": {
    "small": [],
    "original": []
    },
    "presskit": null,
    "webcast": "https://www.youtube.com/watch?v=v0w9p3U8860",
    "youtube_id": "v0w9p3U8860",
    "article": "http://www.spacex.com/news/2013/02/11/falcon-1-flight-3-mission-summary",
    "wikipedia": "https://en.wikipedia.org/wiki/Trailblazer_(satellite)"
    },
    "static_fire_date_utc": null,
    "static_fire_date_unix": null,
    "tbd": false,
    "net": false,
    "window": 0,
    "rocket": "5e9d0d95eda69955f709d1eb",
    "success": false,
    "details": "Residual stage 1 thrust led to collision between stage 1 and stage 2",
    "crew": [],
    "ships": [],
    "capsules": [],
    "payloads": [
    "5eb0e4b6b6c3bb0006eeb1e3",
    "5eb0e4b6b6c3bb0006eeb1e4"
    ],
    "launchpad": "5e9e4502f5090995de566f86",
    "auto_update": true,
    "launch_library_id": null,
    "failures": [
    {
    "time": 140,
    "altitude": 35,
    "reason": "residual stage-1 thrust led to collision between stage 1 and stage 2"
    }
    ],
    "flight_number": 3,
    "name": "Trailblazer",
    "date_utc": "2008-08-03T03:34:00.000Z",
    "date_unix": 1217734440,
    "date_local": "2008-08-03T15:34:00+12:00",
    "date_precision": "hour",
    "upcoming": false,
    "cores": [
    {
    "core": "5e9e289ef3591814873b2625",
    "flight": 1,
    "gridfins": false,
    "legs": false,
    "reused": false,
    "landing_attempt": false,
    "landing_success": null,
    "landing_type": null,
    "landpad": null
    }
    ],
    "id": "5eb87cdbffd86e000604b32c"
    }
""".data(using: .utf8)!

let slc40JSON = """
{
"name": "CCSFS SLC 40",
"full_name": "Cape Canaveral Space Force Station Space Launch Complex 40",
"locality": "Cape Canaveral",
"region": "Florida",
"timezone": "America/New_York",
"latitude": 28.5618571,
"longitude": -80.577366,
"launch_attempts": 70,
"launch_successes": 68,
"rockets": [
"5e9d0d95eda69973a809d1ec"
],
"launches": [
"5eb87cddffd86e000604b32f",
"5eb87cdeffd86e000604b330",
"5eb87cdfffd86e000604b331",
"5eb87ce0ffd86e000604b332",
"5eb87ce1ffd86e000604b333",
"5eb87ce2ffd86e000604b335",
"5eb87ce3ffd86e000604b336",
"5eb87ce4ffd86e000604b337",
"5eb87ce4ffd86e000604b338",
"5eb87ce5ffd86e000604b339",
"5eb87ce6ffd86e000604b33a",
"5eb87ce7ffd86e000604b33b",
"5eb87ce8ffd86e000604b33c",
"5eb87ceaffd86e000604b33d",
"5eb87ceaffd86e000604b33e",
"5eb87cecffd86e000604b33f",
"5eb87cedffd86e000604b340",
"5eb87ceeffd86e000604b341",
"5eb87cefffd86e000604b342",
"5eb87cf2ffd86e000604b344",
"5eb87cf3ffd86e000604b345",
"5eb87cf5ffd86e000604b346",
"5eb87cf6ffd86e000604b347",
"5eb87cf8ffd86e000604b348",
"5eb87cf9ffd86e000604b349",
"5eb87cfaffd86e000604b34a",
"5eb87cfbffd86e000604b34b",
"5eb87d0effd86e000604b35c",
"5eb87d10ffd86e000604b35e",
"5eb87d11ffd86e000604b35f",
"5eb87d15ffd86e000604b362",
"5eb87d16ffd86e000604b364",
"5eb87d18ffd86e000604b365",
"5eb87d1bffd86e000604b368",
"5eb87d1cffd86e000604b369",
"5eb87d1effd86e000604b36a",
"5eb87d20ffd86e000604b36c",
"5eb87d22ffd86e000604b36d",
"5eb87d26ffd86e000604b371",
"5eb87d27ffd86e000604b372",
"5eb87d2affd86e000604b374",
"5eb87d2effd86e000604b377",
"5eb87d30ffd86e000604b378",
"5eb87d36ffd86e000604b37b",
"5eb87d37ffd86e000604b37c",
"5eb87d39ffd86e000604b37d",
"5eb87d39ffd86e000604b37e",
"5eb87d3bffd86e000604b37f",
"5eb87d3cffd86e000604b380",
"5eb87d3fffd86e000604b382",
"5eb87d41ffd86e000604b383",
"5eb87d42ffd86e000604b384",
"5eb87d45ffd86e000604b387",
"5eb87d46ffd86e000604b389",
"5eb87d4affd86e000604b38b",
"5eb87d50ffd86e000604b394",
"5ed981d91f30554030d45c2a",
"5eb87d47ffd86e000604b38a",
"5ef6a2e70059c33cee4a8293",
"5eb87d4cffd86e000604b38d",
"5fb95b3f3a88ae63c954603c",
"5eb87d4bffd86e000604b38c",
"5eb87d4fffd86e000604b393",
"5fd386aa7faea57d297c86c1",
"5ff6554f9257f579ee3a6c5f",
"600f9a5e8f798e2a4d5f979c",
"600f9a718f798e2a4d5f979d",
"60428aafc041c16716f73cd7",
"60428ac4c041c16716f73cd8",
"605b4b6aaa5433645e37d03f"
],
"details": "SpaceX's primary Falcon 9 pad, where all east coast Falcon 9s launched prior to the AMOS-6 anomaly. Previously used alongside SLC-41 to launch Titan rockets for the US Air Force, the pad was heavily damaged by the AMOS-6 anomaly in September 2016. It returned to flight with CRS-13 on December 15, 2017, boasting an upgraded throwback-style Transporter-Erector modeled after that at LC-39A.",
"status": "active",
"id": "5e9e4501f509094ba4566f84"
}
""".data(using: .utf8)!

let falcon9JSON = """
  {
"height": {
  "meters": 70,
  "feet": 229.6
},
"diameter": {
  "meters": 3.7,
  "feet": 12
},
"mass": {
  "kg": 549054,
  "lb": 1207920
},
"first_stage": {
  "thrust_sea_level": {
    "kN": 7607,
    "lbf": 1710000
  },
  "thrust_vacuum": {
    "kN": 8227,
    "lbf": 1849500
  },
  "reusable": true,
  "engines": 9,
  "fuel_amount_tons": 385,
  "burn_time_sec": 162
},
"second_stage": {
  "thrust": {
    "kN": 934,
    "lbf": 210000
  },
  "payloads": {
    "composite_fairing": {
      "height": {
        "meters": 13.1,
        "feet": 43
      },
      "diameter": {
        "meters": 5.2,
        "feet": 17.1
      }
    },
    "option_1": "dragon"
  },
  "reusable": false,
  "engines": 1,
  "fuel_amount_tons": 90,
  "burn_time_sec": 397
},
"engines": {
  "isp": {
    "sea_level": 288,
    "vacuum": 312
  },
  "thrust_sea_level": {
    "kN": 845,
    "lbf": 190000
  },
  "thrust_vacuum": {
    "kN": 914,
    "lbf": 205500
  },
  "number": 9,
  "type": "merlin",
  "version": "1D+",
  "layout": "octaweb",
  "engine_loss_max": 2,
  "propellant_1": "liquid oxygen",
  "propellant_2": "RP-1 kerosene",
  "thrust_to_weight": 180.1
},
"landing_legs": {
  "number": 4,
  "material": "carbon fiber"
},
"payload_weights": [
  {
    "id": "leo",
    "name": "Low Earth Orbit",
    "kg": 22800,
    "lb": 50265
  },
  {
    "id": "gto",
    "name": "Geosynchronous Transfer Orbit",
    "kg": 8300,
    "lb": 18300
  },
  {
    "id": "mars",
    "name": "Mars Orbit",
    "kg": 4020,
    "lb": 8860
  }
],
"flickr_images": [
  "https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg",
  "https://farm4.staticflickr.com/3955/32915197674_eee74d81bb_b.jpg",
  "https://farm1.staticflickr.com/293/32312415025_6841e30bf1_b.jpg",
  "https://farm1.staticflickr.com/623/23660653516_5b6cb301d1_b.jpg",
  "https://farm6.staticflickr.com/5518/31579784413_d853331601_b.jpg",
  "https://farm1.staticflickr.com/745/32394687645_a9c54a34ef_b.jpg"
],
"name": "Falcon 9",
"type": "rocket",
"active": true,
"stages": 2,
"boosters": 0,
"cost_per_launch": 50000000,
"success_rate_pct": 98,
"first_flight": "2010-06-04",
"country": "United States",
"company": "SpaceX",
"wikipedia": "https://en.wikipedia.org/wiki/Falcon_9",
"description": "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.",
"id": "5e9d0d95eda69973a809d1ec"
}
""".data(using: .utf8)!

struct FakeData {
    static let shared = FakeData()

    var crewDragon: Launch?
    var nrol108: Launch?
    var trailblazer: Launch?
    var robertBehnken: Astronaut?
    var slc40: Launchpad?
    var falcon9: Rocket?

    private var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Fake data")

    init() {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.iso8601Full)
            crewDragon = try decoder.decode(Launch.self, from: crewDragonJSON)
            robertBehnken = try decoder.decode(Astronaut.self, from: robertBehnkenJSON)
            nrol108 = try decoder.decode(Launch.self, from: nrol108JSON)
            trailblazer = try decoder.decode(Launch.self, from: trailblazerJSON)
            slc40 = try decoder.decode(Launchpad.self, from: slc40JSON)
            falcon9 = try decoder.decode(Rocket.self, from: falcon9JSON)
        } catch {
            logger.error("Unhandled error while initializing fake data: \"\(error.localizedDescription)\"")
        }
    }
}
