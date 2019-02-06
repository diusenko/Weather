//
//  CountriesArrayModel.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/28/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class CountriesArrayModel: ObservableObject<CountriesArrayModel.Event> {

    public enum Event {
        case didAppend
        case didRemove(Country)
    }
    
    public private(set) var values: [Country]

    public init(values: [Country] = []) {
        self.values = values
        super.init()
    }
    
    subscript(_ index: Int) -> ObservableWrapper<Country> {
        return ObservableWrapper(self.values[index])
    }
    
    func append(_ country: Country) {
        self.values.append(country)
        self.notify(handler: .didAppend)
    }
    
    func append(_ countries: [Country]) {
        self.values.append(contentsOf: countries)
        self.notify(handler: .didAppend)
    }
    
    func remove(at index: Int) {
        let country = self.values.remove(at: index)
        self.notify(handler: .didRemove(country))
    }
}
