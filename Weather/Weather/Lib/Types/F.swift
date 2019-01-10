//
//  Types.swift
//  Square
//
//  Created by Usenko Dmitry on 12/27/18.
//  Copyright © 2018 Usenko Dmitry. All rights reserved.
//

import Foundation
import UIKit

enum F {
    
    typealias Completion<Value> = (Value) -> ()
    typealias VoidExecute = () -> ()
}

func cast<Value, Result>(value: Value) -> Result? {
    return value as? Result
}

func when<Result>(condition: Bool, execute: () -> Result?) -> Result? {
    return condition ? execute() : nil
}
