//
//  Country.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/29/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public class Country {
    
    public let name: String
    public let capital: String
    public var weather: ObservableWrapper<Weather?>
    
    public init(name: String, capitalName: String, weather: Weather? = nil) {
        self.name = name
        self.capital = capitalName
        self.weather = ObservableWrapper(weather)
    }
}
