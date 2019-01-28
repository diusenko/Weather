//
//  Constant.swift
//  Square
//
//  Created by Usenko Dmitry on 1/9/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public struct Constant {
    
    static let weather = "Weather"
    static let capital = "Capital"
    static let celsius = UnitTemperature.celsius.symbol
    
    static let weatherLink: (String) -> String = { capital in
        let query = "https://api.openweathermap.org/data/2.5/weather?q="
        let unitsAndAppid = "&units=metric&APPID=93ed6d9a1885eeb796fe06b73dea3866"
        return query + capital + unitsAndAppid
    }
}
