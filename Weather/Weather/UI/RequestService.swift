//
//  RequestService.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation
import Alamofire

enum RequestServiceError: Error {
    case unknown
    case failed(Error)
}

protocol RequestServiceType {
    
    func scheduledRequest(url: URL, completion: @escaping (Result<Data, RequestServiceError>) -> ()) -> NetworkTask
}

class RequestService: RequestServiceType {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    public func scheduledRequest(
        url: URL,
        completion: @escaping (Result<Data, RequestServiceError>) -> ()
    )
        -> NetworkTask
    {
        let request = Alamofire.request(url).response { response in
            completion(
                Result(
                    value: response.data,
                    error: response.error.map { .failed($0) },
                    default: .unknown
                )
            )
        }
        
        let task = request.task
        
        task?.resume()
        
        return NetworkTask(sessionTask: task)
    }
}
