//
//  GlobeView.swift
//  Norminal
//
//  Created by Riccardo Persello on 05/05/21.
//

import SwiftUI
import SceneKit

extension SCNVector3 {
    static func +(_ lhs: SCNVector3, _ rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(rhs.x + lhs.x, rhs.y + lhs.y, lhs.z + rhs.z)
    }
}

struct GlobeView: View {
    var scene = SCNScene()
    let cameraNode = SCNNode()

    
    init() {
        let earthNode = Earth().node
        
        cameraNode.camera = SCNCamera()
        cameraNode.position = earthNode.position + SCNVector3(0, 0, 15)
        cameraNode.look(at: earthNode.position)
        cameraNode.camera?.fieldOfView = 60
        
        let light = SCNLight()
        light.type = .spot
        light.spotOuterAngle = 45
        light.intensity = 2000
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = earthNode.position + SCNVector3(20, 20, 0)
        lightNode.look(at: earthNode.position)
        
        scene.rootNode.addChildNode(earthNode)
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(lightNode)
        scene.background.contents = UIColor.black
        scene.lightingEnvironment.contents = UIColor.black
    }
    
    var body: some View {
        SceneView(scene: scene, pointOfView: cameraNode, options: [.allowsCameraControl], preferredFramesPerSecond: 120, antialiasingMode: .multisampling4X)
            .frame(width: 400, height: 400, alignment: .center)
    }
}

struct GlobeView_Previews: PreviewProvider {
    static var previews: some View {
        GlobeView()
            .scaledToFit()
    }
}
