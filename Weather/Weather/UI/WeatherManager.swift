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
    
    private let requestService: RequestService<WeatherJSON>
    
    public init(requestService: RequestService<WeatherJSON> = RequestService<WeatherJSON>()) {
        self.requestService = requestService
    }
    
    public func fillModel(country: Wrapper<Country>) {
        if let url = self.url(with: country.value.capital) {
            self.requestService.loadData(url: url) { data, error in
                if let data = data {
                    let main = data.main
                    let date = Date(timeIntervalSince1970: TimeInterval(data.dt))
                    
                    country.modify {
                        $0.weather = Weather(
                        temperature: Int(main.temperature),
                        date: date,
                        minTemperature: Int(main.temperatureMin),
                        maxTemperature: Int(main.temperatureMax)
                        )
                    }
                }
            }
        }
    }
    
    private func url(with countryName: String) -> URL? {
        return WeatherConstant
            .link(countryName)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .flatMap(URL.init)
    }
}
