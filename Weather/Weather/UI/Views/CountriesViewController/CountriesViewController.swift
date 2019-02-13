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
    
    private let model: CountriesArrayModel
    
    private let networkService: CountryNetworkService
    
    private let observableCountries = CancellableProperty()
    
    private let task = CancellableProperty()
    
    init(model: CountriesArrayModel = .init(), networkService: CountryNetworkService = .init()) {
        self.networkService = networkService
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        self.observableCountries.value = self.model.observer {
            if case .didAppend = $0 {
                self.updateTableView()
            }
        }
        
        self.task.value = self.networkService.fillModel(model: self.model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.countriesTableView?.register(CountryTableViewCell.self)
   
        self.title = Constant.countries
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func updateTableView() {
        dispatchOnMain {
            self.rootView?.countriesTableView?.reloadData()
        }
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryData = self.model[indexPath.row]
        
        let weatherViewController = WeatherViewController(country: countryData)
        
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withCellClass: CountryTableViewCell.self, for: indexPath) {
            let country = self.model.values[indexPath.row]
            $0.completion = {
                dispatchOnMain {
                    tableView.reloadRow(at: indexPath, with: .automatic)
                }
            }
            
            $0.countryModel = country
            //$0.fill(with: model.values[indexPath.row])
        }
    }
}
