//
//  Weather.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/29/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public class Weather {
    
    public let temperature: Int
    public let minTemperature: Int
    public let maxTemperature: Int
    public let date: Date
    
    public init(temperature: Int, date: Date, minTemperature: Int, maxTemperature: Int) {
        self.temperature = temperature
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.date = date
    }
}
