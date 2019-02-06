//
//  WeatherNetworkService.swift
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

class WeatherNetworkService {
    
    private let requestService: RequestService
    
    public init(requestService: RequestService = .init()) {
        self.requestService = requestService
    }
    
    public func fillModel(country: ObservableWrapper<Country>) {
        if let url = self.url(with: country.value.capital) {
            self.requestService.loadData(url: url) { data, error in
                data.flatMap { try? JSONDecoder().decode(WeatherJSON.self, from: $0) }
                    .do { data in country.modify { $0.weather = weather(data) } }
            }
        }
    }
    
    private func url(with capitalName: String) -> URL? {
        return capitalName
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .map(WeatherConstant.link)
            .flatMap(URL.init)
    }
}

fileprivate let weather: (WeatherJSON) -> Weather = { json in
    let main = json.main
    return Weather(
        temperature: Int(main.temperature),
        date: Date(timeIntervalSince1970: json.dt),
        minTemperature: Int(main.temperatureMin),
        maxTemperature: Int(main.temperatureMax)
    )
}
