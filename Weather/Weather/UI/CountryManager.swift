//
//  CountryManager.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/24/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class CountryManager {

    private var model: [Country]?
    
    private let networkManager = RequestService<[CountryJSON]>() // Refactoring
    private let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
    init() {
        self.fillModel()
    }
    
    // Public????
    public func fillModel() {
        if let url = self.url {
            self.networkManager.loadData(url: url) { data, error in
                data.do {
                    self.model = $0.map(Country.init)
                }
            }
        }
    }
}

