//
//  CountryNetworkService.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/24/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class CountryNetworkService {
    private let requestService: RequestService
    private let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
    init(requestService: RequestService = .init()) {
        self.requestService = requestService
    }
    
    public func fillModel(model: CountriesArrayModel) {
        if let url = self.url {
            self.requestService.loadData(url: url) { data, error in
                data.flatMap { try? JSONDecoder().decode([CountryJSON].self, from: $0) }
                    .do { model.append(countries($0)) }
            }
        }
    }
}

fileprivate let countries: ([CountryJSON]) -> [Country] = { json in
    json
        .filter { $0.capital != "" }
        .map(country)
}

fileprivate let country: (CountryJSON) -> Country = {
    Country(name: $0.name, capitalName: $0.capital)
}
