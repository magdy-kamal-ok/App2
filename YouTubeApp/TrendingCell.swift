    //
//  TrendingCell.swift
//  YouTubeApp
//
//  Created by magdy on 4/7/18.
//  Copyright © 2018 magdy. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed{ (videos:[Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
