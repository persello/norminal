//
//  StringCapitalization.swift
//  Norminal
//
//  Created by Riccardo Persello on 16/05/21.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
