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
    
    private var capital: String
    
    let networkManager = NetworkManager<Weather>()
    
    init(capital: String) {
        self.capital = capital
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Strings.initError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rootView = self.rootView
        
        self.navigationItem.title = Strings.weather
        
        let weatherLink = Strings.weatherLink(self.capital)
        let weatherLinkForUrl = weatherLink.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        weatherLinkForUrl.do { weatherLink in
            URL(string: weatherLink).do { url in
                self.networkManager.loadData(url: url)
                _ = self.networkManager.observer {
                    switch($0) {
                    case .didStartLoading:
                        return
                    case .didLoad:
                        DispatchQueue.main.async {
                            rootView?.capital?.text = self.capital
                            let temperature = self.networkManager.model?.main["temp"]
                            temperature.do {
                                rootView?.temperature?.text = Int($0).description + Strings.celsius
                            }
                        }
                    case .didFailedWithError(let error):
                        print(error?.localizedDescription ?? "")
                    }
                }
            }
        }
    }
}
