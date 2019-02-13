//
//  URLSession+Default.swift
//  Weather
//
//  Created by Usenko Dmitry on 2/12/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

extension URLSession {
    
    public class var `default`: URLSession {
        return URLSession(configuration: .default)
    }
}
