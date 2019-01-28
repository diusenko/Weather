//
//  CountryManager.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/24/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

enum Event {
    case willLoad
    case didLoad
    case faild(error: Error?)
}

class CountryManager: ObservableObject<Event> {
    
    private(set) var model: [Country]?
    
    private let requestService = RequestService<[CountryJSON]>()
    private let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
    public override init() {
        super.init()
        self.fillModel()
    }
    
    // Public????
    private func fillModel() {
        if let url = self.url {
            self.requestService.loadData(url: url) { data, error in
                self.notify(handler: .willLoad)
                if let data = data {
                    self.model = data
                        .map(Country.init)
                        .filter { $0.capital != "" }
                    self.notify(handler: .didLoad)
                } else {
                    self.notify(handler: .faild(error: error))
                }
            }
        }
    }
}

