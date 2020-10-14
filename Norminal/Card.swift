//
//  Card.swift
//  Norminal
//
//  Created by Riccardo Persello on 11/10/2020.
//

import SwiftUI

struct Card<Background : View, Content: View>: View {
    let background: () -> Background
    let content: () -> Content
    
    init(@ViewBuilder background: @escaping () -> Background, @ViewBuilder content: @escaping () -> Content) {
        self.background = background
        self.content = content
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            GeometryReader { geometry in
                
                background()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                    .scaledToFit()
                
                content()
                    .padding()
            }
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(radius: 24)
            .aspectRatio(4/5, contentMode: .fill)
            .scaledToFit()
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(background: {
            Image("sample1")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }, content:  {
            VStack(alignment: .leading, spacing: 8) {
                Text("Preamble text uppercased".uppercased())
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                Text("Title, long title, on two lines")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .shadow(radius: 12)
                Spacer()
                Text("AAA")
                    .foregroundColor(.white)
            }
        })
        .padding(24)
    }
}
