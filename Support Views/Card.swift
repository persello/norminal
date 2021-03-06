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
  
  init(@ViewBuilder background: @escaping () -> Background, @ViewBuilder content: @escaping () -> Content) {
    self.background = background
    self.content = content
  }
  
  var body: some View {
    ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
      GeometryReader { geometry in
        
        background()
          // TODO: Remove this padding and get bottom part size instead
          .padding(.bottom, 72)
          .frame(width: geometry.size.width,
                 height: geometry.size.height,
                 alignment: .center)
          .clipped()
          .scaledToFit()
        
        content()
          .padding(24)
      }
      .clipped()
      .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
      .shadow(radius: 24)
      .aspectRatio(4 / 5, contentMode: .fill)
      .scaledToFit()
      .scaleEffect(self.scale)
      .animation(.easeInOut)
      .onTapGesture {} // Otherwise you can't scroll the list anymore
      .contentShape(Rectangle())
      .onLongPressGesture(minimumDuration: 10, pressing: { inProgress in
        self.scale = inProgress ? 0.95 : 1
      }, perform: {
        self.scale = 1
      })
    }
  }
}

struct Card_Previews: PreviewProvider {
  static var previews: some View {
    Card(background: {
      Image("sample1")
        .resizable()
        .aspectRatio(contentMode: .fill)
    }, content: {
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
        Text("Bottom text maybe with a button?")
          .fontWeight(.semibold)
          .foregroundColor(.white)
          .padding(.vertical)
      }
    })
    .padding(24)
  }
}
