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
    
    public init(weatherJSON: WeatherJSON) {
        let weather = weatherJSON.main
        self.temperature = Int(weather.temperature)
        self.minTemperature = Int(weather.temperatureMin)
        self.maxTemperature = Int(weather.temperatureMax)
        self.date = Date(timeIntervalSince1970: TimeInterval(weatherJSON.dt))
    }
}
