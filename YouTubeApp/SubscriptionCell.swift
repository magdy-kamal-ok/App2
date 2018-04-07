//
//  SubscriptionCell.swift
//  YouTubeApp
//
//  Created by magdy on 4/7/18.
//  Copyright © 2018 magdy. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed{ (videos:[Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
