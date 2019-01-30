//
//  Manager.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/16/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public class CountryData: ObservableObject<CountryData.Event> {
    
    public enum Event {
        case weatherChanged(Weather?)
        case countryChanged(Country)
    }
    
    public var country: Country {
        get { return self.wrapperCountry.value }
        set {
            self.wrapperCountry.value = newValue
        }
    }
    
    public var weather: Weather? {
        get { return self.wrapperWeather.value }
        set {
            self.wrapperWeather.value = newValue
        }
    }
    
    private var wrapperCountry: Wrapper<Country>
    private var wrapperWeather: Wrapper<Weather?>
    
    public init(country: Country, weather: Weather?) {
        self.wrapperCountry = Wrapper(country)
        self.wrapperWeather = Wrapper(weather)
        super.init()
        self.subscribe()
    }
    
    public convenience init(country: Country) {
        self.init(country: country, weather: nil)
    }
    
    private func subscribe() {
        self.wrapperCountry.observer { country in
            self.notify(handler: .countryChanged(country))
        }
        
        self.wrapperWeather.observer { weather in
            self.notify(handler: .weatherChanged(weather))
        }
    }
}
