//
//  PayloadCapsuleInstanceSections.swift
//  Norminal
//
//  Created by Riccardo Persello on 21/05/21.
//

import SwiftUI

struct PayloadCapsuleInstanceSections: View {
    public init(payload: Payload) {
        self.payload = payload
        self.dragonInstance = payload.dragon
    }
    
    public init(capsule: Capsule) {
        self.capsule = capsule
    }

    var payload: Payload?
    var dragonInstance: Payload.Dragon?
    @State var capsule: Capsule?
    @State var dragonModel: Dragon?
    
    var body: some View {
        Section(header: Text("Capsule")) {
            if let images = dragonModel?.flickrImages {
                TImageWithGalleryButton(imageURLs: images)
            }

            if let capsule = capsule {
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(capsule.serial)
                            .font(.largeTitle)
                            .bold()
                    }

                    Text("\(capsule.type.uppercased()) • \(capsule.status.rawValue.uppercased())")
                        .foregroundColor(.gray)
                        .bold()

                    if let lastUpdate = capsule.lastUpdate {
                        Text(lastUpdate.capitalizingFirstLetter())
                            .font(.system(.body, design: .serif))
                            .padding(.top, 8)
                    }
                }
                .padding(.top, 4)
                .padding(.bottom, 8)

                if let reuseCount = capsule.reuseCount,
                   reuseCount > 0 {
                    InformationRow(label: "Reuse count", value: "\(reuseCount)", imageName: "arrow.3.trianglepath")
                }

                if let waterLandings = capsule.waterLandings,
                   waterLandings > 0 {
                    InformationRow(label: "Water landings", value: "\(waterLandings)", imageName: "arrow.down.to.line")
                }

                if let landLandings = capsule.landLandings,
                   landLandings > 0 {
                    InformationRow(label: "Land landings", value: "\(landLandings)", imageName: "arrow.down.to.line")
                }
            }

            if let dragonInstance = dragonInstance {
                if let massReturned = dragonInstance.massReturned {
                    InformationRow(label: "Mass returned",
                                   value: UsefulFormatters.measurementFormatter.string(from: massReturned),
                                   imageName: "scalemass")
                }

                if dragonInstance.landingStatus != .unknown {
                    InformationRow(label: "Last landing", value: dragonInstance.landingStatus.rawValue, imageName: "arrow.down.to.line")
                }

                if let flightTime = dragonInstance.flightTime {
                    InformationRow(label: "Flight time",
                                   value: UsefulFormatters.measurementFormatter.string(from: flightTime),
                                   imageName: "stopwatch")
                }

                if let manifest = dragonInstance.manifest {
                    Link(destination: manifest, label: {
                        Label("Mission manifest", systemImage: "newspaper")
                    })
                }
            }
        }
        .onAppear {
            dragonInstance?.getCapsule { capsule in
                self.capsule = capsule
                
                self.capsule?.getDragonModel { model in
                    self.dragonModel = model
                }
            }
        }
        
        if let dragonModel = dragonModel {
            Section(header: Text("Dragon model")) {
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(dragonModel.name)
                            .font(.largeTitle)
                            .bold()
                    }

                    Text("\(dragonModel.type.uppercased()) • \((dragonModel.active ? "Active" : "Inactive").uppercased())")
                        .foregroundColor(.gray)
                        .bold()

                    if let description = dragonModel.description {
                        Text(description.capitalizingFirstLetter())
                            .font(.system(.body, design: .serif))
                            .padding(.top, 8)
                    }
                }
                .padding(.top, 4)
                .padding(.bottom, 8)

                Group {
                    if let crewCapacity = dragonModel.crewCapacity {
                        InformationRow(label: "Crew capacity",
                                       value: "\(crewCapacity)",
                                       imageName: "person.2")
                    }

                    if let height = dragonModel.heightWithTrunk {
                        InformationRow(label: "Height (with trunk)",
                                       value: UsefulFormatters.measurementFormatter.string(from: height),
                                       imageName: "arrow.up.and.down")
                    }

                    if let diameter = dragonModel.diameter {
                        InformationRow(label: "Diameter",
                                       value: UsefulFormatters.measurementFormatter.string(from: diameter),
                                       imageName: "arrow.left.and.right.circle")
                    }

                    if let sidewallAngle = dragonModel.sidewallAngle {
                        InformationRow(label: "Sidewall angle",
                                       value: UsefulFormatters.measurementFormatter.string(from: sidewallAngle),
                                       imageName: "line.diagonal")
                    }
                }

                Group {
                    if let orbitDurationYears = dragonModel.orbitDurationYears {
                        InformationRow(label: "Orbit duration",
                                       value: "\(orbitDurationYears) years",
                                       imageName: "calendar")
                    }

                    if let dryMass = dragonModel.dryMass {
                        InformationRow(label: "Dry mass",
                                       value: UsefulFormatters.measurementFormatter.string(from: dryMass),
                                       imageName: "scalemass")
                    }

                    if let firstFlight = dragonModel.firstFlight {
                        InformationRow(label: "First flight",
                                       value: UsefulFormatters.shortDateFormatter.string(from: firstFlight),
                                       imageName: "1.circle")
                    }
                }

                if let heatShield = dragonModel.heatShield {
                    DisclosureGroup(
                        content: {
                            InformationRow(label: "Material",
                                           value: heatShield.material,
                                           imageName: "atom")

                            InformationRow(label: "Size",
                                           value: UsefulFormatters.measurementFormatter.string(from: heatShield.size),
                                           imageName: "ruler")

                            if let temperature = heatShield.temperature {
                                InformationRow(label: "Temperature",
                                               value: UsefulFormatters.measurementFormatter.string(from: temperature),
                                               imageName: "thermometer")
                            }

                            if let developmentPartner = heatShield.developmentPartner {
                                InformationRow(label: "Development partner",
                                               value: developmentPartner,
                                               imageName: "person.2.square.stack")
                            }
                        },
                        label: {
                            InformationRow(label: "Heatshield", imageName: "shield")
                        }
                    )
                }

                if let thrusters = dragonModel.thrusters,
                   thrusters.count > 0 {
                    DisclosureGroup(
                        content: {
                            ForEach(thrusters, id: \.type) { thruster in
                                DisclosureGroup(
                                    content: {
                                        InformationRow(label: "Amount",
                                                       value: "\(thruster.amount)",
                                                       imageName: "number")

                                        InformationRow(label: "Pods",
                                                       value: "\(thruster.pods)",
                                                       imageName: "circles.hexagongrid")

                                        InformationRow(label: "Fuel 1",
                                                       value: thruster.fuel1,
                                                       imageName: "drop")

                                        InformationRow(label: "Fuel 2",
                                                       value: thruster.fuel2,
                                                       imageName: "drop.triangle")

                                        InformationRow(label: "ISP",
                                                       value: "\(thruster.isp) s",
                                                       imageName: "stopwatch")

                                        InformationRow(label: "Thrust",
                                                       value: thruster.thrust.converted(to: .kiloNewton).description,
                                                       imageName: "arrow.up")
                                    },
                                    label: {
                                        InformationRow(label: thruster.type.capitalizingFirstLetter(), imageName: "arrow.forward")
                                    }
                                )
                            }
                        },
                        label: {
                            InformationRow(label: "Thrusters", imageName: "flame")
                        }
                    )
                }

                DisclosureGroup(
                    content: {
                        if let launchMass = dragonModel.launchPayloadMass {
                            InformationRow(label: "Launch payload mass",
                                           value: UsefulFormatters.measurementFormatter.string(from: launchMass),
                                           imageName: "scalemass")
                        }

                        if let returnMass = dragonModel.returnPayloadMass {
                            InformationRow(label: "Return payload mass",
                                           value: UsefulFormatters.measurementFormatter.string(from: returnMass),
                                           imageName: "scalemass")
                        }

                        if let launchVolume = dragonModel.launchPayloadVolume {
                            InformationRow(label: "Launch payload volume",
                                           value: UsefulFormatters.measurementFormatter.string(from: launchVolume),
                                           imageName: "move.3d")
                        }

                        if let returnVolume = dragonModel.returnPayloadVolume {
                            InformationRow(label: "Return payload volume",
                                           value: UsefulFormatters.measurementFormatter.string(from: returnVolume),
                                           imageName: "move.3d")
                        }

                        if let pressurizedVolume = dragonModel.pressurizedCapsule?.payloadVolume {
                            InformationRow(label: "Pressurized payload volume",
                                           value: UsefulFormatters.measurementFormatter.string(from: pressurizedVolume),
                                           imageName: "move.3d")
                        }

                        if let unpressurizedCargo = dragonModel.trunk?.cargo?.unpressurizedCargo {
                            InformationRow(label: "Unpressurized cargo",
                                           value: unpressurizedCargo ? "Yes" : "No",
                                           imageName: "shippingbox")
                        }
                    },
                    label: {
                        InformationRow(label: "Cargo", imageName: "arrow.up.arrow.down")
                    }
                )

                if let solarArray = dragonModel.trunk?.cargo?.solarArray {
                    InformationRow(label: "Solar arrays",
                                   value: "\(solarArray)",
                                   imageName: "sun.max")
                }
            }
        }

        if let launches = capsule?.launches,
           launches.count > 0 {
            Section(header: Text("Launches")) {
                ForEach(launches, id: \.stringID) {
                    LaunchListTile(launch: $0)
                }
            }
        }
    }
}

struct CapsuleSections_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PayloadCapsuleInstanceSections(payload: FakeData.shared.crewDragon?.payloads?.first ??
                FakeData.shared.crew2Payload!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
