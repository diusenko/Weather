//
//  UINib+Extension.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/28/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

extension UINib {
    convenience init(_ viewClass: AnyClass, bundle: Bundle? = nil) {
        self.init(nibName: toString(viewClass), bundle: bundle)
    }
}
