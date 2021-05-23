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

let ocislyJSON = """
{
"legacy_id": "OCISLY",
"model": "Marmac 304",
"type": "Barge",
"roles": [
"ASDS barge"
],
"imo": null,
"mmsi": null,
"abs": null,
"class": null,
"mass_kg": null,
"mass_lbs": null,
"year_built": 2015,
"home_port": "Port Canaveral",
"status": null,
"speed_kn": null,
"course_deg": null,
"latitude": 33.7291858,
"longitude": -118.262015,
"last_ais_update": null,
"link": null,
"image": "https://i.imgur.com/28dCx6G.jpg",
"launches": [
"5eb87cf2ffd86e000604b344",
"5eb87cf3ffd86e000604b345",
"5eb87cf6ffd86e000604b347",
"5eb87cf8ffd86e000604b348",
"5eb87cfaffd86e000604b34a",
"5eb87d00ffd86e000604b34f",
"5eb87d04ffd86e000604b353",
"5eb87d0cffd86e000604b35a",
"5eb87d0dffd86e000604b35b",
"5eb87d13ffd86e000604b360",
"5eb87d18ffd86e000604b365",
"5eb87d19ffd86e000604b366",
"5eb87d1effd86e000604b36a",
"5eb87d20ffd86e000604b36c",
"5eb87d22ffd86e000604b36d",
"5eb87d24ffd86e000604b36f",
"5eb87d2affd86e000604b374",
"5eb87d2bffd86e000604b375",
"5eb87d2dffd86e000604b376",
"5eb87d2effd86e000604b377",
"5eb87d30ffd86e000604b378",
"5eb87d35ffd86e000604b37a",
"5eb87d39ffd86e000604b37d",
"5eb87d3bffd86e000604b37f",
"5eb87d3cffd86e000604b380",
"5eb87d3fffd86e000604b382",
"5eb87d41ffd86e000604b383",
"5eb87d43ffd86e000604b385",
"5eb87d44ffd86e000604b386",
"5eb87d46ffd86e000604b388",
"5ed9819a1f30554030d45c29",
"5ed981d91f30554030d45c2a",
"5ef6a2090059c33cee4a828b",
"5ef6a2bf0059c33cee4a828c",
"5eb87d4cffd86e000604b38d",
"5fb95b3f3a88ae63c954603c",
"5eb87d4effd86e000604b391",
"5fd386aa7faea57d297c86c1",
"5ff6554f9257f579ee3a6c5f",
"600f9a5e8f798e2a4d5f979c",
"5fbfecfe54ceb10a5664c80b",
"600f9a8d8f798e2a4d5f979e",
"60428aafc041c16716f73cd7",
"60428ac4c041c16716f73cd8",
"5fe3af58b3467846b324215f",
"605b4b7daa5433645e37d040",
"6079bd1c9a06446e8c61bf76",
"605b4b95aa5433645e37d041"
],
"name": "Of Course I Still Love You",
"active": true,
"id": "5ea6ed30080df4000697c913"
}
""".data(using: .utf8)!

let lz1JSON = """
{
"name": "LZ-1",
"full_name": "Landing Zone 1",
"type": "RTLS",
"locality": "Cape Canaveral",
"region": "Florida",
"latitude": 28.485833,
"longitude": -80.544444,
"landing_attempts": 17,
"landing_successes": 16,
"wikipedia": "https://en.wikipedia.org/wiki/Landing_Zones_1_and_2",
"details": "SpaceX's first east coast landing pad is Landing Zone 1, where the historic first Falcon 9 landing occurred in December 2015. LC-13 was originally used as a launch pad for early Atlas missiles and rockets from Lockheed Martin. LC-1 was later expanded to include Landing Zone 2 for side booster RTLS Falcon Heavy missions, and it was first used in February 2018 for that purpose.",
"launches": [
"5eb87cefffd86e000604b342",
"5eb87cf9ffd86e000604b349",
"5eb87cfeffd86e000604b34d",
"5eb87d01ffd86e000604b350",
"5eb87d03ffd86e000604b352",
"5eb87d07ffd86e000604b356",
"5eb87d09ffd86e000604b358",
"5eb87d0effd86e000604b35c",
"5eb87d10ffd86e000604b35e",
"5eb87d13ffd86e000604b360",
"5eb87d26ffd86e000604b371",
"5eb87d2dffd86e000604b376",
"5eb87d35ffd86e000604b37a",
"5eb87d36ffd86e000604b37b",
"5eb87d42ffd86e000604b384",
"5eb87d47ffd86e000604b38a",
"5f8399fb818d8b59f5740d43"
],
"status": "active",
"id": "5e9e3032383ecb267a34e7c7"
}
""".data(using: .utf8)!

let b1051JSON = """
{
"block": 5,
"reuse_count": 8,
"rtls_attempts": 1,
"rtls_landings": 1,
"asds_attempts": 8,
"asds_landings": 8,
"last_update": "landed on OCISLY as of Mar 14, 2021. ",
"launches": [
"5eb87d2bffd86e000604b375",
"5eb87d31ffd86e000604b379",
"5eb87d3fffd86e000604b382",
"5eb87d44ffd86e000604b386",
"5ed9819a1f30554030d45c29",
"5ef6a2bf0059c33cee4a828c",
"5eb87d4bffd86e000604b38c",
"5fbfecce54ceb10a5664c80a",
"600f9a8d8f798e2a4d5f979e"
],
"serial": "B1051",
"status": "unknown",
"id": "5e9e28a6f35918c0803b265c"
}
""".data(using: .utf8)!

let roadsterPayloadJSON = """
{
"dragon": {
"capsule": null,
"mass_returned_kg": null,
"mass_returned_lbs": null,
"flight_time_sec": null,
"manifest": null,
"water_landing": null,
"land_landing": null
},
"name": "Tesla Roadster",
"type": "Satellite",
"reused": false,
"launch": "5eb87d13ffd86e000604b360",
"customers": [
"SpaceX"
],
"norad_ids": [
43205
],
"nationalities": [
"United States"
],
"manufacturers": [
"Tesla"
],
"mass_kg": 1350,
"mass_lbs": 2976.2,
"orbit": "HCO",
"reference_system": "heliocentric",
"regime": null,
"longitude": null,
"semi_major_axis_km": 9943.766,
"eccentricity": 0.3404246,
"periapsis_km": 180.528,
"apoapsis_km": 6950.733,
"inclination_deg": 29.0185,
"period_min": 164.469,
"lifespan_years": 3500000,
"epoch": "2018-02-06T22:36:19.000Z",
"mean_motion": 8.75540848,
"raan": 287.358,
"arg_of_pericenter": 180.027,
"mean_anomaly": 180.584,
"id": "5eb0e4c6b6c3bb0006eeb21c"
}
""".data(using: .utf8)!

var crew2PayloadJSON = """
{
"dragon": {
"capsule": "5e9e2c5df359188aba3b2676",
"mass_returned_kg": null,
"mass_returned_lbs": null,
"flight_time_sec": null,
"manifest": null,
"water_landing": null,
"land_landing": null
},
"name": "Crew-2",
"type": "Crew Dragon",
"reused": true,
"launch": "5fe3af58b3467846b324215f",
"customers": [
"NASA (CCtCap)"
],
"norad_ids": [
48209
],
"nationalities": [
"United States"
],
"manufacturers": [
"SpaceX"
],
"mass_kg": null,
"mass_lbs": null,
"orbit": "ISS",
"reference_system": "geocentric",
"regime": "low-earth",
"longitude": null,
"semi_major_axis_km": 6797.87,
"eccentricity": 0.0002608,
"periapsis_km": 417.962,
"apoapsis_km": 421.508,
"inclination_deg": 51.644,
"period_min": 92.965,
"lifespan_years": null,
"epoch": "2021-05-02T13:26:57.000Z",
"mean_motion": 15.48971771,
"raan": 208.406,
"arg_of_pericenter": 308.669,
"mean_anomaly": 182.6347,
"id": "5fe3b3adb3467846b3242173"
}
""".data(using: .utf8)!

let starlink22PayloadJSON = """
{
"dragon": {
"capsule": null,
"mass_returned_kg": null,
"mass_returned_lbs": null,
"flight_time_sec": null,
"manifest": null,
"water_landing": null,
"land_landing": null
},
"name": "Starlink-22",
"type": "Satellite",
"reused": false,
"launch": "60428aafc041c16716f73cd7",
"customers": [
"SpaceX"
],
"norad_ids": [],
"nationalities": [
"United States"
],
"manufacturers": [
"SpaceX"
],
"mass_kg": 15600,
"mass_lbs": 34392,
"orbit": "VLEO",
"reference_system": "geocentric",
"regime": "very-low-earth",
"longitude": null,
"semi_major_axis_km": null,
"eccentricity": null,
"periapsis_km": null,
"apoapsis_km": null,
"inclination_deg": null,
"period_min": null,
"lifespan_years": null,
"epoch": null,
"mean_motion": null,
"raan": null,
"arg_of_pericenter": null,
"mean_anomaly": null,
"id": "60428afbc041c16716f73cdd"
}
""".data(using: .utf8)!

let c207JSON = """
{
"reuse_count": 0,
"water_landings": 0,
"land_landings": 0,
"last_update": "Docked to pressurized mating adapter PMA-2 on the Harmony module of the ISS on 17 Nov 2020",
"launches": [
"5eb87d4dffd86e000604b38e"
],
"serial": "C207",
"status": "active",
"type": "Dragon 2.0",
"id": "5f6f99fddcfdf403df379709"
}
""".data(using: .utf8)!

let dragon2JSON = """
{
"heat_shield": {
"material": "PICA-X",
"size_meters": 3.6,
"temp_degrees": 3000,
"dev_partner": "NASA"
},
"launch_payload_mass": {
"kg": 6000,
"lb": 13228
},
"launch_payload_vol": {
"cubic_meters": 25,
"cubic_feet": 883
},
"return_payload_mass": {
"kg": 3000,
"lb": 6614
},
"return_payload_vol": {
"cubic_meters": 11,
"cubic_feet": 388
},
"pressurized_capsule": {
"payload_volume": {
"cubic_meters": 11,
"cubic_feet": 388
}
},
"trunk": {
"trunk_volume": {
"cubic_meters": 14,
"cubic_feet": 494
},
"cargo": {
"solar_array": 2,
"unpressurized_cargo": true
}
},
"height_w_trunk": {
"meters": 7.2,
"feet": 23.6
},
"diameter": {
"meters": 3.7,
"feet": 12
},
"first_flight": "2019-03-02",
"flickr_images": [
"https://farm8.staticflickr.com/7647/16581815487_6d56cb32e1_b.jpg",
"https://farm1.staticflickr.com/780/21119686299_c88f63e350_b.jpg",
"https://farm9.staticflickr.com/8588/16661791299_a236e2f5dc_b.jpg"
],
"name": "Dragon 2",
"type": "capsule",
"active": true,
"crew_capacity": 7,
"sidewall_angle_deg": 15,
"orbit_duration_yr": 2,
"dry_mass_kg": 6350,
"dry_mass_lb": 14000,
"thrusters": [
{
"type": "Draco",
"amount": 18,
"pods": 4,
"fuel_1": "nitrogen tetroxide",
"fuel_2": "monomethylhydrazine",
"isp": 300,
"thrust": {
"kN": 0.4,
"lbf": 90
}
},
{
"type": "SuperDraco",
"amount": 8,
"pods": 4,
"fuel_1": "dinitrogen tetroxide",
"fuel_2": "monomethylhydrazine",
"isp": 235,
"thrust": {
"kN": 71,
"lbf": 16000
}
}
],
"wikipedia": "https://en.wikipedia.org/wiki/Dragon_2",
"description": "Dragon 2 (also Crew Dragon, Dragon V2, or formerly DragonRider) is the second version of the SpaceX Dragon spacecraft, which will be a human-rated vehicle. It includes a set of four side-mounted thruster pods with two SuperDraco engines each, which can serve as a launch escape system or launch abort system (LAS). In addition, it has much larger windows, new flight computers and avionics, and redesigned solar arrays, and a modified outer mold line from the initial cargo Dragon that has been flying for several years.",
"id": "5e9d058859b1ffd8e2ad5f90"
}
""".data(using: .utf8)!

let firstStarlinkJSON = """
{
"spaceTrack": {
"CCSDS_OMM_VERS": "2.0",
"COMMENT": "GENERATED VIA SPACE-TRACK.ORG API",
"CREATION_DATE": "2020-10-13T04:16:08",
"ORIGINATOR": "18 SPCS",
"OBJECT_NAME": "STARLINK-30",
"OBJECT_ID": "2019-029K",
"CENTER_NAME": "EARTH",
"REF_FRAME": "TEME",
"TIME_SYSTEM": "UTC",
"MEAN_ELEMENT_THEORY": "SGP4",
"EPOCH": "2020-10-13T02:56:59.566560",
"MEAN_MOTION": 16.43170483,
"ECCENTRICITY": 0.0003711,
"INCLINATION": 52.9708,
"RA_OF_ASC_NODE": 332.0356,
"ARG_OF_PERICENTER": 120.7278,
"MEAN_ANOMALY": 242.0157,
"EPHEMERIS_TYPE": 0,
"CLASSIFICATION_TYPE": "U",
"NORAD_CAT_ID": 44244,
"ELEMENT_SET_NO": 999,
"REV_AT_EPOCH": 7775,
"BSTAR": 0.0022139,
"MEAN_MOTION_DOT": 0.47180237,
"MEAN_MOTION_DDOT": 0.000012426,
"SEMIMAJOR_AXIS": 6535.519,
"PERIOD": 87.635,
"APOAPSIS": 159.809,
"PERIAPSIS": 154.958,
"OBJECT_TYPE": "PAYLOAD",
"RCS_SIZE": "LARGE",
"COUNTRY_CODE": "US",
"LAUNCH_DATE": "2019-05-24",
"SITE": "AFETR",
"DECAY_DATE": "2020-10-13",
"DECAYED": 1,
"FILE": 2850561,
"GP_ID": 163365918,
"TLE_LINE0": "0 STARLINK-30",
"TLE_LINE1": "1 44244U 19029K   20287.12291165  .47180237  12426-4  22139-2 0  9995",
"TLE_LINE2": "2 44244  52.9708 332.0356 0003711 120.7278 242.0157 16.43170483 77756"
},
"version": "v0.9",
"launch": "5eb87d30ffd86e000604b378",
"longitude": null,
"latitude": null,
"height_km": null,
"velocity_kms": null,
"id": "5eed770f096e59000698560d"
}
""".data(using: .utf8)!

let roadsterJSON = """
{
"flickr_images": [
"https://farm5.staticflickr.com/4615/40143096241_11128929df_b.jpg",
"https://farm5.staticflickr.com/4702/40110298232_91b32d0cc0_b.jpg",
"https://farm5.staticflickr.com/4676/40110297852_5e794b3258_b.jpg",
"https://farm5.staticflickr.com/4745/40110304192_6e3e9a7a1b_b.jpg"
],
"name": "Elon Musk's Tesla Roadster",
"launch_date_utc": "2018-02-06T20:45:00.000Z",
"launch_date_unix": 1517949900,
"launch_mass_kg": 1350,
"launch_mass_lbs": 2976,
"norad_id": 43205,
"epoch_jd": 2459337.941215278,
"orbit_type": "heliocentric",
"apoapsis_au": 1.664449048153271,
"periapsis_au": 0.9857710972751846,
"semi_major_axis_au": 45.43124479617391,
"eccentricity": 0.25608361329861,
"inclination": 1.075789467632119,
"longitude": 316.9264658561093,
"periapsis_arg": 177.6835102337537,
"period_days": 557.1554200660054,
"speed_kph": 6650.582710078296,
"speed_mph": 4132.479229144061,
"earth_distance_km": 51664571.57285332,
"earth_distance_mi": 32102866.50279544,
"mars_distance_km": 276365099.3763419,
"mars_distance_mi": 171725258.16457692,
"wikipedia": "https://en.wikipedia.org/wiki/Elon_Musk%27s_Tesla_Roadster",
"video": "https://youtu.be/wbSwFU6tY1c",
"details": "Elon Musk's Tesla Roadster is an electric sports car that served as the dummy payload for the February 2018 Falcon Heavy test flight and is now an artificial satellite of the Sun. Starman, a mannequin dressed in a spacesuit, occupies the driver's seat. The car and rocket are products of Tesla and SpaceX. This 2008-model Roadster was previously used by Musk for commuting, and is the only consumer car sent into space.",
"id": "5eb75f0842fea42237d7f3f4"
}
""".data(using: .utf8)!

let bunchOfStarlinksJSON = """
[{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-10-13T04:16:08","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-30","OBJECT_ID":"2019-029K","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-10-13T02:56:59.566560","MEAN_MOTION":16.43170483,"ECCENTRICITY":0.0003711,"INCLINATION":52.9708,"RA_OF_ASC_NODE":332.0356,"ARG_OF_PERICENTER":120.7278,"MEAN_ANOMALY":242.0157,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44244,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7775,"BSTAR":0.0022139,"MEAN_MOTION_DOT":0.47180237,"MEAN_MOTION_DDOT":0.000012426,"SEMIMAJOR_AXIS":6535.519,"PERIOD":87.635,"APOAPSIS":159.809,"PERIAPSIS":154.958,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-10-13","DECAYED":1,"FILE":2850561,"GP_ID":163365918,"TLE_LINE0":"0 STARLINK-30","TLE_LINE1":"1 44244U 19029K   20287.12291165  .47180237  12426-4  22139-2 0  9995","TLE_LINE2":"2 44244  52.9708 332.0356 0003711 120.7278 242.0157 16.43170483 77756"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed770f096e59000698560d"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-28T19:26:08","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-74","OBJECT_ID":"2019-029BL","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-28T18:35:08.710368","MEAN_MOTION":16.29892189,"ECCENTRICITY":0.0002076,"INCLINATION":52.9971,"RA_OF_ASC_NODE":48.1405,"ARG_OF_PERICENTER":323.1313,"MEAN_ANOMALY":37.5805,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44293,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7653,"BSTAR":0.0024534,"MEAN_MOTION_DOT":0.1135935,"MEAN_MOTION_DDOT":0.000012115,"SEMIMAJOR_AXIS":6570.966,"PERIOD":88.349,"APOAPSIS":194.195,"PERIAPSIS":191.467,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-29","DECAYED":1,"FILE":2837086,"GP_ID":162391575,"TLE_LINE0":"0 STARLINK-74","TLE_LINE1":"1 44293U 19029BL  20272.77440637  .11359350  12115-4  24534-2 0  9995","TLE_LINE2":"2 44293  52.9971  48.1405 0002076 323.1313  37.5805 16.29892189 76534"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed770f096e59000698560e"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-10-13T17:46:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-29","OBJECT_ID":"2019-029J","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-10-13T17:09:39.946752","MEAN_MOTION":16.50981164,"ECCENTRICITY":0.0008105,"INCLINATION":52.9786,"RA_OF_ASC_NODE":228.8138,"ARG_OF_PERICENTER":330.1078,"MEAN_ANOMALY":31.0927,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44243,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7928,"BSTAR":0.00010982,"MEAN_MOTION_DOT":0.11982673,"MEAN_MOTION_DDOT":0.000012791,"SEMIMAJOR_AXIS":6514.89,"PERIOD":87.22,"APOAPSIS":142.035,"PERIAPSIS":131.474,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-10-13","DECAYED":1,"FILE":2851295,"GP_ID":163381397,"TLE_LINE0":"0 STARLINK-29","TLE_LINE1":"1 44243U 19029J   20287.71504568  .11982673  12791-4  10982-3 0  9997","TLE_LINE2":"2 44243  52.9786 228.8138 0008105 330.1078  31.0927 16.50981164 79283"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed770f096e59000698560f"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-05-19T06:36:11","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-76","OBJECT_ID":"2019-029BE","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-05-19T00:26:47.139360","MEAN_MOTION":15.57110828,"ECCENTRICITY":0.0004326,"INCLINATION":52.9945,"RA_OF_ASC_NODE":42.5107,"ARG_OF_PERICENTER":129.4613,"MEAN_ANOMALY":230.678,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44287,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":11213,"BSTAR":0.00077028,"MEAN_MOTION_DOT":0.00056779,"MEAN_MOTION_DDOT":0,"SEMIMAJOR_AXIS":6774.161,"PERIOD":92.479,"APOAPSIS":398.956,"PERIAPSIS":393.095,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":null,"DECAYED":0,"FILE":3038272,"GP_ID":177470252,"TLE_LINE0":"0 STARLINK-76","TLE_LINE1":"1 44287U 19029BE  21139.01860115  .00056779  00000-0  77028-3 0  9995","TLE_LINE2":"2 44287  52.9945  42.5107 0004326 129.4613 230.6780 15.57110828112133"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":-70.61521741360424,"latitude":35.07213968397683,"height_km":398.16973111329935,"velocity_kms":7.676266787209534,"id":"5eed770f096e590006985610"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-02T18:57:38","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-23","OBJECT_ID":"2019-029C","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-02T05:50:39.789312","MEAN_MOTION":16.40837491,"ECCENTRICITY":0.0004551,"INCLINATION":52.9945,"RA_OF_ASC_NODE":186.9776,"ARG_OF_PERICENTER":271.9057,"MEAN_ANOMALY":198.4437,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44237,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7120,"BSTAR":0.0015299,"MEAN_MOTION_DOT":0.23336896,"MEAN_MOTION_DDOT":0.000012391,"SEMIMAJOR_AXIS":6541.712,"PERIOD":87.76,"APOAPSIS":166.554,"PERIAPSIS":160.6,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-02","DECAYED":1,"FILE":2813120,"GP_ID":160599026,"TLE_LINE0":"0 STARLINK-23","TLE_LINE1":"1 44237U 19029C   20246.24351608 +.23336896 +12391-4 +15299-2 0  9992","TLE_LINE2":"2 44237 052.9945 186.9776 0004551 271.9057 198.4437 16.40837491071205"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed770f096e590006985611"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-08-09T19:11:44","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-22","OBJECT_ID":"2019-029B","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-08-09T13:16:33.420576","MEAN_MOTION":16.42066597,"ECCENTRICITY":0.0004178,"INCLINATION":52.9807,"RA_OF_ASC_NODE":260.6619,"ARG_OF_PERICENTER":316.6235,"MEAN_ANOMALY":43.5158,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44236,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":6921,"BSTAR":0.0017311,"MEAN_MOTION_DOT":0.30875389,"MEAN_MOTION_DDOT":0.000012472,"SEMIMAJOR_AXIS":6538.447,"PERIOD":87.694,"APOAPSIS":163.044,"PERIAPSIS":157.581,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-08-09","DECAYED":1,"FILE":2798784,"GP_ID":159069947,"TLE_LINE0":"0 STARLINK-22","TLE_LINE1":"1 44236U 19029B   20222.55316459 +.30875389 +12472-4 +17311-2 0  9994","TLE_LINE2":"2 44236 052.9807 260.6619 0004178 316.6235 043.5158 16.42066597069218"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed770f096e590006985612"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-04-10T10:26:10","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-26","OBJECT_ID":"2019-029F","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-04-10T10:04:00.819552","MEAN_MOTION":16.41561846,"ECCENTRICITY":0.0004843,"INCLINATION":52.9634,"RA_OF_ASC_NODE":161.2403,"ARG_OF_PERICENTER":7.8568,"MEAN_ANOMALY":353.8836,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44240,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":10601,"BSTAR":0.0012328,"MEAN_MOTION_DOT":0.20637293,"MEAN_MOTION_DDOT":0.000012492,"SEMIMAJOR_AXIS":6539.788,"PERIOD":87.721,"APOAPSIS":164.82,"PERIAPSIS":158.486,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2021-04-10","DECAYED":1,"FILE":3013724,"GP_ID":175267022,"TLE_LINE0":"0 STARLINK-26","TLE_LINE1":"1 44240U 19029F   21100.41945393  .20637293  12492-4  12328-2 0  9999","TLE_LINE2":"2 44240  52.9634 161.2403 0004843   7.8568 353.8836 16.41561846106011"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed770f096e590006985613"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-26T00:36:08","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-27","OBJECT_ID":"2019-029G","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-25T23:58:24.572928","MEAN_MOTION":16.44528987,"ECCENTRICITY":0.0005013,"INCLINATION":52.9952,"RA_OF_ASC_NODE":62.9276,"ARG_OF_PERICENTER":292.5876,"MEAN_ANOMALY":67.3813,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44241,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7502,"BSTAR":0.00090269,"MEAN_MOTION_DOT":0.27533098,"MEAN_MOTION_DDOT":0.000012522,"SEMIMAJOR_AXIS":6531.919,"PERIOD":87.563,"APOAPSIS":157.058,"PERIAPSIS":150.509,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-26","DECAYED":1,"FILE":2834145,"GP_ID":162165742,"TLE_LINE0":"0 STARLINK-27","TLE_LINE1":"1 44241U 19029G   20269.99889552  .27533098  12522-4  90269-3 0  9992","TLE_LINE2":"2 44241  52.9952  62.9276 0005013 292.5876  67.3813 16.44528987 75025"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed770f096e590006985614"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-08-23T05:06:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-58","OBJECT_ID":"2019-029AM","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-08-23T03:09:46.298304","MEAN_MOTION":16.49769755,"ECCENTRICITY":0.0010115,"INCLINATION":53.006,"RA_OF_ASC_NODE":191.4104,"ARG_OF_PERICENTER":188.7689,"MEAN_ANOMALY":171.4914,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44270,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7027,"BSTAR":0.0001307,"MEAN_MOTION_DOT":0.12051508,"MEAN_MOTION_DDOT":0.000012468,"SEMIMAJOR_AXIS":6518.078,"PERIOD":87.284,"APOAPSIS":146.536,"PERIAPSIS":133.35,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-08-23","DECAYED":1,"FILE":2806775,"GP_ID":159934884,"TLE_LINE0":"0 STARLINK-58","TLE_LINE1":"1 44270U 19029AM  20236.13178586  .12051508  12468-4  13070-3 0  9991","TLE_LINE2":"2 44270  53.0060 191.4104 0010115 188.7689 171.4914 16.49769755 70270"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed770f096e590006985615"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-08-29T09:36:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"TINTIN A","OBJECT_ID":"2018-020B","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-08-29T07:40:05.480832","MEAN_MOTION":16.40201759,"ECCENTRICITY":0.0015282,"INCLINATION":97.4245,"RA_OF_ASC_NODE":260.1382,"ARG_OF_PERICENTER":265.467,"MEAN_ANOMALY":95.5903,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":43216,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":14020,"BSTAR":0.0016505,"MEAN_MOTION_DOT":0.26379725,"MEAN_MOTION_DDOT":0.000002565,"SEMIMAJOR_AXIS":6543.402,"PERIOD":87.794,"APOAPSIS":175.267,"PERIAPSIS":155.268,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2018-02-22","SITE":"AFWTR","DECAY_DATE":"2020-08-29","DECAYED":1,"FILE":2810670,"GP_ID":160342842,"TLE_LINE0":"0 TINTIN A","TLE_LINE1":"1 43216U 18020B   20242.31950788  .26379725  25650-5  16505-2 0  9991","TLE_LINE2":"2 43216  97.4245 260.1382 0015282 265.4670  95.5903 16.40201759140202"},"version":"prototype","launch":"5eb87d14ffd86e000604b361","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed770f096e590006985616"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-08-08T05:36:08","ORIGINATOR":"18 SPCS","OBJECT_NAME":"TINTIN B","OBJECT_ID":"2018-020C","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-08-08T00:27:11.780640","MEAN_MOTION":16.48446726,"ECCENTRICITY":0.0015584,"INCLINATION":97.4319,"RA_OF_ASC_NODE":238.058,"ARG_OF_PERICENTER":250.5191,"MEAN_ANOMALY":169.7925,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":43217,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":13685,"BSTAR":0.00047877,"MEAN_MOTION_DOT":0.36665659,"MEAN_MOTION_DDOT":0.0000026093,"SEMIMAJOR_AXIS":6521.566,"PERIOD":87.354,"APOAPSIS":153.594,"PERIAPSIS":133.267,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2018-02-22","SITE":"AFWTR","DECAY_DATE":"2020-08-08","DECAYED":1,"FILE":2797813,"GP_ID":158988627,"TLE_LINE0":"0 TINTIN B","TLE_LINE1":"1 43217U 18020C   20221.01888635  .36665659  26093-5  47877-3 0  9991","TLE_LINE2":"2 43217  97.4319 238.0580 0015584 250.5191 169.7925 16.48446726136854"},"version":"prototype","launch":"5eb87d14ffd86e000604b361","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed770f096e590006985617"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-05-19T06:26:11","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-68","OBJECT_ID":"2019-029AW","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-05-19T02:30:12.034944","MEAN_MOTION":15.86406161,"ECCENTRICITY":0.000516,"INCLINATION":52.9911,"RA_OF_ASC_NODE":12.6985,"ARG_OF_PERICENTER":201.1329,"MEAN_ANOMALY":158.9481,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44279,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":11144,"BSTAR":0.0010551,"MEAN_MOTION_DOT":0.00278958,"MEAN_MOTION_DDOT":0,"SEMIMAJOR_AXIS":6690.505,"PERIOD":90.771,"APOAPSIS":315.823,"PERIAPSIS":308.918,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":null,"DECAYED":0,"FILE":3038216,"GP_ID":177468635,"TLE_LINE0":"0 STARLINK-68","TLE_LINE1":"1 44279U 19029AW  21139.10430596  .00278958  00000-0  10551-2 0  9994","TLE_LINE2":"2 44279  52.9911  12.6985 0005160 201.1329 158.9481 15.86406161111441"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":-136.91331907963013,"latitude":-6.654149495880495,"height_km":316.2898657972801,"velocity_kms":7.717509403477879,"id":"5eed770f096e590006985618"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-10-01T07:56:08","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-31","OBJECT_ID":"2019-029A","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-10-01T07:31:19.437888","MEAN_MOTION":16.46847225,"ECCENTRICITY":0.0009041,"INCLINATION":52.9736,"RA_OF_ASC_NODE":36.3928,"ARG_OF_PERICENTER":295.9879,"MEAN_ANOMALY":160.3065,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44235,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7697,"BSTAR":0.00018159,"MEAN_MOTION_DOT":0.09808971,"MEAN_MOTION_DDOT":0.000012623,"SEMIMAJOR_AXIS":6525.788,"PERIOD":87.439,"APOAPSIS":153.553,"PERIAPSIS":141.753,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-10-01","DECAYED":1,"FILE":2839167,"GP_ID":162539263,"TLE_LINE0":"0 STARLINK-31","TLE_LINE1":"1 44235U 19029A   20275.31341942  .09808971  12623-4  18159-3 0  9999","TLE_LINE2":"2 44235  52.9736  36.3928 0009041 295.9879 160.3065 16.46847225 76971"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed770f096e590006985619"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-08-21T07:56:08","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-28","OBJECT_ID":"2019-029H","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-08-21T07:11:00.591360","MEAN_MOTION":16.52223162,"ECCENTRICITY":0.000603,"INCLINATION":52.9881,"RA_OF_ASC_NODE":190.9995,"ARG_OF_PERICENTER":255.8328,"MEAN_ANOMALY":104.4665,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44242,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7008,"BSTAR":0.00010198,"MEAN_MOTION_DOT":0.13214775,"MEAN_MOTION_DDOT":0.000012681,"SEMIMAJOR_AXIS":6511.624,"PERIOD":87.155,"APOAPSIS":137.416,"PERIAPSIS":129.563,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-08-21","DECAYED":1,"FILE":2805764,"GP_ID":159809210,"TLE_LINE0":"0 STARLINK-28","TLE_LINE1":"1 44242U 19029H   20234.29931240  .13214775  12681-4  10198-3 0  9992","TLE_LINE2":"2 44242  52.9881 190.9995 0006030 255.8328 104.4665 16.52223162 70086"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed770f096e59000698561a"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-05-19T14:36:10","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-61","OBJECT_ID":"2019-029Q","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-05-19T05:37:13.434528","MEAN_MOTION":15.21399513,"ECCENTRICITY":0.0005523,"INCLINATION":53.005,"RA_OF_ASC_NODE":97.3845,"ARG_OF_PERICENTER":347.8095,"MEAN_ANOMALY":12.2766,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44249,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":11034,"BSTAR":0.00028891,"MEAN_MOTION_DOT":0.00006243,"MEAN_MOTION_DDOT":0,"SEMIMAJOR_AXIS":6879.755,"PERIOD":94.65,"APOAPSIS":505.42,"PERIAPSIS":497.821,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":null,"DECAYED":0,"FILE":3038428,"GP_ID":177473013,"TLE_LINE0":"0 STARLINK-61","TLE_LINE1":"1 44249U 19029Q   21139.23418327  .00006243  00000-0  28891-3 0  9996","TLE_LINE2":"2 44249  53.0050  97.3845 0005523 347.8095  12.2766 15.21399513110347"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":154.5877383319083,"latitude":-25.459913254355993,"height_km":511.7885351552259,"velocity_kms":7.6063940880175585,"id":"5eed7713096e59000698561b"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-04T05:36:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-34","OBJECT_ID":"2019-029P","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-02T21:35:24.900000","MEAN_MOTION":16.46912557,"ECCENTRICITY":0.0003683,"INCLINATION":52.9949,"RA_OF_ASC_NODE":139.2923,"ARG_OF_PERICENTER":270.312,"MEAN_ANOMALY":109.3827,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44248,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7185,"BSTAR":0.0010158,"MEAN_MOTION_DOT":0.4994095,"MEAN_MOTION_DDOT":0.000012557,"SEMIMAJOR_AXIS":6525.615,"PERIOD":87.436,"APOAPSIS":149.883,"PERIAPSIS":145.077,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-03","DECAYED":1,"FILE":2813952,"GP_ID":160681636,"TLE_LINE0":"0 STARLINK-34","TLE_LINE1":"1 44248U 19029P   20246.89959375  .49940950  12557-4  10158-2 0  9993","TLE_LINE2":"2 44248  52.9949 139.2923 0003683 270.3120 109.3827 16.46912557 71853"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698561c"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-16T03:06:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-37","OBJECT_ID":"2019-029S","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-16T01:21:06.048000","MEAN_MOTION":16.36747412,"ECCENTRICITY":0.000955,"INCLINATION":52.9632,"RA_OF_ASC_NODE":112.3361,"ARG_OF_PERICENTER":277.6232,"MEAN_ANOMALY":82.3871,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44251,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7337,"BSTAR":0.00032764,"MEAN_MOTION_DOT":0.03126518,"MEAN_MOTION_DDOT":0.000012276,"SEMIMAJOR_AXIS":6552.606,"PERIOD":87.979,"APOAPSIS":180.728,"PERIAPSIS":168.213,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-16","DECAYED":1,"FILE":2824445,"GP_ID":161469685,"TLE_LINE0":"0 STARLINK-37","TLE_LINE1":"1 44251U 19029S   20260.05632000  .03126518  12276-4  32764-3 0  9996","TLE_LINE2":"2 44251  52.9632 112.3361 0009550 277.6232  82.3871 16.36747412 73370"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698561d"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-08-29T04:46:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-33","OBJECT_ID":"2019-029N","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-08-29T03:01:31.755936","MEAN_MOTION":16.51840845,"ECCENTRICITY":0.000774,"INCLINATION":52.9823,"RA_OF_ASC_NODE":151.0046,"ARG_OF_PERICENTER":270.8593,"MEAN_ANOMALY":89.275,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44247,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7137,"BSTAR":0.00013439,"MEAN_MOTION_DOT":0.16714812,"MEAN_MOTION_DDOT":0.000012698,"SEMIMAJOR_AXIS":6512.629,"PERIOD":87.175,"APOAPSIS":139.535,"PERIAPSIS":129.453,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-08-29","DECAYED":1,"FILE":2810461,"GP_ID":160338188,"TLE_LINE0":"0 STARLINK-33","TLE_LINE1":"1 44247U 19029N   20242.12606199  .16714812  12698-4  13439-3 0  9999","TLE_LINE2":"2 44247  52.9823 151.0046 0007740 270.8593  89.2750 16.51840845 71372"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698561e"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-01T10:06:10","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-25","OBJECT_ID":"2019-029E","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-01T07:12:09.420192","MEAN_MOTION":16.43061467,"ECCENTRICITY":0.0002866,"INCLINATION":53.0083,"RA_OF_ASC_NODE":191.8643,"ARG_OF_PERICENTER":256.419,"MEAN_ANOMALY":224.7475,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44239,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7098,"BSTAR":0.0037768,"MEAN_MOTION_DOT":0.76604941,"MEAN_MOTION_DDOT":0.000012441,"SEMIMAJOR_AXIS":6535.808,"PERIOD":87.641,"APOAPSIS":159.546,"PERIAPSIS":155.8,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-01","DECAYED":1,"FILE":2812380,"GP_ID":160503762,"TLE_LINE0":"0 STARLINK-25","TLE_LINE1":"1 44239U 19029E   20245.30010903  .76604941  12441-4  37768-2 0  9998","TLE_LINE2":"2 44239  53.0083 191.8643 0002866 256.4190 224.7475 16.43061467 70987"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698561f"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-18T08:56:08","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-39","OBJECT_ID":"2019-029U","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-17T01:30:54.141696","MEAN_MOTION":16.34792538,"ECCENTRICITY":0.0010403,"INCLINATION":52.9927,"RA_OF_ASC_NODE":108.7029,"ARG_OF_PERICENTER":283.3728,"MEAN_ANOMALY":218.5631,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44253,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7357,"BSTAR":0.00028261,"MEAN_MOTION_DOT":0.02181884,"MEAN_MOTION_DDOT":0.000012221,"SEMIMAJOR_AXIS":6557.828,"PERIOD":88.084,"APOAPSIS":186.515,"PERIAPSIS":172.871,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-18","DECAYED":1,"FILE":2826965,"GP_ID":161623552,"TLE_LINE0":"0 STARLINK-39","TLE_LINE1":"1 44253U 19029U   20261.06312664  .02181884  12221-4  28261-3 0  9994","TLE_LINE2":"2 44253  52.9927 108.7029 0010403 283.3728 218.5631 16.34792538 73578"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985620"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-16T02:46:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-36","OBJECT_ID":"2019-029R","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-15T22:00:01.999584","MEAN_MOTION":16.26094342,"ECCENTRICITY":0.0009234,"INCLINATION":52.9869,"RA_OF_ASC_NODE":115.1258,"ARG_OF_PERICENTER":267.0021,"MEAN_ANOMALY":304.7602,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44250,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7336,"BSTAR":0.0001169,"MEAN_MOTION_DOT":0.00384114,"MEAN_MOTION_DDOT":0.000011978,"SEMIMAJOR_AXIS":6581.193,"PERIOD":88.555,"APOAPSIS":209.135,"PERIAPSIS":196.981,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-15","DECAYED":1,"FILE":2824441,"GP_ID":161469681,"TLE_LINE0":"0 STARLINK-36","TLE_LINE1":"1 44250U 19029R   20259.91668981  .00384114  11978-4  11690-3 0  9993","TLE_LINE2":"2 44250  52.9869 115.1258 0009234 267.0021 304.7602 16.26094342 73363"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985621"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-08-21T05:26:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-66","OBJECT_ID":"2019-029W","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-08-21T04:19:04.322496","MEAN_MOTION":16.51444328,"ECCENTRICITY":0.0005799,"INCLINATION":52.999,"RA_OF_ASC_NODE":193.8711,"ARG_OF_PERICENTER":267.9489,"MEAN_ANOMALY":92.4984,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44255,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7000,"BSTAR":0.00012961,"MEAN_MOTION_DOT":0.14819503,"MEAN_MOTION_DDOT":0.00001268,"SEMIMAJOR_AXIS":6513.671,"PERIOD":87.196,"APOAPSIS":139.314,"PERIAPSIS":131.759,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-08-21","DECAYED":1,"FILE":2805575,"GP_ID":159804683,"TLE_LINE0":"0 STARLINK-66","TLE_LINE1":"1 44255U 19029W   20234.17991114  .14819503  12680-4  12961-3 0  9999","TLE_LINE2":"2 44255  52.9990 193.8711 0005799 267.9489  92.4984 16.51444328 70002"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985622"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-05-19T06:26:11","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-71","OBJECT_ID":"2019-029T","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-05-19T03:06:02.979360","MEAN_MOTION":15.17672515,"ECCENTRICITY":0.0001475,"INCLINATION":52.9981,"RA_OF_ASC_NODE":124.1867,"ARG_OF_PERICENTER":107.4837,"MEAN_ANOMALY":252.6317,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44252,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":10986,"BSTAR":0.00025139,"MEAN_MOTION_DOT":0.00004814,"MEAN_MOTION_DDOT":0,"SEMIMAJOR_AXIS":6891.014,"PERIOD":94.882,"APOAPSIS":513.895,"PERIAPSIS":511.863,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":null,"DECAYED":0,"FILE":3038199,"GP_ID":177468541,"TLE_LINE0":"0 STARLINK-71","TLE_LINE1":"1 44252U 19029T   21139.12920115  .00004814  00000-0  25139-3 0  9995","TLE_LINE2":"2 44252  52.9981 124.1867 0001475 107.4837 252.6317 15.17672515109869"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":25.67631936569189,"latitude":43.65740570990044,"height_km":516.5842034322095,"velocity_kms":7.611111726821688,"id":"5eed7714096e590006985623"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-22T10:06:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-21","OBJECT_ID":"2019-029L","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-21T23:33:30.923424","MEAN_MOTION":16.42788868,"ECCENTRICITY":0.0006865,"INCLINATION":53.0037,"RA_OF_ASC_NODE":83.312,"ARG_OF_PERICENTER":333.5091,"MEAN_ANOMALY":155.9539,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44245,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7436,"BSTAR":0.0014539,"MEAN_MOTION_DOT":0.31154212,"MEAN_MOTION_DDOT":0.000012542,"SEMIMAJOR_AXIS":6536.531,"PERIOD":87.655,"APOAPSIS":162.883,"PERIAPSIS":153.908,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-22","DECAYED":1,"FILE":2831017,"GP_ID":161893859,"TLE_LINE0":"0 STARLINK-21","TLE_LINE1":"1 44245U 19029L   20265.98160791  .31154212  12542-4  14539-2 0  9997","TLE_LINE2":"2 44245  53.0037  83.3120 0006865 333.5091 155.9539 16.42788868 74360"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985624"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-05T19:46:08","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-40","OBJECT_ID":"2019-029Z","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-05T18:52:30.702144","MEAN_MOTION":16.55583557,"ECCENTRICITY":0.0024929,"INCLINATION":52.9853,"RA_OF_ASC_NODE":168.527,"ARG_OF_PERICENTER":165.722,"MEAN_ANOMALY":288.7645,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44258,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7175,"BSTAR":0.00046875,"MEAN_MOTION_DOT":0.99999999,"MEAN_MOTION_DDOT":0.000012507,"SEMIMAJOR_AXIS":6502.81,"PERIOD":86.978,"APOAPSIS":140.886,"PERIAPSIS":108.464,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-05","DECAYED":1,"FILE":2814966,"GP_ID":160785610,"TLE_LINE0":"0 STARLINK-40","TLE_LINE1":"1 44258U 19029Z   20249.78646646  .99999999  12507-4  46875-3 0  9992","TLE_LINE2":"2 44258  52.9853 168.5270 0024929 165.7220 288.7645 16.55583557 71755"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985625"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-16T06:36:11","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-42","OBJECT_ID":"2019-029X","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-16T03:58:44.164416","MEAN_MOTION":16.44452279,"ECCENTRICITY":0.0029517,"INCLINATION":52.9964,"RA_OF_ASC_NODE":65.2221,"ARG_OF_PERICENTER":24.7473,"MEAN_ANOMALY":336.0349,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44256,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7403,"BSTAR":0.00019197,"MEAN_MOTION_DOT":0.10945764,"MEAN_MOTION_DDOT":0.000012936,"SEMIMAJOR_AXIS":6532.122,"PERIOD":87.567,"APOAPSIS":173.268,"PERIAPSIS":134.706,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-16","DECAYED":1,"FILE":2824666,"GP_ID":161473154,"TLE_LINE0":"0 STARLINK-42","TLE_LINE1":"1 44256U 19029X   20260.16578894  .10945764  12936-4  19197-3 0  9991","TLE_LINE2":"2 44256  52.9964  65.2221 0029517  24.7473 336.0349 16.44452279 74033"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985626"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-12T02:06:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-32","OBJECT_ID":"2019-029V","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-12T01:13:36.104448","MEAN_MOTION":16.48299762,"ECCENTRICITY":0.000733,"INCLINATION":52.9893,"RA_OF_ASC_NODE":135.7261,"ARG_OF_PERICENTER":230.4654,"MEAN_ANOMALY":130.145,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44254,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7272,"BSTAR":0.00080031,"MEAN_MOTION_DOT":0.54783783,"MEAN_MOTION_DDOT":0.000012528,"SEMIMAJOR_AXIS":6521.953,"PERIOD":87.362,"APOAPSIS":148.599,"PERIAPSIS":139.038,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-12","DECAYED":1,"FILE":2820258,"GP_ID":161179109,"TLE_LINE0":"0 STARLINK-32","TLE_LINE1":"1 44254U 19029V   20256.05111232  .54783783  12528-4  80031-3 0  9992","TLE_LINE2":"2 44254  52.9893 135.7261 0007330 230.4654 130.1450 16.48299762 72725"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985627"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-04T14:46:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-45","OBJECT_ID":"2019-029AB","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-04T07:45:46.533600","MEAN_MOTION":16.38652946,"ECCENTRICITY":0.0009412,"INCLINATION":52.9913,"RA_OF_ASC_NODE":174.9865,"ARG_OF_PERICENTER":250.3159,"MEAN_ANOMALY":109.8966,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44260,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7159,"BSTAR":0.0021111,"MEAN_MOTION_DOT":0.2512774,"MEAN_MOTION_DDOT":0.000012274,"SEMIMAJOR_AXIS":6547.525,"PERIOD":87.877,"APOAPSIS":175.552,"PERIAPSIS":163.227,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-04","DECAYED":1,"FILE":2814243,"GP_ID":160688146,"TLE_LINE0":"0 STARLINK-45","TLE_LINE1":"1 44260U 19029AB  20248.32345525  .25127740  12274-4  21111-2 0  9998","TLE_LINE2":"2 44260  52.9913 174.9865 0009412 250.3159 109.8966 16.38652946 71599"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985628"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-05-19T06:36:11","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-43","OBJECT_ID":"2019-029Y","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-05-19T01:09:38.639232","MEAN_MOTION":15.42182295,"ECCENTRICITY":0.0001957,"INCLINATION":53.0014,"RA_OF_ASC_NODE":19.3351,"ARG_OF_PERICENTER":131.5122,"MEAN_ANOMALY":228.605,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44257,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":11141,"BSTAR":0.00060174,"MEAN_MOTION_DOT":0.00025885,"MEAN_MOTION_DDOT":0,"SEMIMAJOR_AXIS":6817.807,"PERIOD":93.374,"APOAPSIS":441.006,"PERIAPSIS":438.338,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":null,"DECAYED":0,"FILE":3038272,"GP_ID":177470254,"TLE_LINE0":"0 STARLINK-43","TLE_LINE1":"1 44257U 19029Y   21139.04836388  .00025885  00000-0  60174-3 0  9998","TLE_LINE2":"2 44257  53.0014  19.3351 0001957 131.5122 228.6050 15.42182295111416"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":68.46191915531345,"latitude":-17.638598684350427,"height_km":443.85988654532775,"velocity_kms":7.646278311520839,"id":"5eed7714096e590006985629"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-05T03:26:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-44","OBJECT_ID":"2019-029AC","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-05T02:13:09.311232","MEAN_MOTION":16.35234008,"ECCENTRICITY":0.0006119,"INCLINATION":52.9831,"RA_OF_ASC_NODE":172.1242,"ARG_OF_PERICENTER":239.5454,"MEAN_ANOMALY":120.5504,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44261,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7165,"BSTAR":0.0024119,"MEAN_MOTION_DOT":0.19263879,"MEAN_MOTION_DDOT":0.000012182,"SEMIMAJOR_AXIS":6556.648,"PERIOD":88.06,"APOAPSIS":182.525,"PERIAPSIS":174.501,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-05","DECAYED":1,"FILE":2814556,"GP_ID":160755906,"TLE_LINE0":"0 STARLINK-44","TLE_LINE1":"1 44261U 19029AC  20249.09246888  .19263879  12182-4  24119-2 0  9992","TLE_LINE2":"2 44261  52.9831 172.1242 0006119 239.5454 120.5504 16.35234008 71653"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698562a"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-10-15T12:16:08","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-72","OBJECT_ID":"2019-029AE","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-10-15T11:24:14.113440","MEAN_MOTION":16.49183723,"ECCENTRICITY":0.000333,"INCLINATION":52.982,"RA_OF_ASC_NODE":318.7786,"ARG_OF_PERICENTER":292.8532,"MEAN_ANOMALY":67.5533,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44263,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7817,"BSTAR":0.00016439,"MEAN_MOTION_DOT":0.12398314,"MEAN_MOTION_DDOT":0.000012643,"SEMIMAJOR_AXIS":6519.622,"PERIOD":87.315,"APOAPSIS":143.659,"PERIAPSIS":139.316,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-10-16","DECAYED":1,"FILE":2852737,"GP_ID":163509580,"TLE_LINE0":"0 STARLINK-72","TLE_LINE1":"1 44263U 19029AE  20289.47516335  .12398314  12643-4  16439-3 0  9992","TLE_LINE2":"2 44263  52.9820 318.7786 0003330 292.8532  67.5533 16.49183723 78173"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698562b"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-28T17:36:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-49","OBJECT_ID":"2019-029AD","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-27T20:12:36.285696","MEAN_MOTION":16.23728101,"ECCENTRICITY":0.0008965,"INCLINATION":53.0037,"RA_OF_ASC_NODE":53.0192,"ARG_OF_PERICENTER":308.653,"MEAN_ANOMALY":51.7564,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44262,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7533,"BSTAR":0.0027635,"MEAN_MOTION_DOT":0.07478847,"MEAN_MOTION_DDOT":0.000011984,"SEMIMAJOR_AXIS":6587.586,"PERIOD":88.684,"APOAPSIS":215.356,"PERIAPSIS":203.545,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-29","DECAYED":1,"FILE":2837054,"GP_ID":162370859,"TLE_LINE0":"0 STARLINK-49","TLE_LINE1":"1 44262U 19029AD  20271.84208664  .07478847  11984-4  27635-2 0  9996","TLE_LINE2":"2 44262  53.0037  53.0192 0008965 308.6530  51.7564 16.23728101 75338"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698562c"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-10-14T00:36:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-52","OBJECT_ID":"2019-029AA","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-10-13T17:23:45.076992","MEAN_MOTION":16.33038265,"ECCENTRICITY":0.0006539,"INCLINATION":52.9866,"RA_OF_ASC_NODE":227.4445,"ARG_OF_PERICENTER":235.724,"MEAN_ANOMALY":124.3359,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44259,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7918,"BSTAR":0.0014109,"MEAN_MOTION_DOT":0.08958567,"MEAN_MOTION_DDOT":0.000012115,"SEMIMAJOR_AXIS":6562.524,"PERIOD":88.179,"APOAPSIS":188.68,"PERIAPSIS":180.098,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-10-13","DECAYED":1,"FILE":2851446,"GP_ID":163426277,"TLE_LINE0":"0 STARLINK-52","TLE_LINE1":"1 44259U 19029AA  20287.72482728  .08958567  12115-4  14109-2 0  9993","TLE_LINE2":"2 44259  52.9866 227.4445 0006539 235.7240 124.3359 16.33038265 79185"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698562d"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-14T20:46:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-54","OBJECT_ID":"2019-029AH","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-14T20:31:28.168896","MEAN_MOTION":16.52546679,"ECCENTRICITY":0.0020137,"INCLINATION":52.9827,"RA_OF_ASC_NODE":119.6547,"ARG_OF_PERICENTER":244.8039,"MEAN_ANOMALY":224.076,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44266,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7318,"BSTAR":0.0001,"MEAN_MOTION_DOT":0.16097244,"MEAN_MOTION_DDOT":0.000012572,"SEMIMAJOR_AXIS":6510.774,"PERIOD":87.138,"APOAPSIS":145.75,"PERIAPSIS":119.529,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-15","DECAYED":1,"FILE":2823179,"GP_ID":161384067,"TLE_LINE0":"0 STARLINK-54","TLE_LINE1":"1 44266U 19029AH  20258.85518714  .16097244  12572-4  10000-3 0  9997","TLE_LINE2":"2 44266  52.9827 119.6547 0020137 244.8039 224.0760 16.52546679 73184"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698562e"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-10-13T16:56:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-63","OBJECT_ID":"2019-029AG","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-10-13T16:16:39.726048","MEAN_MOTION":16.40378467,"ECCENTRICITY":0.0000578,"INCLINATION":52.9803,"RA_OF_ASC_NODE":332.3076,"ARG_OF_PERICENTER":316.8106,"MEAN_ANOMALY":43.5401,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44265,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7785,"BSTAR":0.0020466,"MEAN_MOTION_DOT":0.29311092,"MEAN_MOTION_DDOT":0.000012381,"SEMIMAJOR_AXIS":6542.932,"PERIOD":87.784,"APOAPSIS":165.176,"PERIAPSIS":164.419,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-10-13","DECAYED":1,"FILE":2851288,"GP_ID":163381387,"TLE_LINE0":"0 STARLINK-63","TLE_LINE1":"1 44265U 19029AG  20287.67823757  .29311092  12381-4  20466-2 0  9992","TLE_LINE2":"2 44265  52.9803 332.3076 0000578 316.8106  43.5401 16.40378467 77859"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698562f"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-02T06:26:10","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-51","OBJECT_ID":"2019-029AP","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-02T05:27:34.557120","MEAN_MOTION":16.38700138,"ECCENTRICITY":0.0004195,"INCLINATION":52.9819,"RA_OF_ASC_NODE":186.8253,"ARG_OF_PERICENTER":246.1664,"MEAN_ANOMALY":114.4298,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44272,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7118,"BSTAR":0.0012012,"MEAN_MOTION_DOT":0.14112946,"MEAN_MOTION_DDOT":0.000012301,"SEMIMAJOR_AXIS":6547.399,"PERIOD":87.874,"APOAPSIS":172.011,"PERIAPSIS":166.517,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-02","DECAYED":1,"FILE":2812873,"GP_ID":160575176,"TLE_LINE0":"0 STARLINK-51","TLE_LINE1":"1 44272U 19029AP  20246.22748330  .14112946  12301-4  12012-2 0  9990","TLE_LINE2":"2 44272  52.9819 186.8253 0004195 246.1664 114.4298 16.38700138 71189"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985630"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-16T04:36:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-69","OBJECT_ID":"2019-029AJ","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-15T23:53:25.924416","MEAN_MOTION":16.31646927,"ECCENTRICITY":0.0006351,"INCLINATION":52.9852,"RA_OF_ASC_NODE":113.5784,"ARG_OF_PERICENTER":300.7439,"MEAN_ANOMALY":212.2782,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44267,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7341,"BSTAR":0.0019064,"MEAN_MOTION_DOT":0.10522816,"MEAN_MOTION_DDOT":0.00001219,"SEMIMAJOR_AXIS":6566.254,"PERIOD":88.254,"APOAPSIS":192.289,"PERIAPSIS":183.949,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-16","DECAYED":1,"FILE":2824454,"GP_ID":161469695,"TLE_LINE0":"0 STARLINK-69","TLE_LINE1":"1 44267U 19029AJ  20259.99543894  .10522816  12190-4  19064-2 0  9997","TLE_LINE2":"2 44267  52.9852 113.5784 0006351 300.7439 212.2782 16.31646927 73410"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985631"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-10-14T22:36:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-59","OBJECT_ID":"2019-029AN","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-10-14T13:42:08.011584","MEAN_MOTION":16.30723255,"ECCENTRICITY":0.0003539,"INCLINATION":52.9879,"RA_OF_ASC_NODE":323.6967,"ARG_OF_PERICENTER":53.2438,"MEAN_ANOMALY":81.7998,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44271,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7803,"BSTAR":0.0013629,"MEAN_MOTION_DOT":0.06839568,"MEAN_MOTION_DDOT":0.00001214,"SEMIMAJOR_AXIS":6568.733,"PERIOD":88.304,"APOAPSIS":192.923,"PERIAPSIS":188.274,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-10-15","DECAYED":1,"FILE":2852326,"GP_ID":163479750,"TLE_LINE0":"0 STARLINK-59","TLE_LINE1":"1 44271U 19029AN  20288.57092606  .06839568  12140-4  13629-2 0  9994","TLE_LINE2":"2 44271  52.9879 323.6967 0003539  53.2438  81.7998 16.30723255 78035"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985632"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-12-26T09:56:08","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-60","OBJECT_ID":"2019-029AQ","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-12-26T08:56:34.743840","MEAN_MOTION":16.42262567,"ECCENTRICITY":0.0005472,"INCLINATION":52.9738,"RA_OF_ASC_NODE":231.8413,"ARG_OF_PERICENTER":237.7623,"MEAN_ANOMALY":123.7494,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44273,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":9074,"BSTAR":0.0010665,"MEAN_MOTION_DOT":0.19593865,"MEAN_MOTION_DDOT":0.000012379,"SEMIMAJOR_AXIS":6537.927,"PERIOD":87.683,"APOAPSIS":163.37,"PERIAPSIS":156.215,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-12-26","DECAYED":1,"FILE":2910138,"GP_ID":168384886,"TLE_LINE0":"0 STARLINK-60","TLE_LINE1":"1 44273U 19029AQ  20361.37262435  .19593865  12379-4  10665-2 0  9997","TLE_LINE2":"2 44273  52.9738 231.8413 0005472 237.7623 123.7494 16.42262567 90747"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985633"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-05-19T14:46:11","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-24","OBJECT_ID":"2019-029D","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-05-19T07:31:31.429344","MEAN_MOTION":15.15740107,"ECCENTRICITY":0.0000986,"INCLINATION":52.9961,"RA_OF_ASC_NODE":121.1941,"ARG_OF_PERICENTER":79.9772,"MEAN_ANOMALY":280.1331,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44238,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":10992,"BSTAR":0.00023491,"MEAN_MOTION_DOT":0.00004227,"MEAN_MOTION_DDOT":0,"SEMIMAJOR_AXIS":6896.87,"PERIOD":95.003,"APOAPSIS":519.415,"PERIAPSIS":518.055,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":null,"DECAYED":0,"FILE":3038453,"GP_ID":177473753,"TLE_LINE0":"0 STARLINK-24","TLE_LINE1":"1 44238U 19029D   21139.31355821  .00004227  00000-0  23491-3 0  9993","TLE_LINE2":"2 44238  52.9961 121.1941 0000986  79.9772 280.1331 15.15740107109928"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":121.16719064154178,"latitude":38.5733363588615,"height_km":521.5485063830474,"velocity_kms":7.607721202115083,"id":"5eed7714096e590006985634"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-03-09T01:16:12","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-55","OBJECT_ID":"2019-029AK","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-03-09T01:09:48.163968","MEAN_MOTION":16.55493516,"ECCENTRICITY":0.0004294,"INCLINATION":53.1,"RA_OF_ASC_NODE":298.079,"ARG_OF_PERICENTER":211.0752,"MEAN_ANOMALY":300.1477,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44268,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":10120,"BSTAR":0.00062063,"MEAN_MOTION_DOT":0.99999999,"MEAN_MOTION_DDOT":0.000012761,"SEMIMAJOR_AXIS":6503.046,"PERIOD":86.983,"APOAPSIS":127.704,"PERIAPSIS":122.119,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2021-03-09","DECAYED":1,"FILE":2978300,"GP_ID":173060436,"TLE_LINE0":"0 STARLINK-55","TLE_LINE1":"1 44268U 19029AK  21068.04847412  .99999999  12761-4  62063-3 0  9995","TLE_LINE2":"2 44268  53.1000 298.0790 0004294 211.0752 300.1477 16.55493516101208"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985635"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-08-09T09:26:08","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-41","OBJECT_ID":"2019-029AU","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-08-09T08:57:30.860640","MEAN_MOTION":16.37648131,"ECCENTRICITY":0.0015013,"INCLINATION":52.9901,"RA_OF_ASC_NODE":257.7587,"ARG_OF_PERICENTER":227.2645,"MEAN_ANOMALY":148.1546,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44277,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":6811,"BSTAR":0.0001,"MEAN_MOTION_DOT":0.01090556,"MEAN_MOTION_DDOT":0.000012276,"SEMIMAJOR_AXIS":6550.203,"PERIOD":87.93,"APOAPSIS":181.902,"PERIAPSIS":162.234,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-08-09","DECAYED":1,"FILE":2798569,"GP_ID":159046028,"TLE_LINE0":"0 STARLINK-41","TLE_LINE1":"1 44277U 19029AU  20222.37327385  .01090556  12276-4  10000-3 0  9993","TLE_LINE2":"2 44277  52.9901 257.7587 0015013 227.2645 148.1546 16.37648131 68116"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985636"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-10-21T06:26:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-65","OBJECT_ID":"2019-029AT","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-10-21T01:35:09.981600","MEAN_MOTION":16.33268807,"ECCENTRICITY":0.0006998,"INCLINATION":52.9911,"RA_OF_ASC_NODE":314.6487,"ARG_OF_PERICENTER":54.336,"MEAN_ANOMALY":308.5648,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44276,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7874,"BSTAR":0.0015821,"MEAN_MOTION_DOT":0.10298997,"MEAN_MOTION_DDOT":0.000012247,"SEMIMAJOR_AXIS":6561.906,"PERIOD":88.166,"APOAPSIS":188.363,"PERIAPSIS":179.179,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-10-21","DECAYED":1,"FILE":2857539,"GP_ID":163945078,"TLE_LINE0":"0 STARLINK-65","TLE_LINE1":"1 44276U 19029AT  20295.06608775  .10298997  12247-4  15821-2 0  9995","TLE_LINE2":"2 44276  52.9911 314.6487 0006998  54.3360 308.5648 16.33268807 78742"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985637"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-10T21:12:49","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-56","OBJECT_ID":"2019-029BA","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-10T05:05:57.835680","MEAN_MOTION":16.30933978,"ECCENTRICITY":0.0011081,"INCLINATION":52.9873,"RA_OF_ASC_NODE":144.6174,"ARG_OF_PERICENTER":245.6054,"MEAN_ANOMALY":114.6761,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44283,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7250,"BSTAR":0.00078158,"MEAN_MOTION_DOT":0.04079276,"MEAN_MOTION_DDOT":0.000012086,"SEMIMAJOR_AXIS":6568.168,"PERIOD":88.292,"APOAPSIS":197.311,"PERIAPSIS":182.754,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-10","DECAYED":1,"FILE":2818987,"GP_ID":161111459,"TLE_LINE0":"0 STARLINK-56","TLE_LINE1":"1 44283U 19029BA  20254.21247495 +.04079276 +12086-4 +78158-3 0  9997","TLE_LINE2":"2 44283 052.9873 144.6174 0011081 245.6054 114.6761 16.30933978072500"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985638"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-05-19T06:26:11","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-80","OBJECT_ID":"2019-029AZ","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-05-19T00:46:16.991040","MEAN_MOTION":15.31184195,"ECCENTRICITY":0.0003466,"INCLINATION":53.0219,"RA_OF_ASC_NODE":55.5518,"ARG_OF_PERICENTER":162.3521,"MEAN_ANOMALY":197.7599,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44282,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":11090,"BSTAR":0.00046649,"MEAN_MOTION_DOT":0.0001391,"MEAN_MOTION_DDOT":0,"SEMIMAJOR_AXIS":6850.415,"PERIOD":94.045,"APOAPSIS":474.654,"PERIAPSIS":469.906,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":null,"DECAYED":0,"FILE":3038205,"GP_ID":177468648,"TLE_LINE0":"0 STARLINK-80","TLE_LINE1":"1 44282U 19029AZ  21139.03214110  .00013910  00000-0  46649-3 0  9995","TLE_LINE2":"2 44282  53.0219  55.5518 0003466 162.3521 197.7599 15.31184195110906"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":171.6217229053721,"latitude":-52.81334371715789,"height_km":490.9407549555053,"velocity_kms":7.619046429419813,"id":"5eed7714096e590006985639"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-27T20:06:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-73","OBJECT_ID":"2019-029BB","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-27T19:13:13.726848","MEAN_MOTION":16.36958608,"ECCENTRICITY":0.0006216,"INCLINATION":52.9805,"RA_OF_ASC_NODE":52.506,"ARG_OF_PERICENTER":304.81,"MEAN_ANOMALY":55.7759,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44284,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7531,"BSTAR":0.0018995,"MEAN_MOTION_DOT":0.1835257,"MEAN_MOTION_DDOT":0.000012342,"SEMIMAJOR_AXIS":6552.042,"PERIOD":87.968,"APOAPSIS":177.98,"PERIAPSIS":169.834,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-28","DECAYED":1,"FILE":2836076,"GP_ID":162309749,"TLE_LINE0":"0 STARLINK-73","TLE_LINE1":"1 44284U 19029BB  20271.80085332  .18352570  12342-4  18995-2 0  9995","TLE_LINE2":"2 44284  52.9805  52.5060 0006216 304.8100  55.7759 16.36958608 75318"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698563a"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-05-27T09:56:08","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-67","OBJECT_ID":"2019-029AV","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-05-27T08:59:56.976864","MEAN_MOTION":16.44125369,"ECCENTRICITY":0.0005497,"INCLINATION":52.9725,"RA_OF_ASC_NODE":113.8189,"ARG_OF_PERICENTER":260.1827,"MEAN_ANOMALY":100.3413,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44278,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":5853,"BSTAR":0.001249,"MEAN_MOTION_DOT":0.35214307,"MEAN_MOTION_DDOT":0.000012466,"SEMIMAJOR_AXIS":6532.988,"PERIOD":87.584,"APOAPSIS":158.444,"PERIAPSIS":151.262,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-05-27","DECAYED":1,"FILE":2754782,"GP_ID":154608628,"TLE_LINE0":"0 STARLINK-67","TLE_LINE1":"1 44278U 19029AV  20148.37496501  .35214307  12466-4  12490-2 0  9992","TLE_LINE2":"2 44278  52.9725 113.8189 0005497 260.1827 100.3413 16.44125369 58533"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698563b"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-05-19T15:36:10","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-64","OBJECT_ID":"2019-029AS","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-05-19T12:50:39.221088","MEAN_MOTION":16.09402878,"ECCENTRICITY":0.0012586,"INCLINATION":52.9791,"RA_OF_ASC_NODE":16.8436,"ARG_OF_PERICENTER":256.1126,"MEAN_ANOMALY":103.8507,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44275,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":11144,"BSTAR":0.0025073,"MEAN_MOTION_DOT":0.02197398,"MEAN_MOTION_DDOT":0.0045376,"SEMIMAJOR_AXIS":6626.619,"PERIOD":89.474,"APOAPSIS":256.824,"PERIAPSIS":240.144,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":null,"DECAYED":0,"FILE":3038586,"GP_ID":177476808,"TLE_LINE0":"0 STARLINK-64","TLE_LINE1":"1 44275U 19029AS  21139.53517617  .02197398  45376-2  25073-2 0  9999","TLE_LINE2":"2 44275  52.9791  16.8436 0012586 256.1126 103.8507 16.09402878111440"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":-72.35418129852131,"latitude":46.89666039123915,"height_km":258.91434592322184,"velocity_kms":7.75295976764,"id":"5eed7714096e59000698563c"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-05T23:56:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-38","OBJECT_ID":"2019-029AX","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-05T23:23:26.123424","MEAN_MOTION":16.47885248,"ECCENTRICITY":0.0006936,"INCLINATION":52.9948,"RA_OF_ASC_NODE":167.2942,"ARG_OF_PERICENTER":203.6675,"MEAN_ANOMALY":156.8897,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44280,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7181,"BSTAR":0.00086033,"MEAN_MOTION_DOT":0.54219169,"MEAN_MOTION_DDOT":0.000012491,"SEMIMAJOR_AXIS":6523.047,"PERIOD":87.384,"APOAPSIS":149.436,"PERIAPSIS":140.387,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-06","DECAYED":1,"FILE":2815160,"GP_ID":160789876,"TLE_LINE0":"0 STARLINK-38","TLE_LINE1":"1 44280U 19029AX  20249.97460791  .54219169  12491-4  86033-3 0  9990","TLE_LINE2":"2 44280  52.9948 167.2942 0006936 203.6675 156.8897 16.47885248 71815"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698563d"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-03-30T06:36:16","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-75","OBJECT_ID":"2019-029BD","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-03-28T09:48:53.639424","MEAN_MOTION":16.39813578,"ECCENTRICITY":0.00066,"INCLINATION":52.986,"RA_OF_ASC_NODE":191.9313,"ARG_OF_PERICENTER":344.8422,"MEAN_ANOMALY":15.2425,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44286,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":10549,"BSTAR":0.0014773,"MEAN_MOTION_DOT":0.19980176,"MEAN_MOTION_DDOT":0.000012469,"SEMIMAJOR_AXIS":6544.435,"PERIOD":87.815,"APOAPSIS":170.62,"PERIAPSIS":161.981,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2021-03-28","DECAYED":1,"FILE":3000112,"GP_ID":174467642,"TLE_LINE0":"0 STARLINK-75","TLE_LINE1":"1 44286U 19029BD  21087.40895416  .19980176  12469-4  14773-2 0  9991","TLE_LINE2":"2 44286  52.9860 191.9313 0006600 344.8422  15.2425 16.39813578105491"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e59000698563e"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-05-19T06:26:11","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-70","OBJECT_ID":"2019-029AY","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-05-19T02:15:45.617472","MEAN_MOTION":15.54887201,"ECCENTRICITY":0.0003436,"INCLINATION":52.9976,"RA_OF_ASC_NODE":53.1518,"ARG_OF_PERICENTER":125.3344,"MEAN_ANOMALY":234.7987,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44281,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":11087,"BSTAR":0.00081199,"MEAN_MOTION_DOT":0.00055106,"MEAN_MOTION_DDOT":0,"SEMIMAJOR_AXIS":6780.618,"PERIOD":92.611,"APOAPSIS":404.812,"PERIAPSIS":400.153,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":null,"DECAYED":0,"FILE":3038213,"GP_ID":177468323,"TLE_LINE0":"0 STARLINK-70","TLE_LINE1":"1 44281U 19029AY  21139.09427798  .00055106  00000-0  81199-3 0  9990","TLE_LINE2":"2 44281  52.9976  53.1518 0003436 125.3344 234.7987 15.54887201110878"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":-106.23690062814752,"latitude":-18.927647126845404,"height_km":409.5051208010191,"velocity_kms":7.66414863962125,"id":"5eed7714096e59000698563f"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-16T18:36:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-35","OBJECT_ID":"2019-029AF","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-16T16:58:24.439584","MEAN_MOTION":16.41142759,"ECCENTRICITY":0.0004977,"INCLINATION":52.9869,"RA_OF_ASC_NODE":110.3679,"ARG_OF_PERICENTER":298.2751,"MEAN_ANOMALY":61.7792,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44264,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7351,"BSTAR":0.0011425,"MEAN_MOTION_DOT":0.18133919,"MEAN_MOTION_DDOT":0.000012437,"SEMIMAJOR_AXIS":6540.901,"PERIOD":87.743,"APOAPSIS":166.021,"PERIAPSIS":159.51,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-16","DECAYED":1,"FILE":2825149,"GP_ID":161504357,"TLE_LINE0":"0 STARLINK-35","TLE_LINE1":"1 44264U 19029AF  20260.70722731  .18133919  12437-4  11425-2 0  9991","TLE_LINE2":"2 44264  52.9869 110.3679 0004977 298.2751  61.7792 16.41142759 73517"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985640"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2020-09-25T23:06:09","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-53","OBJECT_ID":"2019-029BM","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2020-09-25T22:15:25.690752","MEAN_MOTION":16.36544709,"ECCENTRICITY":0.0003802,"INCLINATION":52.9797,"RA_OF_ASC_NODE":67.4343,"ARG_OF_PERICENTER":280.7809,"MEAN_ANOMALY":81.1246,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44294,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":7600,"BSTAR":0.0017204,"MEAN_MOTION_DOT":0.15779032,"MEAN_MOTION_DDOT":0.000012283,"SEMIMAJOR_AXIS":6553.147,"PERIOD":87.99,"APOAPSIS":177.503,"PERIAPSIS":172.52,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2020-09-26","DECAYED":1,"FILE":2834139,"GP_ID":162145066,"TLE_LINE0":"0 STARLINK-53","TLE_LINE1":"1 44294U 19029BM  20269.92738068  .15779032  12283-4  17204-2 0  9996","TLE_LINE2":"2 44294  52.9797  67.4343 0003802 280.7809  81.1246 16.36544709 76008"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985641"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-05-19T15:06:10","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-1009","OBJECT_ID":"2019-074C","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-05-19T08:29:25.375488","MEAN_MOTION":15.06395646,"ECCENTRICITY":0.0000432,"INCLINATION":53.0554,"RA_OF_ASC_NODE":146.6319,"ARG_OF_PERICENTER":60.2617,"MEAN_ANOMALY":299.8415,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44715,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":8434,"BSTAR":-0.000064871,"MEAN_MOTION_DOT":-0.00001247,"MEAN_MOTION_DDOT":0,"SEMIMAJOR_AXIS":6925.362,"PERIOD":95.592,"APOAPSIS":547.526,"PERIAPSIS":546.928,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-11-11","SITE":"AFETR","DECAY_DATE":null,"DECAYED":0,"FILE":3038487,"GP_ID":177474515,"TLE_LINE0":"0 STARLINK-1009","TLE_LINE1":"1 44715U 19074C   21139.35376592 -.00001247  00000-0 -64871-4 0  9994","TLE_LINE2":"2 44715  53.0554 146.6319 0000432  60.2617 299.8415 15.06395646 84348"},"version":"v1.0","launch":"5eb87d39ffd86e000604b37d","longitude":-108.09237781249814,"latitude":-51.1831176227344,"height_km":565.2171938282718,"velocity_kms":7.578247823273966,"id":"5eed7714096e590006985642"},{"spaceTrack":{"CCSDS_OMM_VERS":"2.0","COMMENT":"GENERATED VIA SPACE-TRACK.ORG API","CREATION_DATE":"2021-04-18T14:26:12","ORIGINATOR":"18 SPCS","OBJECT_NAME":"STARLINK-48","OBJECT_ID":"2019-029BG","CENTER_NAME":"EARTH","REF_FRAME":"TEME","TIME_SYSTEM":"UTC","MEAN_ELEMENT_THEORY":"SGP4","EPOCH":"2021-04-18T13:48:16.992288","MEAN_MOTION":16.38335892,"ECCENTRICITY":0.0008484,"INCLINATION":52.9905,"RA_OF_ASC_NODE":201.5628,"ARG_OF_PERICENTER":323.9147,"MEAN_ANOMALY":36.3798,"EPHEMERIS_TYPE":0,"CLASSIFICATION_TYPE":"U","NORAD_CAT_ID":44289,"ELEMENT_SET_NO":999,"REV_AT_EPOCH":10722,"BSTAR":0.0030987,"MEAN_MOTION_DOT":0.35374924,"MEAN_MOTION_DDOT":0.000012432,"SEMIMAJOR_AXIS":6548.37,"PERIOD":87.894,"APOAPSIS":175.791,"PERIAPSIS":164.679,"OBJECT_TYPE":"PAYLOAD","RCS_SIZE":"LARGE","COUNTRY_CODE":"US","LAUNCH_DATE":"2019-05-24","SITE":"AFETR","DECAY_DATE":"2021-04-18","DECAYED":1,"FILE":3020393,"GP_ID":175683121,"TLE_LINE0":"0 STARLINK-48","TLE_LINE1":"1 44289U 19029BG  21108.57519667  .35374924  12432-4  30987-2 0  9998","TLE_LINE2":"2 44289  52.9905 201.5628 0008484 323.9147  36.3798 16.38335892107222"},"version":"v0.9","launch":"5eb87d30ffd86e000604b378","longitude":null,"latitude":null,"height_km":null,"velocity_kms":null,"id":"5eed7714096e590006985643"}]
""".data(using: .utf8)!

struct FakeData {
    static let shared = FakeData()

    var crewDragon: Launch?
    var nrol108: Launch?
    var trailblazer: Launch?
    var robertBehnken: Astronaut?
    var slc40: Launchpad?
    var falcon9: Rocket?
    var ocisly: Ship?
    var lz1: Landpad?
    var b1051: Core?
    var roadsterPayload: Payload?
    var crew2Payload: Payload?
    var starlink22Payload: Payload?
    var c207: Capsule?
    var dragon2: Dragon?
    var firstStarlink: Starlink?
    var roadster: Roadster?
    var bunchOfStarlinks: [Starlink]?

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
            ocisly = try decoder.decode(Ship.self, from: ocislyJSON)
            lz1 = try decoder.decode(Landpad.self, from: lz1JSON)
            b1051 = try decoder.decode(Core.self, from: b1051JSON)
            roadsterPayload = try decoder.decode(Payload.self, from: roadsterPayloadJSON)
            crew2Payload = try decoder.decode(Payload.self, from: crew2PayloadJSON)
            starlink22Payload = try decoder.decode(Payload.self, from: starlink22PayloadJSON)
            c207 = try decoder.decode(Capsule.self, from: c207JSON)
            dragon2 = try decoder.decode(Dragon.self, from: dragon2JSON)
            firstStarlink = try decoder.decode(Starlink.self, from: firstStarlinkJSON)
            roadster = try decoder.decode(Roadster.self, from: roadsterJSON)
            bunchOfStarlinks = try decoder.decode([Starlink].self, from: bunchOfStarlinksJSON)
        } catch {
            fatalError("Unhandled error while initializing fake data: \"\(error.localizedDescription)\"")
        }
    }
}
