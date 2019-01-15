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
    
    var capital: String
    var temperature: Double?
    
    let networkManager = NetworkManager<Weather>()
    
    init(capital: String) {
        self.capital = capital
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.capital)
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=" +
            self.capital + "&units=metric&APPID=93ed6d9a1885eeb796fe06b73dea3866"
        
        let test = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: test!)
        
        if let url = url {
            self.networkManager.loadData(url: url)
            self.networkManager.observer {
                switch($0) {
                case .notLoaded:
                    return
                case .didStartLoading:
                    return
                case .didLoad:
                    // If Let
                    DispatchQueue.main.async {
                        self.rootView?.capital?.text = self.capital
                        let temperature = self.networkManager.model?.main["temp"]
                        temperature.do {
                            self.rootView?.temperature?.text = String(Int($0)) + " °C"
                        }
                    }
                case .didFailedWithError(let error):
                    print(error)
                }
            }
        }
    }

}
