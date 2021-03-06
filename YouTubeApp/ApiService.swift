//
//  ApiService.swift
//  YouTubeApp
//
//  Created by magdy on 4/6/18.
//  Copyright © 2018 magdy. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    func fetchVideos(completion:@escaping ([Video]) -> ()){
//        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json") { (videos) in
//            completion(videos)
//        }
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
    
    }
    
    func fetchTrendingFeed(completion:@escaping ([Video]) -> ()){
       
//        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json") { (videos) in
//            completion(videos)
//        }
         fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion:@escaping ([Video]) -> ()){
//        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json") { (videos) in
//            completion(videos)
//        }
        
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)

        
    }
    
    func fetchFeedForUrlString(urlString:String,completion:@escaping ([Video]) -> ())
    {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                
                if let unWrapedData = data , let jsonDictionaries = try JSONSerialization.jsonObject(with: unWrapedData, options: .mutableContainers) as? [[String: AnyObject]]{
//                        var videos = [Video]()
//                    
//                        for dictionary in jsonDictionaries as! [[String: AnyObject]] {
//                        
//                            let video = Video(dictionary: dictionary)
//                            videos.append(video)
//                        }
                    
                    let videos = jsonDictionaries.map({return Video(dictionary: $0)})
                        DispatchQueue.main.async(execute: {
                        //self.collectionView?.reloadData()
                            completion(videos)
                        })
                    
                
                }
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            
            }.resume()
    }
    
}



//func fetchFeedForUrlString(urlString:String,completion:@escaping ([Video]) -> ())
//{
//    let url = NSURL(string: urlString)
//    URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
//        
//        if error != nil {
//            print(error)
//            return
//        }
//        
//        do {
//            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//            
//            var videos = [Video]()
//            
//            for dictionary in json as! [[String: AnyObject]] {
//                
//                let video = Video()
//                video.title = dictionary["title"] as? String
//                video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//                
//                let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//                
//                let channel = Channel()
//                channel.name = channelDictionary["name"] as? String
//                channel.profileImageName = channelDictionary["profile_image_name"] as? String
//                
//                video.channel = channel
//                
//                videos.append(video)
//            }
//            DispatchQueue.main.async(execute: {
//                //self.collectionView?.reloadData()
//                completion(videos)
//            })
//            
//            
//        } catch let jsonError {
//            print(jsonError)
//        }
//        
//        
//        
//        }.resume()
//}

