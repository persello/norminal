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

class FaceCropper {
    
    typealias FaceCropperCallback = (Result<UIImage, Error>) -> Void
    
    private var rawImage: UIImage?
    private var callback: FaceCropperCallback?
    
    private var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Face cropper")
    
    func startCrop(image input: UIImage, completionHandler: @escaping FaceCropperCallback) {
        
        // Setup
        self.rawImage = input
        self.callback = completionHandler
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let requestHandler = VNImageRequestHandler(cgImage: input.cgImage!, orientation: .up, options: [:])
            
            let faceRequest = VNDetectFaceLandmarksRequest(completionHandler: self.cropComplete)
            
            do {
                try requestHandler.perform([faceRequest])
            } catch {
                self.logger.error("Error while requesting face crop: \"\(error.localizedDescription)\"")
                completionHandler(.failure(error))
            }
        }
    }
    
    private func cropComplete(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNFaceObservation] else {
            if let error = error {
                logger.error("Error while getting face observations: \"\(error.localizedDescription)\".")
                callback?(.failure(error))
            }
            return
        }
        
        let face = observations[0]
        
        // Return
        if let callback = callback,
           let image = rawImage,
           let cropped = self.cropToFace(face, image)?.scaleWith(newSize: CGSize(width: 256, height: 256)) {
            callback(.success(cropped))
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
                                    Color(UIColor.systemGray3),
                                    Color(UIColor.systemGray)
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
                        if let image = RemoteImage(imageURL: url)[".cropped"] {
                            croppedImage = image
                            if croppedImage != nil {
                                logger.info("Cropped astronaut picture cache hit.")
                                return
                            }
                        } else {
                            logger.info("Cropped astronaut picture cache miss. Retrieving original and cropping.")
                            try? RemoteImage(imageURL: url).image(completion: { image in
                                if let rawImage = image {
                                    cropper.startCrop(image: rawImage, completionHandler: { cropResult in
                                        switch cropResult {
                                            case .success(let image):
                                                RemoteImage(imageURL: url)[".cropped"] = image
                                                croppedImage = image
                                            case .failure(let error):
                                                logger.error("Cannot crop image for \(astronaut.name): \"\(error as NSObject)\".")
                                        }
                                    })
                                }
                            })
                        }
                        
                    }
                })
            }
        }
    }
}

struct AstronautPicture_Previews: PreviewProvider {
    static var previews: some View {
        AstronautPicture(astronaut: FakeData.shared.robertBehnken!)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
