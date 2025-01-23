//
//  Double+Round.swift
//  PersistentColorTests
//
//  Created by Jiaxin Shou on 2025/1/23.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
