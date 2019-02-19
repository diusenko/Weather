//
//  File.swift
//  Weather
//
//  Created by Usenko Dmitry on 2/18/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import RealmSwift

public class RLMModel: Object {
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id = ""
}

protocol DataBaseProvider {
    
    associatedtype Storage
    
    func read(id: String) -> Storage?
    func write(storage: Storage)
}

class DataBaseService<Provider: DataBaseProvider> {
    
    public let dataBaseProvider: Provider
    
    init(provider: Provider) {
        self.dataBaseProvider = provider
    }
}

class CountryRLM: DataBaseProvider {
    
    typealias Storage = RLMCountryJSON
    
    func read() -> Results<RLMCountryJSON>? {
        return Realm.current?.objects(RLMCountryJSON.self)
    }
    
    func read(id: String) -> RLMCountryJSON? {
        return Realm.current?.object(ofType: RLMCountryJSON.self, forPrimaryKey: id)
    }
    
    func write(storage: RLMCountryJSON) {
        Realm.write {
            $0.add(storage, update: true)
        }
    }
}

class WeatherRLM: DataBaseProvider {
    
    typealias Storage = RLMWeatherJSON

    func read(id: String) -> RLMWeatherJSON? {
       return Realm.current?.object(ofType: RLMWeatherJSON.self, forPrimaryKey: id)
    }
    
    func write(storage: RLMWeatherJSON) {
        Realm.write {
            $0.add(storage, update: true)
        }
    }
    
}

class RLMWeatherJSON: RLMModel {
    
    @objc dynamic var temperature = 0.0
    
    @objc dynamic var dt = 0.0
    
    convenience init(id: String, temperature: Double, date: Double) {
        self.init()
        self.id = id
        self.temperature = temperature
        self.dt = date
    }
    
    convenience init(json: WeatherJSON) {
        self.init(id: json.sys.country, temperature: json.main.temperature, date: json.dt)
    }
}

class RLMCountryJSON: RLMModel {
    
    @objc dynamic var name = ""
    
    @objc dynamic var capital = ""
    
    convenience init(id: String, name: String, capital: String) {
        self.init()
        self.id = id
        self.name = name
        self.capital = capital
    }
    
    convenience init(json: CountryJSON) {
        self.init(id: json.alpha2Code, name: json.name, capital: json.capital)
    }
}
