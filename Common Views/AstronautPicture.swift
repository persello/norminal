//
//  AstronautPicture.swift
//  Norminal
//
//  Created by Riccardo Persello on 14/10/2020.
//

import SwiftUI
import Telescope
import Vision
import os

struct AstronautPicture: View, Equatable {
    
    // Crew member
    @State var croppedImage: UIImage?
    var astronaut: Astronaut
    
    static func == (lhs: AstronautPicture, rhs: AstronautPicture) -> Bool {
        return lhs.astronaut.idstring == rhs.astronaut.idstring
    }
        
    var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Astronaut picture")
    
    var body: some View {
        GeometryReader { geometry in
            if let image = croppedImage {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            } else {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(.systemGray3),
                                    Color(.systemGray)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)
                        )
                    Text(astronaut.getInitials())
                        .foregroundColor(.white)
                        .shadow(radius: 48)
                        .font(.system(size: (geometry.size.height > geometry.size.width)
                                        ? geometry.size.width * 0.45
                                        : geometry.size.height * 0.45,
                                      design: .rounded))
                }
                .onAppear {
                    DispatchQueue.global(qos: .background).async {
                        astronaut.getImage { result in
                            switch result {
                            case .failure(let error):
                                self.logger.error("Error occurred during getImage() for \(astronaut.name): \"\(error.localizedDescription)\".")
                            case .success(let image):
                                DispatchQueue.main.async {
                                    croppedImage = image
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


struct AstronautPicture_Previews: PreviewProvider {
    static var previews: some View {
        AstronautPicture(astronaut: FakeData.shared.robertBehnken!)
            .previewLayout(.fixed(width: 200, height: 200))
            .colorfulShadow(radius: 12)
    }
}
