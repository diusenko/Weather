//
//  CountryNetworkService.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/24/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation
import RealmSwift

class CountryNetworkService<Type: DataBaseProvider>
    where Type.Model == Country
{
    
    private let requestService: RequestServiceType
    private let url = URL(string: "https://restcountries.eu/rest/v2/all")
    private let dataBaseService: DataBaseService<Type>
    
    init(
        requestService: RequestServiceType = RequestService(session: .default),
        dataBaseService: DataBaseService<Type>
    ) {
        self.requestService = requestService
        self.dataBaseService = dataBaseService
    }
    
    public func fillModel(model: CountriesArrayModel) -> NetworkTask {
        
        guard let url = self.url else {
            let task = NetworkTask(sessionTask: nil)

            defer {
                task.cancel()
            }
            
            return task
        }
            
        return self.requestService.scheduledRequest(url: url) { result in
            result.analysis(
                success: { data in
                    let decoder = try? JSONDecoder().decode([CountryJSON].self, from: data)
                    // FIXME: 111
                    decoder.do {
                        model.append(countries($0))
                        model.values.forEach {
                            self.dataBaseService.value.write(model: $0)
                        }
                    }
                    let read = self.dataBaseService.value.read()
                    read.do { countries in
                        model.append(countries)
                    }
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
    Country(id: "", name: $0.name, capital: $0.capital)
}
