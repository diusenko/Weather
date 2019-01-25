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
    
    public init(weatherJSON: WeatherJSON) {
        let weather = weatherJSON.main
        self.temperature = Int(weather.temperature)
        self.minTemperature = Int(weather.temperatureMin)
        self.maxTemperature = Int(weather.temperatureMax)
    }
}

class Country {
    
    public var name: String
    public var capital: String
    
    public init(countryJSON: CountryJSON) {
        self.name = countryJSON.name
        self.capital = countryJSON.capital
    }
}
