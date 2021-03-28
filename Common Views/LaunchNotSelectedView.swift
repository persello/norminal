//
//  LaunchNotSelectedView.swift
//  Norminal
//
//  Created by Riccardo Persello on 28/03/21.
//

import SwiftUI

struct LaunchNotSelectedView: View {
    var body: some View {
        Text("No launch selected")
            .font(.title)
            .foregroundColor(.secondary)
    }
}

struct LaunchNotSelectedView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchNotSelectedView()
    }
}
