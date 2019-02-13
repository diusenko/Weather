//
//  PrecedenceGroups.swift
//  Weather
//
//  Created by Usenko Dmitry on 2/12/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

precedencegroup LeftFunctionApplicationPrecedence {
    associativity: left
    higherThan: AssignmentPrecedence
}

precedencegroup RightFunctionApplicationPrecedence {
    associativity: right
    higherThan: LeftFunctionApplicationPrecedence
}

precedencegroup CompositionPrecedence {
    associativity: left
    higherThan: RightFunctionApplicationPrecedence
}
