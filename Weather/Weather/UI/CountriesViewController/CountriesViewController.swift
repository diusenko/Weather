//
//  CountriesViewController.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/10/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, RootViewRepresentable, UITableViewDataSource, UITableViewDelegate {
    
    typealias RootView = CountriesView
    
    var model = [Country]()
    
    let networkManager = NetworkManager<[Country]>()
    let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.rootView?.countriesTableView.register(CountryTableViewCell.self)
        
        self.rootView?.countriesTableView.delegate = self
        self.rootView?.countriesTableView.dataSource = self
        
        if let url = self.url {
           self.networkManager.loadData(url: url)
            self.networkManager.observer {
                switch($0) {
                case .notLoaded:
                    return
                case .didStartLoading:
                    return
                case .didLoad:
                    self.model = self.networkManager.model!.filter { !$0.capital.isEmpty }
                    DispatchQueue.main.async {
                        self.rootView?.countriesTableView?.reloadData()
                    }
                case .didFailedWithError(let error):
                    print(error)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let capital = self.model[indexPath.row].capital
        let weatherViewController = WeatherViewController(capital: capital)
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cast(self.rootView?
            .countriesTableView?
            .dequeueReusableCell(withCellClass: CountryTableViewCell.self)
        ) ?? CountryTableViewCell()
        
        let item = self.model[indexPath.row]
        cell.fill(country: item)
        
        return cell
    }
}
