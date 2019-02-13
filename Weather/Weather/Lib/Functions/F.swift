//
//  Types.swift
//  Square
//
//  Created by Usenko Dmitry on 12/27/18.
//  Copyright © 2018 Usenko Dmitry. All rights reserved.
//

import UIKit

public enum F {
    
    public typealias Completion<Value> = (Value) -> ()
    public typealias Execute<Value> = (Value) -> ()
    public typealias VoidExecute = () -> ()
    public typealias VoidCompletion = () -> ()
}

public func side<Value>(_ value: Value, execute: (inout Value) -> ()) -> Value {
    var mutableValue = value
    execute(&mutableValue)
    
    return mutableValue
}

public func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}

public func when<Result>(_ condition: Bool, execute: () -> Result?) -> Result? {
    return condition ? execute() : nil
}

public func toString(_ cls: AnyClass) -> String {
    return String(describing: cls)
}

public func dispatchOnMain(_ execute: F.VoidExecute?) {
    DispatchQueue.main.async {
        execute?()
    }
}

public func identity<Value>(_ value: Value) -> Value {
    return value
}

public func returnValue<Value>(_ value: Value) -> () -> (Value) {
    return { value }
}

public func ignoreInput<Value, Result>(_ action: @escaping () -> Result) -> (Value) -> Result {
    return { _ in
        action()
    }
}

public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in
        { f(a,$0) }
    }
}

public func uncurry<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (A, B) -> C {
    return { f($0)($1) }
}

public func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    return { b in
        { f($0)(b) }
    }
}

public func flip<A, B, C>(_ f: @escaping (A, B) -> C) -> (B, A) -> C {
    return { f($1, $0) }
}
