//
//  Manager.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/21/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class Manager<Model> where Model: Decodable {
    
    private let networkManager = RequestService<Model>()
    
    public func getData(from url: URL, with action: @escaping (Model?, Error?) -> ()) {
        self.networkManager.loadData(url: url) { json, error in
            action(json, error)
        }
    }
}
