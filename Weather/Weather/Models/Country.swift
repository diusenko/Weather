//
//  Country.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/29/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public class Country {
    
    public let id: String
    public let name: String
    public let capital: String
    public var weather: ObservableWrapper<Weather?>
    
    public init(id: String, name: String, capital: String, weather: Weather? = nil) {
        self.name = name
        self.capital = capital
        self.weather = ObservableWrapper(weather)
        self.id = id
    }
}
