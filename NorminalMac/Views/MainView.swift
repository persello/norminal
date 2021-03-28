//
//  MainView.swift
//  NorminalMac
//
//  Created by Riccardo Persello on 28/03/21.
//

import SwiftUI

enum Screens: Equatable, Identifiable {
    case launches
    case feedback
    
    var id: Screens { self }
}

struct SidebarView: View {
    @State var selectedView: Screens? = .launches
    
    static func toggle() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
    var body: some View {
        List {
            Group {
                NavigationLink(destination: LaunchListView(), tag: Screens.launches, selection: $selectedView) {
                    Label("Launches", systemImage: "flame")
                }
                NavigationLink(destination: EmptyView(), tag: Screens.feedback, selection: $selectedView) {
                    Label("Feedback", systemImage: "exclamationmark.bubble")
                }
            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 200, idealWidth: 250)
        .toolbar{
            ToolbarItem(placement: .automatic){
                Button(action: SidebarView.toggle, label: {
                    Image(systemName: "sidebar.leading")
                })
            }
        }
    }
}

struct MainView: View {
    var body: some View {
        NavigationView {
            SidebarView()
            LaunchListView()
            DetView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
