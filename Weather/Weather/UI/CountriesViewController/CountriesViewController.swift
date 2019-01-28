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
    
    private let manager = CountryDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.countriesTableView?.register(CountryTableViewCell.self)
   
        self.title = Constant.capital
        
        let navigationController = self.navigationController
        navigationController?.delegate = self
        navigationController?.title = Constant.capital
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        let controller: CountriesViewController? = cast(viewController)
        let tableView = controller?.rootView?.countriesTableView
        let indexPath = tableView?.indexPathForSelectedRow
        indexPath.do {
            tableView?.reloadRow(at: $0, with: .bottom)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryData = self.manager.model[indexPath.row]
        let weatherViewController = WeatherViewController(data: countryData)
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.manager.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.manager.model[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withCellClass: CountryTableViewCell.self, for: indexPath) {
            $0.fill(with: item)
        } 
        
        return cell
    }
}
