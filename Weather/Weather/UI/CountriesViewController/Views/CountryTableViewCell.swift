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
    
    public func fill(with capital: Country) {
        
        self.country?.text = capital.name
        self.capital?.text = capital.capital
        self.temperature?.text = capital.weather.map {
            $0.temperature.description + Constant.celsius
        }
        self.date?.text = capital.weather?.date.shortDescription
    }
}
