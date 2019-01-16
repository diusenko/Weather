//
//  NetworkManager.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class NetworkManager<Model>: ObservableObject<NetworkManager.State> where Model: Decodable {
    
    public enum State {
        case notLoaded
        case didStartLoading
        case didLoad
        case didFailedWithError(_ error: Error?)
    }
    
    var model: Model?
    
    private(set) var state: State = .notLoaded {
        didSet {
            self.notify(handler: self.state)
        }
    }
    
    func loadData(url: URL) {
        self.state = .didStartLoading
        
        URLSession.shared.resumeSession(with: url) { (data, response, error) in
            if let data = data {
                do { let values = try JSONDecoder().decode(Model.self, from: data)
                    self.model = values
                    self.state = .didLoad
                } catch {
                    self.state = .didFailedWithError(error)
                }
            }
        }
    }
}
