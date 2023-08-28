//
//  FollowerListVC.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 24.08.2023.
//

import UIKit

class FollowerListVC: UIViewController {

    // MARK: - UI Elements
    
    
    // MARK: - Properties
    var username: String!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers):
                // Set followers array later
                print(followers.count)
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)   // not use: (.isNavigationBarHidden = true)
    }
    
    
    // MARK: - Functions
    
    
}
