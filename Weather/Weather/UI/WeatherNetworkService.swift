//
//  WeatherNetworkService.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/24/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation
import RealmSwift

fileprivate struct WeatherConstant {
    
    static let link: (String) -> String = { capital in
        let query = "https://api.openweathermap.org/data/2.5/weather?q="
        let unitsWithAppid = "&units=metric&APPID=93ed6d9a1885eeb796fe06b73dea3866"
        return query + capital + unitsWithAppid
    }
}

class WeatherNetworkService<Type: DataBaseProvider>
where Type.Model == Weather {
    
    private let requestService: RequestServiceType
    private let dataBaseService: DataBaseService<Type>
    private let cancelableProperty = CancellableProperty()
    
    public init(
        requestService: RequestServiceType = RequestService(session: .default),
        dataBaseService: DataBaseService<Type>
    ) {
        self.requestService = requestService
        self.dataBaseService = dataBaseService
    }
    
    // Duplicate
    public func fillModel(country: Country) -> NetworkTask {
        
        guard let url = self.url(with: country.capital) else {
            let task = NetworkTask(sessionTask: .init())
            
            defer {
                task.cancel()
            }
            
            return task
        }
        
        let task = self.requestService.scheduledRequest(url: url) { result in
            result
                .analysis(
                    success: {
                        let decode = try? JSONDecoder().decode(WeatherJSON.self, from: $0)
                        decode.do { data in
                            
                            let weatherData = weather(data)
                            
                            country.weather.modify {
                                $0 = weatherData
                            }
                            
                            self.dataBaseService.value.write(model: weatherData)
                        }
                    },
                    failure: {_ in }
            )
            
        }
        self.cancelableProperty.value = task
        return task
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
        id: "",
        temperature: Int(main.temperature),
        date: Date(timeIntervalSince1970: json.dt)
    )
}
