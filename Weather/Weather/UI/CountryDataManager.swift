//
//  CountryData.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/28/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class CountryDataManager {
    
    let countryManager = CountryManager()
    
    public var model = [CountryData]()
    
    public init() {
        //FIX IT
        _ = self.countryManager.observer {
            switch $0 {
            case .willLoad:
                return
            case .didLoad:
                self.countryManager.model.do {
                    self.model = $0.map(CountryData.init)
                }
            case .faild(let error):
                print(error ?? "")
            }
        }
    }
    
//    public func addWeather(country: Country) {
//        let countryData = self.model.first {
//            $0.country.capital == country.capital
//        }
//
//        let weatherManager = WeatherManager(country: country)
//        //FIX IT
//        _ = weatherManager.observer {
//            switch $0 {
//            case .willLoad:
//                return
//            case .didLoad:
//                countryData?.weather = weatherManager.model
//            case .faild(let error):
//                print(error ?? "")
//            }
//        }
//
//    }
}
