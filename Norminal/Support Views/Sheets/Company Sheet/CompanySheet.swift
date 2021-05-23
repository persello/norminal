//
//  CompanySheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI

struct CompanySheet: View {
    var company: CompanyInfo?
    var history: [HistoryEntry]

    var body: some View {
        List {
            Section {
                if let description = company?.summary {
                    Text(description)
                        .font(.system(.body, design: .serif))
                        .padding(4)
                }

                Group {
                    if let founder = company?.founder {
                        InformationRow(label: "Founder", value: founder, imageName: "figure.wave")
                    }

                    if let coo = company?.coo {
                        InformationRow(label: "COO", value: coo, imageName: "person")
                    }

                    if let propulsionCTO = company?.propulsionCTO {
                        InformationRow(label: "Propulsion CTO", value: propulsionCTO, imageName: "person")
                    }

                    if let year = company?.foundationYear {
                        InformationRow(label: "Foundation year", value: "\(year)", imageName: "calendar")
                    }
                }

                Group {
                    if let employees = company?.employees {
                        InformationRow(label: "Employees", value: "\(employees)", imageName: "person.2")
                    }

                    if let vehicles = company?.vehicles {
                        InformationRow(label: "Vehicles", value: "\(vehicles)", imageName: "number")
                    }

                    if let launchSites = company?.launchSites {
                        InformationRow(label: "Launch sites", value: "\(launchSites)", imageName: "arrow.up")
                    }

                    if let testSites = company?.testSites {
                        InformationRow(label: "Test sites", value: "\(testSites)", imageName: "gear")
                    }
                }

                Group {
                    if let address = company?.headquarters {
                        InformationRow(label: "Headquarters", value: "\(address)", imageName: "mappin.circle")
                    }

                    if let links = company?.links {
                        if let website = links.website {
                            Link(destination: website, label: {
                                InformationRow(label: "Website", imageName: "globe")
                            })
                        }

                        if let flickr = links.flickr {
                            Link(destination: flickr, label: {
                                InformationRow(label: "Flickr", imageName: "photo.on.rectangle.angled")
                            })
                        }
                    }
                }
            }

            Section(header: Text("History")) {
                LazyVStack(alignment: .leading) {
                    ForEach(history) { entry in
                        HistoryEntryTile(title: entry.title ?? "Unknown event", details: entry.details, date: entry.date, link: entry.links?.article)
                    }
                }
                .padding(.vertical)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(company?.name ?? "Company"))
    }
}

struct CompanySheet_Previews: PreviewProvider {
    static var previews: some View {
        CompanySheet(company: SpaceXData.shared.companyInfo, history: SpaceXData.shared.history)
    }
}
