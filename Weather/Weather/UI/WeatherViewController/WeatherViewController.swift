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
    private var countries: Countries
    
    
    let networkManager = NetworkManager<Weather>()
    
    init(capital: String, countries: Countries) {
        self.capital = capital
        self.countries = countries
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Strings.initError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Strings.weather
        self.getData()
    }
    
    func getData() {
        let rootView = self.rootView
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
                        let country = self.countries.values.first(where: { $0.country.capital == self.capital} )
                        country.do { country in
                            country.date = Date()
                            country.weather =  self.networkManager.model
                            DispatchQueue.main.async {
                                rootView?.fill(with: country)
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
