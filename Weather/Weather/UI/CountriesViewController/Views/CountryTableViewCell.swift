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
    
    public func fill(with data: CountryData) {
        let country = data.country
        
        self.country?.text = country.name
        self.capital?.text = country.capital
        data.weather.do {
           self.temperature?.text = $0.temperature.description + Constant.celsius
        }
        self.date?.text = data.weather?.date.shortDescription
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.temperature?.text = ""
    }
}
