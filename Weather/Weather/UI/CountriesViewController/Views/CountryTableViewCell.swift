//
//  CountryTableViewCell.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/15/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

class CountryTableViewCell: TableViewCell {

    @IBOutlet var country: UILabel?
    @IBOutlet var capital: UILabel?
    @IBOutlet var temperature: UILabel?
    @IBOutlet var date: UILabel?
    
    func fill(with data: CountryWithWeather) {
        self.country?.text = data.country.name
        self.capital?.text = data.country.capital
        self.temperature?.text = data.weather?.main.temperature.description ?? ""
        self.date?.text = data.date?.shortDescription ?? ""
    }
}
