//
//  NotSelectedView.swift
//  Norminal
//
//  Created by Riccardo Persello on 28/03/21.
//

import SwiftUI

struct NotSelectedView: View {
    var body: some View {
        VStack {
            Text("No entry selected")
                .font(.title)
            
            Text("Select something from the side menu")
                .foregroundColor(.gray)
        }
    }
}

struct NotSelectedView_Previews: PreviewProvider {
    static var previews: some View {
        NotSelectedView()
    }
}
