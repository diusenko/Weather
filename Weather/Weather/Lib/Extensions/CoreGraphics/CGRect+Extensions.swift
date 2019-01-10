//
//  CGRect+Extensions.swift
//  Square
//
//  Created by Usenko Dmitry on 12/28/18.
//  Copyright © 2018 Usenko Dmitry. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    enum Position {
        case topLeft
        case topRight
        case bottomRight
        case bottomLeft
        case middleLeft
        case middleRight
        case middleTop
        case middleBottom
        case center
    }
    
    var x: CGFloat {
        get { return self.origin.x }
        set { return self.origin.x = newValue }
    }
    
    var y: CGFloat {
        get { return self.origin.y }
        set { return self.origin.y = newValue }
    }
    
    var topLeft: CGPoint {
        return CGPoint(x: self.minX, y: self.minY)
    }
    
    var topRight: CGPoint {
        return CGPoint(x: self.maxX, y: self.minY)
    }
    
    var bottomRight: CGPoint {
        return CGPoint(x: self.maxX, y: self.maxY)
    }
    
    var bottomLeft: CGPoint {
        return CGPoint(x: self.minX, y: self.maxY)
    }
    
    var middleLeft: CGPoint {
        return CGPoint(x: self.minX, y: self.midY)
    }
    
    var middleRight: CGPoint {
        return CGPoint(x: self.maxX, y: self.midY)
    }
    
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
    
    var middleTop: CGPoint {
        return CGPoint(x: self.midX, y: self.minY)
    }
    
    var middleBottom: CGPoint {
        return CGPoint(x: self.midX, y: self.maxY)
    }
    
    func cropped(right: CGFloat, bottom: CGFloat) -> CGRect {
        return CGRect(
            x: self.x,
            y: self.y,
            width: self.width - right,
            height: self.height - bottom
        )
    }
    
    func point(position: Position) -> CGPoint {
        switch position {
        case .topLeft: return self.topLeft
        case .topRight: return self.topRight
        case .bottomRight: return self.bottomRight
        case .bottomLeft: return self.bottomLeft
        case .middleLeft: return self.middleLeft
        case .middleRight: return self.middleLeft
        case .middleTop: return self.middleTop
        case .middleBottom: return self.middleBottom
        case .center: return self.center
        }
    }
}
