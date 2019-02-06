//
//  CountryNetworkService.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/24/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class CountryNetworkService {
    private let requestService: RequestService<[CountryJSON]>
    private let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
    init(requestService: RequestService<[CountryJSON]> = RequestService<[CountryJSON]>()) {
        self.requestService = requestService
    }
    
    public func fillModel(countries: CountriesArrayModel) {
        if let url = self.url {
            self.requestService.loadData(url: url) { data, error in
                if let data = data {
                    let countriesFromData = data
                        .map {
                            Country.init(name: $0.name, capitalName: $0.capital)
                        }
                        .filter { $0.capital != "" }
                    countries.append(countriesFromData)
                }
            }
        }
    }
}
