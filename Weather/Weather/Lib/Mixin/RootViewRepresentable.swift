//
//  RootViewRepresentable.swift
//  Square
//
//  Created by Usenko Dmitry on 1/3/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

protocol RootViewRepresentable {
    
    associatedtype RootView: UIView
}

extension RootViewRepresentable where Self: UIViewController {
    
    var rootView: RootView? {
        
        return cast(self.viewIfLoaded)
    }
}
