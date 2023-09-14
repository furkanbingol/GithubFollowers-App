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
    /*
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    */
    
    // custom init with "convenience init"
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        // not necessary configure() because self.init(frame: .zero) already called.
    }
    
    private func configure() {
        textColor = .label
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail       // furkanbin...
        translatesAutoresizingMaskIntoConstraints = false
    }

}
