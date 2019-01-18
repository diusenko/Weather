//
//  WeatherModel.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    var main: Main
    
    struct Main: Codable {
        var temperature: Double
        let pressure: Int
        let humidity: Int
        let tempMin, tempMax: Double
        
        enum CodingKeys: String, CodingKey {
            case pressure, humidity
            case temperature = "temp"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
}
