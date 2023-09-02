//
//  GFButton.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 23.08.2023.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // required init?(coder: ) --> Storyboard Initializer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Custom init
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)    // dynamic type font == preferredFont
        translatesAutoresizingMaskIntoConstraints = false             // programmatic AUTO-LAYOUT
    }
    
}
