//
//  GFEmptyStateView.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 2.09.2023.
//

import UIKit

class GFEmptyStateView: UIView {
    
    private let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    private let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // custom init
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configureMessageLabel()
        configureLogoImageView()
    }
    
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        addSubview(messageLabel)
        
        let labelCenterYConstant: CGFloat       = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhoneSE3rdGeneration ? -100 : -150
        let messageLabelCenterYConstraint       = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        messageLabelCenterYConstraint.isActive  = true
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureLogoImageView() {
        logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logoImageView)
    
        let imageViewBottomConstant: CGFloat    = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhoneSE3rdGeneration ? 80 : 40
        let logoImageViewBottomConstraint       = logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: imageViewBottomConstant)
        logoImageViewBottomConstraint.isActive  = true
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 180)
        ])
    }
    
}
