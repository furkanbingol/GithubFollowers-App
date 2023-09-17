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
    convenience init(color: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        // configure()    // not necessary because of "convenience"
        set(color: color, title: title, systemImageName: systemImageName)
    }
    
    
    private func configure() {
        // button style configuration - iOS15+
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
        
        
        // layer.cornerRadius = 10
        // setTitleColor(.white, for: .normal)
        // titleLabel?.font = .preferredFont(forTextStyle: .headline)    // dynamic type font == preferredFont
    }
    
    
    func set(color: UIColor, title: String, systemImageName: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
        
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
        
        // self.backgroundColor = backgroundColor
        // self.setTitle(title, for: .normal)
    }
}
