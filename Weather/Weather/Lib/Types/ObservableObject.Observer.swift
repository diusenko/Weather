//
//  ObservableObject+Observer.swift
//  CarWash
//
//  Created by Usenko Dmitry on 12/18/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

extension ObservableObject {
    
    public class Observer: Hashable, Cancellable {
        
        public typealias Handler = (State) -> ()
        
        public var hashValue: Int {
            return ObjectIdentifier(self).hashValue
        }
        
        public var isCancelled: Bool {
            return self.sender != nil
        }
        
        private weak var sender: ObservableObject?
        
        public private(set) var handler: Handler
        
        public init(sender: ObservableObject, handler: @escaping Handler) {
            self.sender = sender
            self.handler = handler
        }
        
        public func cancel() {
            self.sender = nil
        }
        
        public static func == (lhs: Observer, rhs: Observer) -> Bool {
            return lhs === rhs
        }
    }
}
