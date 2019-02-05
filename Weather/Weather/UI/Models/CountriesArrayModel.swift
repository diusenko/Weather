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
        case didUpdate(Country, Int)
        case didAppend
        case didRemove(Country)
    }
    
    public private(set) var values: [Country]

    public init(values: [Country] = []) {
        self.values = values
        super.init()
    }
    
    subscript(_ index: Int) -> Wrapper<Country> {
        let wrapper = Wrapper(self.values[index])
        wrapper.observer {
            self.notify(handler: .didUpdate($0, index))
        }
        
        return wrapper
    }
    
    func append(_ country: Country) {
        self.values.append(country)
        self.notify(handler: .didAppend)
    }
    
    func append(_ countries: [Country]) {
        self.values.append(contentsOf: countries)
        self.notify(handler: .didAppend) // FIXIT
    }
    
    func remove(at index: Int) {
        let country = self.values.remove(at: index)
        self.notify(handler: .didRemove(country))
    }
}
