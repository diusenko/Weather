//
//  WeatherModel.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let main: [String : Double]
}
