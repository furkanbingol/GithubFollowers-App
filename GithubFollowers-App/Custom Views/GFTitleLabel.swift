//
//  GFTitleLabel.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 27.08.2023.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // custom init
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true        // If text size is long, reduce the font size.
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail       // furkanbin...
        translatesAutoresizingMaskIntoConstraints = false
    }

}
