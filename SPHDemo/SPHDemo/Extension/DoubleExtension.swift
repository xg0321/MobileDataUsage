//
//  DoubleExtension.swift
//  SPHDemo
//
//  Created by admin on 2020/4/4.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
