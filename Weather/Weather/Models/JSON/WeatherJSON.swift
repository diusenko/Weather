//
//  WeatherJSON.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public struct WeatherJSON: Decodable {
    
    public let main: Main
    public let dt: Double
    public let sys: Sys
    
    public struct Main: Decodable {
        
        public let temperature: Double
        public let temperatureMin: Double
        public let temperatureMax: Double
        
        private enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case temperatureMin = "temp_min"
            case temperatureMax = "temp_max"
        }
    }
    
    public struct Sys: Codable {
        
        let country: String
    }
}
