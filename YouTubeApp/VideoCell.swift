//
//  VideoCell.swift
//  YouTubeApp
//
//  Created by magdy on 3/27/18.
//  Copyright © 2018 magdy. All rights reserved.
//

import UIKit
class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    func setupViews()
    {
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class VideoCell:BaseCell{
    
    var video:Video?{
        didSet{
            titleLabel.text = video?.title
            

            setupThumbnailImage()
            setupProfileImage()
            //    thumbnailImageView.image = UIImage(named: (video?.thumbnailImageName)!)
//            if let profileImageName = video?.channel?.profileImageName
//            {
//                userProfileImageView.image = UIImage(named: profileImageName)
//            
//            }
            
            if let channelName = video?.channel?.name , let numberOfViews = video?.numberOfViews
            {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let subtitleText = "\(channelName) - \(numberFormatter.string(from:numberOfViews))"
                subTitleTextView.text = subtitleText
            }
            // measure title text 
            
            if let title = video?.title
            {
                let size = CGSize(width: frame.width - 16-44-8-16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 14)], context: nil)
            
                if estimatedRect.size.height > 16
                {
                    self.titleLabelHeightConstraint?.constant = 44
                }
                else
                {
                    self.titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    
    func setupThumbnailImage(){
        if let thumbnailImageUrl = video?.thumbnailImageName{
            self.thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    func setupProfileImage(){
        if let profileImageUrl = video?.channel?.profileImageName{
            self.userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    let thumbnailImageView:CustomImageView = {
        let imageView = CustomImageView()
        //imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "images")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView:CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.green
        imageView.image = UIImage(named: "images")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let separatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift swift come from swifty"
        label.numberOfLines = 2
        return label
    }()
    
    let subTitleTextView:UITextView = {
        let textView = UITextView()
        //        textView.backgroundColor = UIColor.red
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "this the subtitle • for the title of taylor •"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.darkGray
        return textView
    }()
    var titleLabelHeightConstraint:NSLayoutConstraint?
    override func setupViews(){
        
        self.addSubview(thumbnailImageView)
        self.addSubview(separatorView)
        self.addSubview(userProfileImageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleTextView)
        
        
        addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,userProfileImageView,separatorView)
        addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstraintWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        // top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        // left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        // right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        // height constraint
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint!)
        
        
        // top constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        // left constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        // right constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        // height constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }

    
}
