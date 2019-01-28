//
//  RequestService.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

struct RequestService<Model> where Model: Decodable {
    
    public func loadData(url: URL, completion: @escaping (Model?, Error?) -> ()) {
        
        URLSession.shared.resumeSession(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                
                return
            }
            
            if let data = data {
                do {
                    let values = try JSONDecoder().decode(Model.self, from: data)
                    completion(values, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
    }
}
