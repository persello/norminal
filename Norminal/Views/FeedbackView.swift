//
//  FeedbackView.swift
//  Norminal
//
//  Created by Riccardo Persello on 20/03/21.
//

import SwiftUI

struct FeedbackView: View {
    var body: some View {
        VStack {
            HStack {
                if let icon = Bundle.main.icon {
                    Image(uiImage: icon)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12,
                                             style: .continuous))
                }
                
                VStack(alignment: .leading) {
                    Text("Norminal")
                        .font(.title)
                    Text("v\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
            }
            Link(destination: URL(string: "https://forms.gle/1pzmsASLWYjEPnU5A")!, label: {
                Text("Join the Alpha channel")
            })
            .padding(48)
        }
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
            .previewLayout(.sizeThatFits)
    }
}
