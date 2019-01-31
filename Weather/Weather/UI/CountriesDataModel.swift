//
//  CountryData.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/28/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class CountriesDataModel: ObservableObject<CountryWithWeather.Event> {

    public var values: [CountryWithWeather]

    public init(values: [CountryWithWeather] = []) {
        self.values = values
        super.init()
        self.subscribe()
    }
    
    private func subscribe() {
        self.values.forEach { [weak self] model in
            (self?.notify).do {
                model.observer(handler: $0)
            }
        }
    }
}
