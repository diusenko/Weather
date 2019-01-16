//
//  URLSession+Extension.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/16/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

extension URLSession {
    
    func resumeSession(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }.resume()
    }
}
