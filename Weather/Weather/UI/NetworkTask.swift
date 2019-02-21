//
//  NetworkTask.swift
//  Weather
//
//  Created by Usenko Dmitry on 2/12/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class NetworkTask: Cancellable {
    
    public private(set) var isCancelled = false
    
    private let task: URLSessionTask
    
    public init(sessionTask: URLSessionTask) {
        self.task = sessionTask
    }
    
    func cancel() {
        self.task.cancel()
        self.isCancelled = true
    }
    
    public convenience init(sessionTask: URLSessionTask?) {
        if let sessionTask = sessionTask {
            self.init(sessionTask: sessionTask)
        } else {
            let sessionTask = URLSessionTask()
            self.init(sessionTask: sessionTask)
        }
    }
}
