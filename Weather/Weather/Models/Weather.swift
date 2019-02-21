//
//  Weather.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/29/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public class Weather {
    
    public let id: String
    public let temperature: Int
    public let date: Date
    
    public init(id: String, temperature: Int, date: Date) {
        self.temperature = temperature
        self.date = date
        self.id = id
    }
}
