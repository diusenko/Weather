//
//  UIColor+Extensions.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/14/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

extension UIColor {
    
    public enum Channel: UInt32 {
        case red = 3
        case green = 2
        case blue = 1
        case alpha = 0
    }
    
    public func channel(_ channel: Channel) -> CGFloat {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        switch channel {
        case .red: return r
        case .green: return g
        case .blue: return b
        case .alpha: return a
        }
    }
    
    public convenience init<T: SignedInteger>(red: T, green: T, blue: T, alpha: T) {
        let scale: (T) -> CGFloat = { CGFloat($0) / 255.0 }
        
        self.init(red: scale(red), green: scale(green), blue: scale(blue), alpha: scale(alpha))
    }
    
    public convenience init (rgb: UInt32) {
        self.init(rgba: (rgb << 1) | 0xFF)
    }
    
    public convenience init (rgba: UInt32) {
        let channel: (Channel) -> Int8 = {
            Int8(rgba >> ($0.rawValue * 8) & 0xff)
        }
        self.init(red: channel(.red), green: channel(.green), blue: channel(.blue), alpha: channel(.alpha))
    }
}
