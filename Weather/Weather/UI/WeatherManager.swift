//
//  WeatherManager.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/24/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

fileprivate struct WeatherConstant {
    
    static let link: (String) -> String = { capital in
        let query = "https://api.openweathermap.org/data/2.5/weather?q="
        let unitsAndAppid = "&units=metric&APPID=93ed6d9a1885eeb796fe06b73dea3866"
        return query + capital + unitsAndAppid
    }
}

class WeatherManager {
    
    private var model: Weather?
    
    private let networkManager = RequestService<WeatherJSON>() // Refactoring
    private let url: URL?
    private let capital: String
    
    init(country: Country) {
        self.capital = country.capital
        self.url = URL(string: WeatherConstant.link(country.capital))
        self.fillModel()
    }
    
    // Public???
    public func fillModel() {
        if let url = self.url {
            self.networkManager.loadData(url: url) { data, error in
                data.do {
                    self.model = Weather(weatherJSON: $0)
                }
            }
        }
    }
}
