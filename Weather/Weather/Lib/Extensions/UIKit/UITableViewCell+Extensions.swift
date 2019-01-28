//
//  TableViewCell+Extensions.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/15/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ cellClass: AnyClass) {
        self.register(UINib(cellClass), forCellReuseIdentifier: toString(cellClass))
    }
    
    func dequeueReusableCell(withCellClass cellClass: AnyClass) -> UITableViewCell? {
        return self.dequeueReusableCell(withIdentifier: toString(cellClass))
    }
    
    func dequeueReusableCell(withCellClass cellClass: AnyClass, for indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(withCellClass cellClass: Cell.Type, for indexPath: IndexPath, configure: F.Execute<Cell>) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath)
        cast(cell).do(configure)
        
        return cell
    }
}
