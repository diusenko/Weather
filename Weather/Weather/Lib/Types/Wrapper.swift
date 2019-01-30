//
//  Wrapper.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/29/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public class Wrapper<Value>: ObservableObject<Value> {
    
    public var value: Value {
        didSet {
            self.notify(handler: self.value)
        }
    }
    
    public init(_ value: Value) {
        self.value = value
    }
    
}
