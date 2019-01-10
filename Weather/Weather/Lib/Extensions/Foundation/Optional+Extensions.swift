//
//  Optional+Extensions.swift
//  Square
//
//  Created by Usenko Dmitry on 12/27/18.
//  Copyright © 2018 Usenko Dmitry. All rights reserved.
//

import Foundation

extension Optional {
    
    func `do`(_ execute: (Wrapped) -> ()) {
        self.map(execute)
    }
    
    func apply<Result>(_ transform: ((Wrapped) -> (Result))?) -> Result? {
        return self.flatMap { transform?($0) }
    }
}

