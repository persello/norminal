//
//  UsefulFormatters.swift
//  Norminal
//
//  Created by Riccardo Persello on 17/05/21.
//

import Foundation

struct UsefulFormatters {
    static var percentageFormatter: NumberFormatter {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0
        f.locale = Locale.current
        f.numberStyle = .percent
        
        return f
    }
    
    static var dollarsFormatter: NumberFormatter {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0
        f.locale = Locale(identifier: "en_US")
        f.numberStyle = .currency
        
        return f
    }
    
    static var measurementFormatter: MeasurementFormatter {
        let f = MeasurementFormatter()
        f.numberFormatter.minimumFractionDigits = 0
        f.numberFormatter.maximumFractionDigits = 2
        f.numberFormatter.roundingMode = .halfEven
        f.unitOptions = .naturalScale
        
        return f
    }
    
    static var plainNumberFormatter: NumberFormatter {
        let f = NumberFormatter()
        f.groupingSeparator = ""
        
        return f
    }
}
