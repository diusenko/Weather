//
//  RequestService.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

enum RequestServiceError: Error {
    case unknown
    case failed(Error)
}

protocol RequestServiceType {
    
    func scheduledData(url: URL, completion: @escaping (Result<Data, RequestServiceError>) -> ()) -> NetworkTask
}

class RequestService: RequestServiceType {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    public func scheduledData(url: URL, completion: @escaping (Result<Data, RequestServiceError>) -> ()) -> NetworkTask {
        let task = self.session.dataTask(with: url) { (data, response, error) in
            completion(
                Result(
                    value: data,
                    error: error.map { .failed($0) },
                    default: .unknown
                )
            )
        }
        
        let networkTask = NetworkTask(sessionTask: task)
        task.resume()
        
        return networkTask
    }
}
