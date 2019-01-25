//
//  Manager.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/16/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public class CountryData {
    
    public var country: CountryJSON
    public var weather: WeatherJSON?
    public var date: Date?
    
    public init(country: CountryJSON) {
        self.country = country
        self.weather = nil
    }
}

public class CountriesData {
    public var values: [CountryData] = []
}

public class Weather {
    public var temperature: Int
    public var minTemperature: Int
    public var maxTemperature: Int
    
    public init(weather: WeatherJSON) {
        let weather = weather.main
        self.temperature = Int(weather.temperature)
        self.minTemperature = Int(weather.tempMax)
        self.maxTemperature = Int(weather.tempMin)
    }
}

class Countries {
    public var values: [CountryJSON]
    
    public init(countries: [CountryJSON]) {
        self.values = countries
    }
}
