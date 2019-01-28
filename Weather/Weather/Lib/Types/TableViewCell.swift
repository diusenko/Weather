//
//  TableViewCell.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/28/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

class TableViewCell : UITableViewCell {
    
    override var reuseIdentifier: String? {
        return toString(type(of: self))
    }
}
