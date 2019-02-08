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
    
    private let country: Country
    private let weatherManager: WeatherNetworkService
    
    init(country: Country, manager: WeatherNetworkService = .init()) {
        self.country = country
        self.weatherManager = manager
        
        super.init(nibName: nil, bundle: nil)
        
        country.observer { _ in
            dispatchOnMain {
                self.rootView?.fill(with: country)
            }
        }
        
        manager.fillModel(country: country)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let country = self.country
        
        self.navigationItem.title = country.name
        
        self.rootView?.fill(with: country)
    }
}
