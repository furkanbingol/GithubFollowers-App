//
//  GFAvatarImageView.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 29.08.2023.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    private let placeholderImage = Images.placeholderImage

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage     // add placeholder photo
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setImage(from urlString: String) {
        NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
            guard let self = self else { return }       // not do anything. Because 'placeholder image' is already showing.
            self.image = image
        }
    }
}
