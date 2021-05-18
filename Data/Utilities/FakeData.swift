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
        } catch {
            fatalError("Unhandled error while initializing fake data: \"\(error.localizedDescription)\"")
        }
    }
}
