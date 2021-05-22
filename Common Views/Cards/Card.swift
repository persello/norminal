//
//  Card.swift
//  Norminal
//
//  Created by Riccardo Persello on 11/10/2020.
//

import SwiftUI

struct Card<Background: View, Content: View>: View {
    let background: () -> Background
    let content: () -> Content

    @State private var scale: CGFloat = 1
    var aspectRatio: CGFloat
    var bottomBackgroundPadding: CGFloat
    var onTap: () -> Void

    init(@ViewBuilder background: @escaping () -> Background,
         @ViewBuilder content: @escaping () -> Content,
         aspectRatio: CGFloat = 4 / 5,
         bottomBackgroundPadding: CGFloat = 72,
         onTap: @escaping () -> Void = {}) {
        self.background = background
        self.content = content
        self.aspectRatio = aspectRatio
        self.bottomBackgroundPadding = bottomBackgroundPadding
        self.onTap = onTap
    }

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            GeometryReader { geometry in

                Color(.systemGray5)

                background()
                    .padding(.bottom, bottomBackgroundPadding)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height,
                           alignment: .center)
                    .scaledToFill()

                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.6), .clear]),
                        startPoint: .top,
                        endPoint: .bottom))
                    .frame(height: 240)

                content()
                    .padding(24)
            }
        }
//        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(radius: 24)
        .aspectRatio(aspectRatio, contentMode: .fill)
        .scaleEffect(self.scale)
        .contentShape(Rectangle())
        .animation(.easeInOut)
        .onTapGesture { onTap() } // Otherwise you can't scroll the list anymore
        .onLongPressGesture(minimumDuration: 10, pressing: { inProgress in
            self.scale = inProgress ? 0.95 : 1
        }, perform: {
            self.scale = 1
        })
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WebcastCard()
            CrewCard()
            MissionDetailsCard()
            RocketCard()
            PayloadCard()
            GalleryCard()
            Card(background: {}, content: {})
        }
        .frame(width: 400, height: 500, alignment: .center)
        .environmentObject(FakeData.shared.crewDragon!)
        .previewLayout(.sizeThatFits)
        .padding(48)
    }
}
