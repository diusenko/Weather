//
//  RequestService.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

struct RequestService {
    
    public func loadData(url: URL, completion: @escaping (Data?, Error?) -> ()) {
        URLSession.shared.resumeSession(with: url) { (data, response, error) in
            completion(data, error)
        }
    }
}
