//
//  Manager.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/16/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public class CountryData {
    
    public var country: Country
    public var weather: Weather?
    public var date: Date?
    
    public init(country: Country) {
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

public class Country {
    
    public var name: String
    public var capital: String
    
    public init(countryJSON: CountryJSON) {
        self.name = countryJSON.name
        self.capital = countryJSON.capital
    }
}
