//
//  Country.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/29/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public class Country {
    
    public var name: String
    public var capital: String
    
    public init(countryJSON: CountryJSON) {
        self.name = countryJSON.name
        self.capital = countryJSON.capital
    }
}
