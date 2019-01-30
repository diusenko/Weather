//
//  Date+Short.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/17/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

extension Date {
    
    var shortDescription: String {
        return DateFormatter().currentTime.string(from: self)
    }
}
