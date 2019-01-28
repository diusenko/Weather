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
    
    private var model = [CountryData]()
    
    private let manager  = Manager<[CountryJSON]>()
    
    private  let networkManager = RequestService<[CountryJSON]>()
    private  let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.countriesTableView?.register(CountryTableViewCell.self)
   
        self.title = Constant.capital
        
        let navigationController = self.navigationController
        navigationController?.delegate = self
        navigationController?.title = Constant.capital
        navigationController?.navigationBar.prefersLargeTitles = true
    
        self.fillModel()
    }
    
    private func fillModel() {
        if let url = self.url {
            self.manager.getData(from: url) { model, error in
                if let model = model {
                    self.model = model.filter { !$0.capital.isEmpty }
                        .map {
                            CountryData(country: Country(countryJSON: $0))
                        }
                    DispatchQueue.main.async {
                        self.rootView?.countriesTableView?.reloadData()
                    }
                } else {
                    print(error.debugDescription)
                }
            }
        }
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
        let capital = self.model[indexPath.row]
        let weatherViewController = WeatherViewController(data: capital)
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
        cell.fill(with : item)
        
        return cell
    }
}
