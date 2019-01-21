//
//  UITableView+ReloadRow.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/21/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

extension UITableView {
    func reloadRow(at index: IndexPath, with animation: UITableView.RowAnimation){
        self.reloadRows(at: [index], with: animation)
    }
}

