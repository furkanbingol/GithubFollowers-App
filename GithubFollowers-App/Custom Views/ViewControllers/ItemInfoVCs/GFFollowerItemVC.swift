//
//  GFFollowerItemVC.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 7.09.2023.
//

import UIKit

// Subclass
class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: ItemInfoType.followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: ItemInfoType.following, withCount: user.following)
        
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
        actionButton.addTarget(self, action: #selector(didTapGetFollowers), for: .touchUpInside)
    }
    
    @objc private func didTapGetFollowers() {
        delegate?.didTapGetFollowers(for: self.user)
    }
    
}
