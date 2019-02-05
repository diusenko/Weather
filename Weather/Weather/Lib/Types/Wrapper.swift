//
//  Wrapper.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/29/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public class Wrapper<Value>: ObservableObject<Value> {
    
    private(set) var value: Value
    
    public init(_ value: Value) {
        self.value = value
    }
    
    public func modify<Result>(action: (inout Value) -> Result) -> Result {
        defer {
            self.notify(handler: self.value)
        }
        
        return action(&self.value)
    }
}
