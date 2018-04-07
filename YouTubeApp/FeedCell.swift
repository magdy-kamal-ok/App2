//
//  FeedCell.swift
//  YouTubeApp
//
//  Created by magdy on 4/6/18.
//  Copyright © 2018 magdy. All rights reserved.
//

import UIKit

class FeedCell: BaseCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout ()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    var videos:[Video]?
    
    let cellId = "cellId"
    override func setupViews() {
        super.setupViews()
        fetchVideos()
        addSubview(collectionView)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    func fetchVideos(){
        
        ApiService.sharedInstance.fetchVideos { (videos:[Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
            if let count = videos?.count
            {
                return count
            }
            return 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)as! VideoCell
            cell.video = videos?[indexPath.item]
            //cell.backgroundColor = UIColor.blue
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let height = (frame.width - 32)*9/16
            return CGSize(width: frame.width, height: height+16+88)
    }
    

    
    
}
