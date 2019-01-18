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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func fill(with data: CountryWithWeather) {
        self.temperature?.text = data.weather?.main.temperature.description
        self.capital?.text = data.country.capital.description
    }
}
