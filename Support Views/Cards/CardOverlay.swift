//
//  CardOverlay.swift
//  Norminal
//
//  Created by Riccardo Persello on 28/10/2020.
//

import SwiftUI

struct CardOverlay: View {
    @State var preamble: String
    @State var title: String
    @State var bottomText: String
    @State var buttonText: String
    @State var buttonAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(preamble.uppercased())
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .shadow(radius: 12)
            Spacer()
            HStack {
                Text(bottomText)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(UIColor.label))
                Spacer()
                Button(action: buttonAction) {
                    Text(buttonText)
                }
                .buttonStyle(RoundedButtonStyle())

            }
                .padding(.vertical, 8)
                .background(Rectangle().padding(-24).foregroundColor(Color(UIColor.systemGray6)))
        }
    }
}

struct CardOverlay_Previews: PreviewProvider {
    static var previews: some View {
        CardOverlay(preamble: "Preamble",
                    title: "Title",
                    bottomText: "Bottom text",
                    buttonText: "Open",
                    buttonAction: {})
            .padding()
            .previewLayout(.fixed(width: 300, height: 450))
    }
}
