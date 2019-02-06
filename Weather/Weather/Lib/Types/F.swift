//
//  Types.swift
//  Square
//
//  Created by Usenko Dmitry on 12/27/18.
//  Copyright © 2018 Usenko Dmitry. All rights reserved.
//

import UIKit

enum F {
    
    typealias Completion<Value> = (Value) -> ()
    typealias Execute<Value> = (Value) -> ()
    typealias VoidExecute = () -> ()
    typealias VoidCompletion = () -> ()
}

func side<Value>(_ value: Value, execute: (inout Value) -> ()) -> Value {
    var mutableValue = value
    execute(&mutableValue)
    
    return mutableValue
}

func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}

func when<Result>(_ condition: Bool, execute: () -> Result?) -> Result? {
    return condition ? execute() : nil
}

func toString(_ cls: AnyClass) -> String {
    return String(describing: cls)
}

func dispatchOnMain(_ execute: F.VoidExecute?) {
    DispatchQueue.main.async {
        execute?()
    }
}
