//
//  WeatherViewController.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, RootViewRepresentable {
    
    typealias RootView = WeatherView
    
    private let model: CountryData
    private let weatherManager: WeatherManager
    
    init(data: CountryData) {
        self.model = data
        self.weatherManager = .init(country: data.country)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constant.weather
        
        let model = self.model
        self.weatherManager.fillModel {
            $0.do {
                model.weather = $0
                dispatchOnMain {
                    self.rootView?.fill(with: model)
                }
            }
        }
    }
}
