//
//  InformationRow.swift
//  Norminal
//
//  Created by Riccardo Persello on 16/05/21.
//

import SwiftUI

struct InformationRow: View {
    var label: String
    var value: String?
    var imageName: String?
    var isSerial = false
    
    var body: some View {
        HStack {
            Label(label, systemImage: imageName ?? "")
            Spacer()
            Text(value ?? "")
                .foregroundColor(.gray)
                .font(.system(.body, design: isSerial ? .monospaced : .default))
                .multilineTextAlignment(.trailing)
        }
    }
}

struct InformationRow_Previews: PreviewProvider {
    static var previews: some View {
        InformationRow(label: "Serial number", value: "B2424", imageName: "dollarsign.circle")
            .padding()
    }
}
