//
//  CountriesViewController.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/10/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, RootViewRepresentable, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    typealias RootView = CountriesView
    
    var model = [Country]()
    
    var countries = Countries()
    
    let networkManager = NetworkManager<[Country]>()
    let url = URL(string: Strings.countriesLink)
    
    init() {
        super.init(nibName: nil, bundle:nil)
        self.getData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rootView = self.rootView
        
        rootView?.countriesTableView.register(CountryTableViewCell.self)
        rootView?.countriesTableView.delegate = self
        rootView?.countriesTableView.dataSource = self
        self.navigationController?.delegate = self
        
        self.navigationItem.title = Strings.capital
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getData() {
        if let url = self.url {
            self.networkManager.loadData(url: url)
            _ = self.networkManager.observer {
                switch($0) {
                case .didStartLoading:
                    return
                case .didLoad:
                    //force !!!!!!
                    self.model = self.networkManager.model!.filter { !$0.capital.isEmpty }
                    
                    self.model.forEach {
                        self.countries.values.append(CountryWithWeather(country: $0))
                    }
                case .didFailedWithError(let error):
                    print(error?.localizedDescription ?? "")
                }
            }
        }
    }
}

extension CountriesViewController {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let controller = viewController as? CountriesViewController
        let indexPath = controller?.rootView?.countriesTableView.indexPathForSelectedRow
        indexPath.do {
            controller?.rootView?.countriesTableView.reloadRows(at: [$0], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let capital = self.model[indexPath.row].capital
        let weatherViewController = WeatherViewController(capital: capital, countries: self.countries)
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
        
        let item = self.countries.values[indexPath.row]
        cell.fill(with : item)
        
        return cell
    }
}
