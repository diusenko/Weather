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
    
    public var countryModel: Country? {
        didSet {
            self.prepeareObserver()
            self.fill()
        }
    }
    
    public var completion: F.VoidCompletion?
    
    public let cancelableProperty = CancellableProperty()
    
//    public func fill(with country: Country) {
//
//        self.country?.text = country.name
//        self.capital?.text = country.capital
//
//        self.cancelableProperty.value = country.weather.observer { weather in
//            print("asdasd")
//            dispatchOnMain {
//                self.temperature?.text = weather.map {
//                    $0.temperature.description + Constant.celsius
//                }
//                self.date?.text = weather?.date.shortDescription
//            }
//        }
//
////        self.country?.text = country.name
////        self.capital?.text = country.capital
////        self.temperature?.text = country.weather.value.map {
////            $0.temperature.description + Constant.celsius
////        }
////        self.date?.text = country.weather.value?.date.shortDescription
//    }
    
    private func prepeareObserver() {
        self.cancelableProperty.value = self.countryModel?.weather.observer { weather in
            print("dich")
            dispatchOnMain {
                self.setTemperatureAndDate()
            }
            self.completion?()
            
            self.cancelableProperty.value?.cancel() // LEGOFSKELET
        }
    }
    
    private func setTemperatureAndDate() {
        let weather = self.countryModel?.weather.value
        
        self.temperature?.text = weather.map {
            $0.temperature.description + Constant.celsius
        }
        
        self.date?.text = weather?.date.shortDescription
    }
    
    private func fill() {
        let countryModel = self.countryModel

        self.country?.text = countryModel?.name
        self.capital?.text = countryModel?.capital
        self.setTemperatureAndDate()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.cancelableProperty.value?.cancel()
    }
}
