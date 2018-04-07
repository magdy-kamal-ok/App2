//
//  video.swift
//  YouTubeApp
//
//  Created by magdy on 3/30/18.
//  Copyright © 2018 magdy. All rights reserved.
//

import UIKit
class Video: NSObject {
    var thumbnailImageName:String?
    var title:String?
    var numberOfViews:NSNumber?
    var uploadDate:NSDate?
    var channel:Channel?
}

class Channel: NSObject {
    var name:String?
    var profileImageName:String?
}
