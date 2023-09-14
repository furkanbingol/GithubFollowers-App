//
//  UIView+Ext.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 14.09.2023.
//

import UIKit

extension UIView {
    // variadic parameter --> ...
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}
