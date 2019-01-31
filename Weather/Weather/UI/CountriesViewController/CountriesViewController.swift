//
//  CountriesViewController.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/10/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    private var model = CountriesDataModel() {
        didSet {
            dispatchOnMain(self.rootView?.countriesTableView?.reloadData)
        }
    }
    
    private var selectedIndexPath: IndexPath?
    
    private let countryManager = CountryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = self.rootView?.countriesTableView
        tableView?.register(CountryTableViewCell.self)
   
        self.title = Constant.capital
        
        let navigationController = self.navigationController
        navigationController?.title = Constant.capital
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.setupModel()
    }
    
    private func setupModel() {
        self.countryManager.fillModel { countries in
            countries.do { countries in
                let data = countries.map(CountryWithWeather.init)
                
                data.forEach {
                    $0.observer { _ in
                        dispatchOnMain {
                            self.selectedIndexPath.do {
                                self.rootView?.countriesTableView?.reloadRow(at: $0, with: .automatic)
                            }
                        }
                    }
                }
                
                self.model = CountriesDataModel(values: data)
            }
        }
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        let countryData = self.model.values[indexPath.row]
        let weatherViewController = WeatherViewController(data: countryData)
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.model.values[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withCellClass: CountryTableViewCell.self, for: indexPath) {
            $0.fill(with: item)
        } 
        
        return cell
    }
}
