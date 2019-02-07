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
    
//    private var countryModel: ObservableWrapper<Country>?
    
    public func fill(with country: Country) {
        
//        self.countryModel?.observer { country in
//            print("hey")
//            self.country?.text = country.name
//            self.capital?.text = country.capital
//            self.temperature?.text = country.weather.map {
//                $0.temperature.description + Constant.celsius
//            }
//            self.date?.text = country.weather?.date.shortDescription
//        }
//
//        self.countryModel?.modify {
//            $0 = country
//        }
        
        self.country?.text = country.name
        self.capital?.text = country.capital
        self.temperature?.text = country.weather.map {
            $0.temperature.description + Constant.celsius
        }
        self.date?.text = country.weather?.date.shortDescription
    }
}
