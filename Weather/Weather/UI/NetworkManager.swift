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
        case didStartLoading
        case didLoad
        case didFailedWithError(_ error: Error?)
    }
    
    var model: Model?
    
    func loadData(url: URL) {
        let notify = self.notify
        notify(.didStartLoading)
        
        URLSession.shared.resumeSession(with: url) { (data, response, error) in
            
            guard error == nil else { return }
            
            if let data = data {
                do { let values = try JSONDecoder().decode(Model.self, from: data)
                    self.model = values
                    notify(.didLoad)
                } catch {
                    notify(.didFailedWithError(error))
                }
            }
        }
    }
}
