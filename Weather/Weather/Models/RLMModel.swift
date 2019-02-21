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
    
    associatedtype Model
    associatedtype Storage
    
    func read(id: String) -> Model?
    func read() -> [Model]?
    func write(model: Model)
}

class DataBaseService<Provider: DataBaseProvider> {
    
    public let value: Provider
    
    init(provider: Provider) {
        self.value = provider
    }
}

class DataRealm<StorageType: Object>: DataBaseProvider
    where StorageType: RealmModelSerializable
{
    
    typealias Storage = StorageType
    typealias Model = StorageType.ConvertableType
    
    open func read(id: String) -> Model? {
        let values = Realm.current?.object(ofType: StorageType.self, forPrimaryKey: id)
        
        return values.map { $0.converted() }
    }
    
    open func read() -> [Model]? {
        let results = Realm.current?.objects(StorageType.self)
        
        return results.map { $0.map { $0.converted() } }
    }
    
    open func write(model: Model) {
        Realm.write {
            let value = Storage(model: model)
            
            $0.add(value, update: true)
        }
    }
}

class CountryDataRLM: DataRealm<RLMCountry> { }

class WeatherDataRLM: DataRealm<RLMWeather> { }

protocol RealmModelSerializable {
    
    associatedtype ConvertableType
    
    init(model: ConvertableType)
    
    func converted() -> ConvertableType
}

class RLMWeather: RLMModel, RealmModelSerializable {
    
    @objc dynamic var temperature = 0
    
    @objc dynamic var date = Date()
    
    convenience init(id: String, temperature: Int, date: Date) {
        self.init()
        self.id = id
        self.temperature = temperature
        self.date = date
    }
    
    required convenience init(model: Weather) {
        self.init(id: model.id, temperature: model.temperature, date: model.date)
    }
    
    func converted() -> Weather {
        return Weather(id: self.id, temperature: self.temperature, date: self.date)
    }
}

class RLMCountry: RLMModel, RealmModelSerializable {
    
    @objc dynamic var name = ""
    
    @objc dynamic var capital = ""
    
    convenience init(id: String, name: String, capital: String) {
        self.init()
        self.id = id
        self.name = name
        self.capital = capital
    }
    
    required convenience init(model: Country) {
        self.init(id: model.id, name: model.name, capital: model.capital)
    }
    
    func converted() -> Country {
        return Country(id: self.id, name: self.name, capital: self.capital)
    }
}
