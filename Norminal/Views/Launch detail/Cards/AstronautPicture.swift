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
    
    private var rawImage = UIImage()
    private var callback: ((UIImage) -> Void)?
    
    func startCrop(image input: UIImage, completionHandler: @escaping (UIImage) -> Void) {
        
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
            // TODO: Error handlers
            return
        }
        
        let face = observations[0]
        
        // Return
        if let c = callback {
            print("SAS")
            c(self.cropToFace(face, rawImage))
        }
    }
    
    private func cropToFace(_ face: VNFaceObservation, _ image: UIImage) -> UIImage {
        
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
        
        return cropImage(imageToCrop: image, toRect: extendedFaceRect)
    }
    
    private func cropImage(imageToCrop:UIImage, toRect rect:CGRect) -> UIImage{
        
        var imageRef: CGImage = imageToCrop.cgImage!
        
        imageRef = imageRef.cropping(to: rect)!
        let cropped: UIImage = UIImage(cgImage:imageRef)
        return cropped
    }
}

struct AstronautPicture: View {
    // Crew member
    @State var croppedImage: UIImage?
    @State var rawImage: UIImage
    
    var cropper = FaceCropper()
    
    var body: some View {
        GeometryReader{g in
            if(nil != croppedImage) {
                Image(uiImage: croppedImage!)
                    .resizable()
                    .cornerRadius(g.size.height / 2)
                    .scaledToFit()
                    .padding()
            } else {
                ZStack {
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGray3), Color(UIColor.systemGray)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    Text("RB")
                        .foregroundColor(.white)
                        .shadow(radius: 48)
                        .font(.system(size: g.size.height > g.size.width ? g.size.width * 0.45: g.size.height * 0.45, design: .rounded))
                }
                .padding()
                .onAppear(perform: {
                    cropper.startCrop(image: rawImage, completionHandler: {result in croppedImage = result})
                })
            }
        }
    }
}

struct AstronautPicture_Previews: PreviewProvider {
    static var previews: some View {
        AstronautPicture(rawImage: UIImage(named: "behnken")!)
    }
}
