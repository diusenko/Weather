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
//    func getData(url: URL, executeWhenDidLoad: F.VoidExecute) {
//        self.networkManager.loadData(url: url)
//        let networkManager = self.networkManager.observer {
//            switch($0) {
//            case .notLoaded:
//                return
//            case .didStartLoading:
//                return
//            case .didLoad:
//                self.model = self.networkManager.model!.filter { !$0.capital.isEmpty }
//                DispatchQueue.main.async {
//                    rootView?.countriesTableView?.reloadData()
//                }
//            case .didFailedWithError(let error):
//                print(error?.localizedDescription ?? "")
//            }
//        }
//        self.observableObjects.append(networkManager)
//    }
//}
