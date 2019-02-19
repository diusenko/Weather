//
//  CountryJSON.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/10/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation
    
public struct CountryJSON: Decodable {
    
    public let name: String
    public let capital: String
    public let alpha2Code: String
}
