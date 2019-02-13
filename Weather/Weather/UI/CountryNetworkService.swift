//
//  CountryNetworkService.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/24/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

class CountryNetworkService {
    
    private let requestService: RequestServiceType
    private let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
    init(requestService: RequestServiceType = RequestService(session: .default)) {
        self.requestService = requestService
    }
    
//    func scheduledData(url: URL, completion: @escaping (Result<Data, RequestServiceError>) -> ()) -> NetworkTask {
//        print("")
//    }
    
    public func fillModel(model: CountriesArrayModel) -> NetworkTask {
        
        guard let url = self.url else {
            let task = NetworkTask(sessionTask: .init())

            defer {
                task.cancel()
            }
            
            return task
        }
            
        return self.requestService.scheduledData(url: url) { result in
            result.analysis(
                success: { data in
                    let decoder = try? JSONDecoder().decode([CountryJSON].self, from: data)
                    decoder.do { model.append(countries($0)) }
            },
                failure: { print($0) }
            )
        }
    }
}

fileprivate let countries: ([CountryJSON]) -> [Country] = { json in
    json
        .filter { $0.capital != "" }
        .map(country)
}

fileprivate let country: (CountryJSON) -> Country = {
    Country(name: $0.name, capitalName: $0.capital)
}
