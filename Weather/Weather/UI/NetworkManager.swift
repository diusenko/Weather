//
//  NetworkManager.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class NetworkManager<ModelType>: ObservableObject<NetworkManager.State> where ModelType: Decodable {
    
    public enum State {
        case notLoaded
        case didStartLoading
        case didLoad
        case didFailedWithError(_ error: Error?)
    }
    
    var model: ModelType?
    
    private(set) var state: State = .notLoaded {
        didSet {
            self.notify(handler: self.state)
        }
    }
    
    func loadData(url: URL) {
        self.state = .didStartLoading
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do { let values = try JSONDecoder().decode(ModelType.self, from: data)
                    self.model = values
                    self.state = .didLoad
                } catch {
                    self.state = .didFailedWithError(error)
                }
            }
        }.resume()
    }
}
