//
//  Operators.swift
//  Weather
//
//  Created by Usenko Dmitry on 2/12/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

infix operator •: CompositionPrecedence
public func • <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}

infix operator §: RightFunctionApplicationPrecedence
public func § <A, B> (f: (A) -> B, value: A) -> B {
    return f(value)
}

infix operator <|: RightFunctionApplicationPrecedence
public func <| <A, B> (f: (A) -> B, value: A) -> B {
    return f § value
}

infix operator |>: LeftFunctionApplicationPrecedence
public func |> <A, B> ( value: A, f: (A) -> B) -> B {
    return f § value
}


