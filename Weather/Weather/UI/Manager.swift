//
//  Manager.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/21/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class Manager<Model> where Model: Decodable {
    
    private var objects = [NetworkManager<Model>.Observer]()
    
    private let networkManager = NetworkManager<Model>()
    
    public func getData(from url: URL, with action: @escaping (Model?, Error?) -> ()) {
        self.networkManager.loadData(url: url)
        
        let observer = self.networkManager.observer {
            switch($0) {
            case .didStartLoading: return
            case .didLoad:
                action(self.networkManager.model, nil)
            case .didFailedWithError(let error):
                action(nil, error)
            }
        }
        
        self.objects.append(observer)
    }
}
