//
//  GFFollowerItemVC.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 7.09.2023.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

// Subclass
class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerItemVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: ItemInfoType.followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: ItemInfoType.following, withCount: user.following)
        
        actionButton.set(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")
        actionButton.addTarget(self, action: #selector(didTapGetFollowers), for: .touchUpInside)
    }
    
    @objc private func didTapGetFollowers() {
        delegate?.didTapGetFollowers(for: self.user)
    }
    
}
