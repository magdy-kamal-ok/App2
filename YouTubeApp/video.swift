//
//  video.swift
//  YouTubeApp
//
//  Created by magdy on 3/30/18.
//  Copyright © 2018 magdy. All rights reserved.
//

import UIKit

class safeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        
        let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        
        let range = key.startIndex..<key.index(key.startIndex, offsetBy: 1)
        let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if(!responds){
            return
        }
        super.setValue(value, forKey: key)
    }
}

class Video: safeJsonObject {
    var thumbnail_image_name:String?
    var title:String?
    var number_of_views:NSNumber?
    var uploadDate:NSDate?
    var duration:NSNumber?
//    var num_likes:NSNumber?
    var channel:Channel?
    
    
    init(dictionary:[String:AnyObject]) {
        super.init()
        self.setValuesForKeys(dictionary)

    }
    override func setValue(_ value: Any?, forKey key: String) {
        
        
        if key == "channel"{
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String: AnyObject])
      
        }
        else {
         super.setValue(value, forKey: key)   
        }
    }

}

class Channel: safeJsonObject {
    var name:String?
    var profile_image_name:String?
}
