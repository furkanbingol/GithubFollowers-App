//
//  UIViewController+Ext.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 27.08.2023.
//

import UIKit

extension UIViewController {

    func presentGFAlertOnMainThread(alertTitle: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen   // important for alert showing
            alertVC.modalTransitionStyle = .crossDissolve      // important for alert showing
            self.present(alertVC, animated: true)
        }
    }
    
}
