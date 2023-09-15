//
//  UITableView+Ext.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 15.09.2023.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
}
