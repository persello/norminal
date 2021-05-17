//
//  InformationRow.swift
//  Norminal
//
//  Created by Riccardo Persello on 16/05/21.
//

import SwiftUI

struct InformationRow<Icon: View>: View {
    public init(label: String, value: String? = nil, image: (() -> Icon)?, isSerial: Bool = false) {
        self.label = label
        self.value = value
        self.image = image ?? { Image("") as! Icon }
        self.isSerial = isSerial
    }

    var label: String
    var value: String?
    var image: () -> Icon?
    var isSerial = false

    var body: some View {
        HStack {
            Label { Text(label) } icon: { image() }
            Spacer()
            Text(value ?? "")
                .foregroundColor(.gray)
                .font(.system(.body, design: isSerial ? .monospaced : .default))
                .multilineTextAlignment(.trailing)
        }
    }
}

extension InformationRow where Icon == Image {
    init(label: String, value: String? = nil, imageName: String? = nil, isSerial: Bool = false) {
        self.label = label
        self.value = value
        image = { Image(systemName: imageName ?? "") }
        self.isSerial = isSerial
    }
}

struct InformationRow_Previews: PreviewProvider {
    static var previews: some View {
        InformationRow(label: "Serial number", value: "B2424", imageName: "dollarsign.circle")
            .padding()
    }
}
