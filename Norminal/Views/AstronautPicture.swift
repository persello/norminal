//
//  AstronautPicture.swift
//  Norminal
//
//  Created by Riccardo Persello on 14/10/2020.
//

import SwiftUI
import Vision
import os

class FaceCropper {
  
  init() { }
  
  private var rawImage: UIImage?
  private var callback: ((UIImage?) -> Void)?
  
  private var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Face cropper")
  
  func startCrop(image input: UIImage, completionHandler: @escaping (UIImage?) -> Void) {
    
    // Setup
    self.rawImage = input
    self.callback = completionHandler
    
    let requestHandler = VNImageRequestHandler(cgImage: input.cgImage!, orientation: .up, options: [:])
    
    let faceRequest = VNDetectFaceLandmarksRequest(completionHandler: cropComplete)
    
    do {
      try requestHandler.perform([faceRequest])
    } catch {
      logger.error("Error while requesting face crop: \"\(error.localizedDescription)\"")
    }
  }
  
  private func cropComplete(request: VNRequest, error: Error?) {
    guard let observations = request.results as? [VNFaceObservation] else {
      logger.error("Error while getting face observations: \"\(error?.localizedDescription ?? "Unknown error")\"")
      return
    }
    
    let face = observations[0]
    
    // Return
    if let finishCallback = callback {
      if let image = rawImage {
        finishCallback(self.cropToFace(face, image))
      } else {
        finishCallback(nil)
      }
    }
  }
  
  private func cropToFace(_ face: VNFaceObservation, _ image: UIImage) -> UIImage? {
    
    let faceWidth = face.boundingBox.size.width * image.size.width
    let faceHeight = face.boundingBox.size.height * image.size.height
    let faceX = face.boundingBox.origin.x * image.size.width
    let faceY = face.boundingBox.origin.y * image.size.height
    
    let center = CGPoint(x: faceX + (faceWidth / 2), y: image.size.height - (faceY + (faceHeight / 2)))
    var size = 2.5 * ((faceWidth + faceHeight) / 2)
    
    let minsize = min(center.x, center.y, image.size.width - center.x, image.size.height - center.y)
    
    if size > minsize * 2 {
      size = minsize * 2
    }
    
    let origin = CGPoint(x: center.x - size / 2, y: center.y - size / 2)
    
    let extendedFaceRect = CGRect(origin: origin, size: CGSize(width: size, height: size))
    
    return cropImage(image, toRect: extendedFaceRect)
  }
  
  func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect) -> UIImage? {
    let imageViewScale = inputImage.scale
    
    // Scale cropRect to handle images larger than shown-on-screen size
    let cropZone = CGRect(x: cropRect.origin.x * imageViewScale,
                          y: cropRect.origin.y * imageViewScale,
                          width: cropRect.size.width * imageViewScale,
                          height: cropRect.size.height * imageViewScale)
    
    // Perform cropping in Core Graphics
    guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to: cropZone)
    else {
      return nil
    }
    
    // Return image to UIImage
    let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
    return croppedImage
  }
}

struct AstronautPicture: View {
  // Crew member
  @State var croppedImage: UIImage?
  @State var astronaut: Astronaut
  
  var cropper = FaceCropper()
  
  var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Astronaut picture")
  
  var body: some View {
    GeometryReader { geometry in
      if let image = croppedImage {
        Image(uiImage: image)
          .resizable()
          .cornerRadius(geometry.size.height / 2)
      } else {
        ZStack {
          Circle()
            .fill(LinearGradient(
                    gradient: Gradient(colors: [
                      Color(UIColor.systemGray3), Color(UIColor.systemGray)
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
        .onAppear(perform: {
          if let url = astronaut.image {
            ImageCache.shared.get(fromURL: url, withTag: ".cropped", completion: { image in
              croppedImage = image
              if croppedImage != nil {
                logger.info("Cropped astronaut picture cache hit.")
                return
              } else {
                logger.info("Cropped astronaut picture cache miss. Retrieving original and cropping.")
                ImageCache.shared.get(fromURL: url, withTag: nil, completion: { image in
                  if let rawImage = image {
                    cropper.startCrop(image: rawImage, completionHandler: { cropResult in
                      if let image = cropResult {
                        ImageCache.shared.update(image: image, ofURL: url, withTag: ".cropped")
                        croppedImage = image
                      }
                    })
                  }
                })
              }
            })
          }
        })
      }
    }
  }
}

struct AstronautPicture_Previews: PreviewProvider {
  static var previews: some View {
    AstronautPicture(astronaut: FakeData.shared.robertBehnken!)
  }
}
