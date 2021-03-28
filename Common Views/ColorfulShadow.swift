//
//  ColorfulShadow.swift
//  NorminalMac
//
//  Created by Riccardo Persello on 28/03/21.
//

import SwiftUI

extension View {
    func colorfulShadow(radius: CGFloat, saturation: Double = 1) -> some View {
        return ZStack {
            self
                .blur(radius: radius)
                .saturation(saturation)
            
            self
        }
    }
}
