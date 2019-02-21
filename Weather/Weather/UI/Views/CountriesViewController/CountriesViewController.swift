//
//  CountriesViewController.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/10/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

class CountriesViewController<DataBaseProviderType: DataBaseProvider>: UIViewController, RootViewRepresentable
    where DataBaseProviderType.Model == Country
{
    
    typealias RootView = CountriesView
    
    private let model: CountriesArrayModel
    
    private let networkService: CountryNetworkService<DataBaseProviderType>
    
    private let observableCountries = CancellableProperty()
    
    private let task = CancellableProperty()
    
    init(model: CountriesArrayModel = .init(), networkService: CountryNetworkService<DataBaseProviderType>) {
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

