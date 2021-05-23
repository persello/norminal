//
//  AboutView.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import MessageUI
import SwiftUI

struct AboutView: View {
    @State var isShowingMailView: Bool = false

    var body: some View {
        List {
            Section {
                VStack(alignment: .center) {
                    if let icon = Bundle.main.icon {
                        Image(uiImage: icon)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .frame(height: 80)
                    }

                    Text("Norminal")
                        .font(.largeTitle)
                        .bold()

                    Text(Bundle.main.bundleIdentifier ?? "")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding()

                InformationRow(label: "Version",
                               value: "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown") (\(Bundle.main.infoDictionary?["CFBundleVersion"] ?? 0))",
                               imageName: "number")

                Link(destination: URL(string: "https://github.com/persello/norminal")!, label: {
                    InformationRow(label: "Repository", imageName: "link")
                })

//                Link(destination: URL(string: "https://persello.tk/projects/norminal")!, label: {
//                    InformationRow(label: "Website", imageName: "globe")
//                })
            }

            if WhereAmIRunning.isTestFlight {
                Section(header: Text("TestFlight")) {
                    Link(destination: URL(string: "https://forms.gle/LPbEWxZBBYHNEED36")!, label: {
                        InformationRow(label: "Join the Alpha channel", imageName: "link")
                    })

                    Text("To send feedback, take a screenshot.")
                }
            } else {
                Section(header: Text("Feedback")) {
                    Link(destination: URL(string: "https://testflight.apple.com/join/CirlA6HB")!, label: {
                        InformationRow(label: "Join the TestFlight Beta", imageName: "link")
                    })

                    Link(destination: URL(string: "mailto:riccardo.persello@icloud.com")!, label: {
                        InformationRow(label: "Send a feedback e-mail", imageName: "exclamationmark.bubble")
                    })
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("About"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutView()
        }
    }
}
