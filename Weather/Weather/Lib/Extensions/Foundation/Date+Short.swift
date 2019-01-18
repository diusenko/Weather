//
//  Date+Short.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/17/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

extension Date {
    
    public var shortDescription: String {
        return DateFormatter().short.string(from: self)
    }
}

extension DateFormatter {
    
    public var short: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter
    }
}
