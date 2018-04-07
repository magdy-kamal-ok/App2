//
//  SettingsCell.swift
//  YouTubeApp
//
//  Created by magdy on 3/31/18.
//  Copyright © 2018 magdy. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    var setting:Setting?{
        didSet{
            nameLabel.text = (setting?.name).map { $0.rawValue }
            iconImageView.image = UIImage(named:(setting?.imageName)!)?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = UIColor.darkGray
            
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let iconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "home")
        return imageView
    }()
    override func setupViews() {
        super.setupViews()
        addSubview(iconImageView)
        addSubview(nameLabel)
        
        addConstraintWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView,nameLabel)
        addConstraintWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintWithFormat(format: "V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: nameLabel, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
