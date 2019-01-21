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
    
    private var model = CountriesData()
    
    private let manager  = Manager<[Country]>()
    
    private  let networkManager = NetworkManager<[Country]>()
    private  let url = URL(string: Constant.countriesLink)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rootView = self.rootView
        
        rootView?.countriesTableView.register(CountryTableViewCell.self)
        rootView?.countriesTableView.delegate = self
        rootView?.countriesTableView.dataSource = self
        self.navigationController?.delegate = self
        
        self.navigationItem.title = Constant.capital
        self.navigationController?.navigationBar.prefersLargeTitles = true
    
        self.fillModel()
    }
    
    private func fillModel() {
        if let url = self.url {
            self.manager.getData(from: url) { model, error in
                if let model = model {
                    self.model.values = model.filter { !$0.capital.isEmpty }
                        .map(CountryData.init)
                    DispatchQueue.main.async {
                        self.rootView?.countriesTableView.reloadData()
                    }
                } else {
                    print(error.debugDescription)
                }
            }
        }
    }
}

extension CountriesViewController {
    
    func navigationController(_ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        let controller: CountriesViewController? = cast(viewController)
        let indexPath = controller?.rootView?.countriesTableView.indexPathForSelectedRow
        indexPath.do {
            controller?.rootView?.countriesTableView.reloadRow(at: $0, with: .bottom)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let capital = self.model.values[indexPath.row]
        let weatherViewController = WeatherViewController(data: capital)
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cast(self.rootView?
            .countriesTableView?
            .dequeueReusableCell(withCellClass: CountryTableViewCell.self)
        ) ?? CountryTableViewCell()
        
        let item = self.model.values[indexPath.row]
        cell.fill(with : item)
        
        return cell
    }
}
