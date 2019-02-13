//
//  WeatherView.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    @IBOutlet var temperature: UILabel?
    @IBOutlet var capital: UILabel?
    
    public func fill(with data: Country) {
        self.temperature?.text = data.weather.value.map {
            $0.temperature.description + UnitTemperature.celsius.symbol
        }
        
        self.capital?.text = data.capital.description
    }
}
