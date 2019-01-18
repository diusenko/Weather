//
//  Manager.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/16/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

//class Manager<Model> where Model: Decodable {
//
//    private var observableObjects = [ObservableObject<NetworkManager<Model>>]()
//
//    private let networkManager = NetworkManager<Model>()
//
//    private var model: Model?
//
//    func getData(url: URL, completion: @escaping (Model?) -> ()) {
//        self.networkManager.loadData(url: url)
//        self.networkManager.observer {
//            switch($0) {
//            case .didStartLoading: return
//            case .didLoad:
//                 completion(self.networkManager.model)
//            case .didFailedWithError(let error):
//                print(error?.localizedDescription ?? "")
//            }
//        }
//    }
//}

class CountryWithWeather {
    
    var country: Country
    var weather: Weather?
    var date: Date?
    
    init(country: Country) {
        self.country = country
        self.weather = nil
    }
}

class Countries {
    var values: [CountryWithWeather] = []
}
