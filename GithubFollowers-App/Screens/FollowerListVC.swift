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
    var username: String?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    // MARK: - Functions
    
    
}
