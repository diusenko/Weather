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
    
    private var model: CountryData
    private var weatherManager: WeatherManager
    
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
        
        let weatherManager = self.weatherManager
        //FIX IT
        _ = weatherManager.observer {
            switch $0 {
            case .willLoad:
                return
            case .didLoad:
                self.model.weather = weatherManager.model
                self.model.date = Date()
                DispatchQueue.main.async {
                    self.rootView?.fill(with: self.model)
                }
            case .faild(let error):
                print(error ?? "")
            }
        }
    }
}
