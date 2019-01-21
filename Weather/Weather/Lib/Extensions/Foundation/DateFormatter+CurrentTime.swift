//
//  DateFormatter+CurrentTime.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/21/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    public var currentTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        return formatter
    }
    
}
