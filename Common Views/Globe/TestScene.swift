//
//  TestScene.swift
//  Norminal
//
//  Created by Riccardo Persello on 05/05/21.
//

import Foundation
import SceneKit

class Planet {
    static var scalingFactor: CGFloat = 1e-3
    
    init(radius: Measurement<UnitLength>) {
        self.radius = radius
    }
    
    private var radius: Measurement<UnitLength>
    fileprivate var material = SCNMaterial()
    
    public var node: SCNNode {
        let sphere = SCNSphere(radius: CGFloat(radius.converted(to: .kilometers).value) * Planet.scalingFactor)
        sphere.materials = [material]
        
        let node = SCNNode(geometry: sphere)
        return node
    }
}

final class Earth: Planet {
    init() {
        super.init(radius: .init(value: 6371, unit: .kilometers))
        self.material.diffuse.contents = UIImage(named: "8k_earth_daymap")
        self.material.selfIllumination.contents = UIImage(named: "8k_earth_nightmap")
        self.material.selfIllumination.intensity = 5
        self.material.normal.contents = UIImage(named: "8k_earth_normal_map")
        self.material.normal.intensity = 8
        self.material.reflective.contents = UIImage(named: "8k_earth_specular_map_inverted")
    }
}
