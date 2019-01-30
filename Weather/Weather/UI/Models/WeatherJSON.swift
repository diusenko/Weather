//
//  WeatherJSON.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public struct WeatherJSON: Decodable {
    
    public var main: Main
    public var dt: Double
    
    public struct Main: Decodable {
        
        var temperature: Double
        var temperatureMin: Double
        var temperatureMax: Double
        
        private enum CodingKeys: String, CodingKey {
            
            case temperature = "temp"
            case temperatureMin = "temp_min"
            case temperatureMax = "temp_max"
        }
    }
}
