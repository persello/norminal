//
//  PayloadRoadsterSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 22/05/21.
//

import SwiftUI

struct PayloadRoadsterSection: View {
    var roadster: Roadster

    var body: some View {
        Section(header: Text("Roadster")) {
            VStack(alignment: .leading) {
                if let imageURLs = roadster.flickrImages {
                    TImageWithGalleryButton(imageURLs: imageURLs)
                }

                VStack(alignment: .leading) {
                    Text(roadster.name ?? "Roadster")
                        .font(.title2)
                        .bold()

                    if let md = roadster.marsDistance,
                       let ed = roadster.earthDistance {
                        Text("""
                        \(md.converted(to: .astronomicalUnits).value) AU from Mars
                        \(ed.converted(to: .astronomicalUnits).value) AU from Earth
                        """)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.bottom, 8)
                .padding(.top, 24)

                if let details = roadster.details {
                    Text(details)
                        .font(.system(.body, design: .serif))
                        .padding(.bottom, 12)
                }
            }

            Group {
                if let wikipedia = roadster.wikipedia {
                    Button(action: {
                        UIApplication.shared.open(wikipedia)
                    }) {
                        HStack {
                            Image("wikipedia.logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(.horizontal, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                                        .frame(width: 28, height: 28, alignment: .center)
                                        .foregroundColor(.white)
                                )

                            Text("Wikipedia")
                                .foregroundColor(.primary)
                        }
                    }
                }

                if let ytURL = roadster.video {
                    Button(action: {
                        UIApplication.shared.open(ytURL)
                    }) {
                        HStack {
                            Image("youtube.logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(.horizontal, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                                        .frame(width: 28, height: 28, alignment: .center)
                                        .foregroundColor(.white)
                                )

                            Text("YouTube")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }

            Group {
                if let launchDate = roadster.launchDate {
                    InformationRow(label: "Launch date",
                                   value: UsefulFormatters.shortDateFormatter.string(from: launchDate),
                                   imageName: "calendar")
                }

                if let launchMass = roadster.launchMass {
                    InformationRow(label: "Launch mass",
                                   value: UsefulFormatters.measurementFormatter.string(from: launchMass),
                                   imageName: "scalemass")
                }

                if let speed = roadster.speed {
                    InformationRow(label: "Speed",
                                   value: UsefulFormatters.measurementFormatter.string(from: speed),
                                   imageName: "gauge")
                }

                DisclosureGroup(
                    content: {
                        if let orbit = roadster.orbit {
                            InformationRow(label: "Type",
                                           value: orbit.capitalizingFirstLetter(),
                                           imageName: "circle.dashed")
                        }

                        if let semiMajorAxis = roadster.semiMajorAxis {
                            InformationRow(label: "Semimajor axis",
                                           value: "\(UsefulFormatters.nDecimalsNumberFormatter(3).string(from: NSNumber(value: semiMajorAxis.converted(to: .astronomicalUnits).value))!) AU",
                                           imageName: "arrow.left.and.right")
                        }

                        if let eccentricity = roadster.eccentricity {
                            InformationRow(label: "Eccentricity",
                                           value: UsefulFormatters.nDecimalsNumberFormatter(3).string(from: NSNumber(value: eccentricity)),
                                           imageName: "oval")
                        }

                        if let periapsis = roadster.periapsis,
                           let periapsisArgument = roadster.periapsisArgument {
                            InformationRow(label: "Periapsis",
                                           value: "\(UsefulFormatters.nDecimalsNumberFormatter(3).string(from: NSNumber(value: periapsis.converted(to: .astronomicalUnits).value))!) AU ∡\(UsefulFormatters.measurementFormatter.string(from: periapsisArgument))",
                                           imageName: "arrow.right.to.line")
                        }

                        if let apoapsis = roadster.apoapsis {
                            InformationRow(label: "Apoapsis",
                                           value: "\(UsefulFormatters.nDecimalsNumberFormatter(3).string(from: NSNumber(value: apoapsis.converted(to: .astronomicalUnits).value))!) AU",
                                           imageName: "arrow.right.to.line.alt")
                        }

                        if let inclination = roadster.inclination {
                            InformationRow(label: "Inclination",
                                           value: UsefulFormatters.measurementFormatter.string(from: inclination),
                                           imageName: "line.diagonal")
                        }

                        if let longitude = roadster.longitude {
                            InformationRow(label: "Longitude",
                                           value: UsefulFormatters.measurementFormatter.string(from: longitude),
                                           imageName: "smallcircle.fill.circle")
                        }

                        if let periodDays = roadster.periodDays {
                            InformationRow(label: "Period",
                                           value: "\(UsefulFormatters.plainNumberFormatter.string(from: NSNumber(value: periodDays))!) days",
                                           imageName: "stopwatch")
                        }
                    },
                    label: { InformationRow(label: "Orbit", imageName: "circle") }
                )
            }
        }
    }
}

struct PayloadRoadsterSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PayloadRoadsterSection(roadster: FakeData.shared.roadster!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
