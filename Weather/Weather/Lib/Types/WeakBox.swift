//
//  WeakBox.swift
//  Weather
//
//  Created by Usenko Dmitry on 2/18/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import Foundation

public struct WeakBox<Wrapped: AnyObject> {
    
    public var isEmpty: Bool {
        return self.wrapped == nil
    }
    
    public private(set) weak var wrapped: Wrapped?
    
    public init(_ wrapped: Wrapped?) {
        self.wrapped = wrapped
    }
}

extension WeakBox: Equatable {
    
    public static func ==(lhs: WeakBox, rhs: WeakBox) -> Bool {
        return lhs.wrapped.flatMap { lhs in
            rhs.wrapped.map { $0 === lhs }
            }
            ?? false
    }
}
