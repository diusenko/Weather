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
    
    private let cancelable = CancellableProperty()
    
    init(model: CountriesArrayModel = CountriesArrayModel(), networkService: CountryNetworkService = CountryNetworkService()) {
        self.networkService = networkService
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        self.cancelable.value = self.model.observer {
            switch $0 {
            case .didUpdate(_, _): self.updateTableView() // FixIt
            case .didAppend: self.updateTableView()
            case .didRemove(_): self.updateTableView()
            }
        }
        
        self.networkService.fillModel(countries: self.model)
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
        
        countryData.observer { _ in
            dispatchOnMain {
                tableView.reloadRow(at: indexPath, with: .automatic)
            }
        }
        
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
