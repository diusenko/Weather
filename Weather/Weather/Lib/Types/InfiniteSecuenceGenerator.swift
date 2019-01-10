//
//  Generator.swift
//  Square
//
//  Created by Usenko Dmitry on 1/2/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

final class InfiniteSecuenceGenerator<Value> {
    
    private let values: [Value]
    private let index = Atomic(0)
    
    public init(_ values: [Value]) {
        self.values = values
    }
    
    public convenience init(_ values: Value...) {
        self.init(values)
    }
    
    public func next() -> Value {
        return self.index.modify { index in
            index = (index + 1) % self.values.count
        
            return values[index]
        }
    }
}
