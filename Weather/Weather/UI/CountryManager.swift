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
    
    private let requestService = RequestService<[CountryJSON]>()
    private let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
    public func fillModel(completion: @escaping F.Completion<[Country]?>) {
        if let url = self.url {
            self.requestService.loadData(url: url) { data, error in
                if let data = data {
                    self.model = data
                        .map(Country.init)
                        .filter { $0.capital != "" }
                }
                completion(self.model)
            }
        }
    }
}
