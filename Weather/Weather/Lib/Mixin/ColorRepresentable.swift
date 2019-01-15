//
//  ColorRepresentable.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

protocol ColorRepresentable {
    
    var opaque: UIColor { get }
    
    func alpha(_ alpha: CGFloat) -> UIColor
}

extension ColorRepresentable where Self: RawRepresentable, Self.RawValue == UInt32 {

    var opaque: UIColor {
        return .init(rgb: self.rawValue)
    }

    func alpha(_ alpha: CGFloat) -> UIColor {
        return self.opaque.withAlphaComponent(alpha)
    }
}
