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

    private let weatherManager = Manager<WeatherJSON>()
    
    init(data: CountryData) {
        self.model = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constant.weather
        self.fillModel()
    }
    
    private func fillModel() {
        let weatherLink = Constant.weatherLink(self.model.country.capital)
        
        weatherLink
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .flatMap(URL.init)
            .do { url in
                self.weatherManager.getData(from: url) { model, error in
                    if let modelFromManager = model {
                        let model = self.model
                        model.date = Date()
                        model.weather = modelFromManager
                        DispatchQueue.main.async {
                            self.rootView?.fill(with: model)
                        }
                    } else {
                        print(error.debugDescription)
                    }
                }
            }
    }
}
