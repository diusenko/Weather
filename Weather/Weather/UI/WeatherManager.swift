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

class WeatherManager: ObservableObject<Event> {
    
    public private(set) var model: Weather?
    
    private let networkManager = RequestService<WeatherJSON>() // Refactoring
    private let url: URL?
    private let capital: String
    
    public init(country: Country) {
        self.capital = country.capital
        
        self.url = WeatherConstant
            .link(country.capital)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .flatMap(URL.init)

        super.init()
        self.fillModel()
    }
    
    // Public???
    private func fillModel() {
        if let url = self.url {
            self.networkManager.loadData(url: url) { data, error in
                self.notify(handler: .willLoad)
                if let data = data {
                    self.model = Weather(weatherJSON: data)
                    self.notify(handler: .didLoad)
                } else {
                    self.notify(handler: .faild(error: error))
                }
            }
        }
    }
}
