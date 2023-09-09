//
//  GFRepoItemVC.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 7.09.2023.
//

import UIKit

// Subclass
class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: ItemInfoType.repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: ItemInfoType.gists, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
        actionButton.addTarget(self, action: #selector(didTapGitHubProfile), for: .touchUpInside)
    }
    
    @objc private func didTapGitHubProfile() {
        delegate?.didTapGitHubProfile(for: self.user)
    }
    
}
