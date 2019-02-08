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
    
//    var countryModel: Country? {
//        didSet {
//            self.fill()
//        }
//    }
    
    private var cancelableProperty = CancellableProperty()
    
    public func fill(with country: Country) {
        
        self.country?.text = country.name
        self.capital?.text = country.capital

        self.cancelableProperty.value = country.observer { weather in
            dispatchOnMain {
                self.temperature?.text = weather.map {
                    $0.temperature.description + Constant.celsius
                }
                self.date?.text = weather?.date.shortDescription
            }
        }
        
//        self.country?.text = country.name
//        self.capital?.text = country.capital
//        self.temperature?.text = country.weather.map {
//            $0.temperature.description + Constant.celsius
//        }
//        self.date?.text = country.weather?.date.shortDescription
    }
    
//    public func fill() {
//        let countryModel = self.countryModel
//
//        self.country?.text = countryModel?.name
//        self.capital?.text = countryModel?.capital
//
//        self.cancelableProperty.value = countryModel?.observer { weather in
//            print("hey")
//            dispatchOnMain {
//                self.temperature?.text = weather.map {
//                    $0.temperature.description + Constant.celsius
//                }
//                self.date?.text = weather?.date.shortDescription
//            }
//        }
//    }
}
