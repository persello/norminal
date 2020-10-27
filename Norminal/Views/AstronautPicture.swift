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
    
    init() {}
    
    private var rawImage: UIImage?
    private var callback: ((UIImage?) -> Void)?
    
    func startCrop(image input: UIImage, completionHandler: @escaping (UIImage?) -> Void) {
        
        // Setup
        self.rawImage = input
        self.callback = completionHandler
        
        let requestHandler = VNImageRequestHandler(cgImage: input.cgImage!, orientation: .up, options: [:])
        
        let faceRequest = VNDetectFaceLandmarksRequest(completionHandler: cropComplete)
        
        do {
            try requestHandler.perform([faceRequest])
        } catch {
            print(error)
        }
    }
    
    private func cropComplete(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNFaceObservation] else {
            print(error as Any)
            return
        }
        
        let face = observations[0]
        
        // Return
        if let c = callback {
            if let i = rawImage {
                c(self.cropToFace(face, i))
            } else {
                c(nil)
            }
        }
    }
    
    private func cropToFace(_ face: VNFaceObservation, _ image: UIImage) -> UIImage? {
        
        let w = face.boundingBox.size.width * image.size.width
        let h = face.boundingBox.size.height * image.size.height
        let x = face.boundingBox.origin.x * image.size.width
        let y = face.boundingBox.origin.y * image.size.height
        
        let center = CGPoint(x: x + (w / 2), y: image.size.height - (y + (h / 2)))
        var size = 2.5 * ((w + h) / 2)
        
        let minsize = min(center.x, center.y, image.size.width - center.x, image.size.height - center.y)
        
        if(size > minsize * 2) {
            size = minsize * 2
        }
        
        let origin = CGPoint(x: center.x - size/2, y: center.y - size/2)
        
        let extendedFaceRect = CGRect(origin: origin, size: CGSize(width: size, height: size))
        
        return cropImage(image, toRect: extendedFaceRect)
    }
    
    func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect) -> UIImage?
    {
        let imageViewScale = inputImage.scale
        
        // Scale cropRect to handle images larger than shown-on-screen size
        let cropZone = CGRect(x:cropRect.origin.x * imageViewScale,
                              y:cropRect.origin.y * imageViewScale,
                              width:cropRect.size.width * imageViewScale,
                              height:cropRect.size.height * imageViewScale)
        
        // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
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
    
    static var cache = NSCache<NSString, UIImage>()
    var cropper = FaceCropper()

    var body: some View {
        GeometryReader{g in
            if let image = croppedImage {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(g.size.height / 2)
            } else {
                ZStack {
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGray3), Color(UIColor.systemGray)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    Text(astronaut.getInitials())
                        .foregroundColor(.white)
                        .shadow(radius: 48)
                        .font(.system(size: g.size.height > g.size.width ? g.size.width * 0.45: g.size.height * 0.45, design: .rounded))
                }
                .onAppear(perform: {
                    if let cachedImage = AstronautPicture.cache.object(forKey: astronaut.idstring as NSString) {
                        croppedImage = cachedImage
                        print("Astronaut picture cache hit")
                    } else {
                        print("Astronaut picture cache miss")
                        astronaut.getImage({downloadResult in
                            if let rawImage = downloadResult {
                                cropper.startCrop(image: rawImage, completionHandler: {cropResult in
                                    if let image = cropResult {
                                        AstronautPicture.cache.setObject(image, forKey: astronaut.idstring as NSString)
                                        croppedImage = image
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
