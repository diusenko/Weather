//
//  View+Extension.swift
//  Square
//
//  Created by Usenko Dmitry on 1/2/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
