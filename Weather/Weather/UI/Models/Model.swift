//
//  Manager.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/16/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class CountryData {
    
    public var country: Country
    public var weather: Weather?
    public var date: Date?
    
    init(country: Country) {
        self.country = country
        self.weather = nil
    }
}

class CountriesData {
    public var values: [CountryData] = []
}
