//
//  LaunchDetailResourcesView.swift
//  Norminal
//
//  Created by Riccardo Persello on 20/03/21.
//

import SwiftUI

struct LaunchDetailResourcesView: View {
    
    @EnvironmentObject var launch: Launch
    @State var isRedditActionSheetPresented: Bool = false
    
    var redditButtons: [ActionSheet.Button] {
        var list: [ActionSheet.Button] = [ActionSheet.Button.cancel()]
        
        if let campaignLink = launch.links?.reddit?.campaign {
            list.append(ActionSheet.Button.default(Text("Campaign")) {
                UIApplication.shared.open(campaignLink)
            })
        }
        
        if let launchLink = launch.links?.reddit?.launch {
            list.append(ActionSheet.Button.default(Text("Launch")) {
                UIApplication.shared.open(launchLink)
            })
        }
        
        if let mediaLink = launch.links?.reddit?.media {
            list.append(ActionSheet.Button.default(Text("Media")) {
                UIApplication.shared.open(mediaLink)
            })
        }
        
        if let recoveryLink = launch.links?.reddit?.recovery {
            list.append(ActionSheet.Button.default(Text("Recovery")) {
                UIApplication.shared.open(recoveryLink)
            })
        }
        
        return list
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if redditButtons.count > 1 ||
                launch.links?.webcast != nil ||
                launch.links?.pressKit != nil ||
                launch.links?.wikipedia != nil {
                
                Text("Resources")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                    .padding(.top, 48)
                    .padding(.bottom, -8)
                
                
                List {
                    
                    if redditButtons.count > 1 {
                        Button(action: {
                            isRedditActionSheetPresented = true
                        }) {
                            HStack {
                                Image("reddit.logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .padding(.horizontal, 4)
                                
                                Text("Reddit")
                            }
                        }
                        .actionSheet(isPresented: $isRedditActionSheetPresented, content: {
                            // TODO: Enumerate across optional links and don't present action sheet if only one is available
                            ActionSheet(title: Text("Choose Reddit coverage post"), buttons: redditButtons)
                        })
                    }
                    
                    if let webcast = launch.links?.webcast {
                        Button(action: {
                            UIApplication.shared.open(webcast)
                        }) {
                            HStack {
                                Image("youtube.logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .padding(.horizontal, 4)
                                
                                Text("YouTube")
                            }
                        }
                    }
                    
                    if let presskit = launch.links?.pressKit {
                        Button(action: {
                            UIApplication.shared.open(presskit)
                        }) {
                            HStack {
                                Image(systemName: "newspaper.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 4)
                                
                                Text("Press Kit")
                            }
                        }
                    }
                    
                    if let wikipedia = launch.links?.wikipedia {
                        Button(action: {
                            UIApplication.shared.open(wikipedia)
                        }) {
                            HStack {
                                Image("wikipedia.logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .frame(width: 28, height: 28)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                                
                                Text("Wikipedia")
                            }
                        }
                    }
                }
            }
        }
        .frame(height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct LaunchDetailResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchDetailResourcesView()
            .environmentObject(FakeData.shared.crewDragon!)
            .previewLayout(.sizeThatFits)
    }
}
