//
//  QuarterDataModel.swift
//  SPHDemo
//
//  Created by admin on 2020/4/4.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class QuarterDataModel {
    var quarterInt = 0
    var volumeOfMobileData: Double = 0
    
    init(from json: JSON!) {
        if json == nil {
            return
        }
        let quarterString = json["quarter"].stringValue
        guard let year = Int(quarterString.prefix(4)) else {
            return
        }
        guard let quarter = Int(quarterString.suffix(1)) else {
            return
        }
        if year >= 2008 && year <= 2018 && quarter >= 1 && quarter <= 4 {
            quarterInt = year * 10 + quarter
        }
        volumeOfMobileData = json["volume_of_mobile_data"].doubleValue.roundTo(places: 8)
    }
}
