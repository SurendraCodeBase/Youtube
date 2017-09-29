//
//  VideoData.swift
//  MyName
//
//  Created by Surendra Singh on 9/29/17.
//  Copyright © 2017 Surendra Singh. All rights reserved.
//

import UIKit


class VideoData: NSObject {
    
    var videos = [Video]()
    let apiKey = "AIzaSyD93Gtcv88mfQ8hZGxl4KAeYoqXk-XlYQ0"
    
    func fetchVideos(text:String,delegate: VideoProtocol){
        self.videos.removeAll(keepingCapacity: false)
        
        var urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(text)&key=\(apiKey)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let targetURL = URL(string: urlString)
        
        performGetRequest(targetURL, completion: { (data, HTTPStatusCode, error) -> Void in
            if HTTPStatusCode == 200 && error == nil {
                do {
                    let resultsDict:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    
                    let items: Array<Dictionary<NSObject, AnyObject>> = resultsDict["items"] as! Array<Dictionary<NSObject, AnyObject>>
                    
                    for i in 0 ..< items.count {
                        let item :NSDictionary = items[i] as NSDictionary
                        let snippetDict:[String:AnyObject] = item["snippet"] as! [String:AnyObject]
                        
                        let title = snippetDict["title"]
                        let thumbnail = ((snippetDict["thumbnails"] as! [String:AnyObject])["default"] as! [String:AnyObject])["url"]
                        let videoID = (item["id"] as! [String:AnyObject])["videoId"]
                        let video = Video(title: title as? String, thumbnail: thumbnail as? String, videoID: videoID as? String)
                        self.videos.append(video)
                    }
                    
                    delegate.resetTableData(videos:self.videos)
                } catch {
                    print(error)
                    delegate.resetTableData(videos:self.videos)
                }
            }
            else {
                print("HTTP Status Code = \(HTTPStatusCode)")
                print("Error while loading channel videos: \(String(describing: error))")
                delegate.resetTableData(videos:self.videos)
            }
        })
    }
    
    func performGetRequest(_ targetURL: URL!, completion: @escaping (_ data: Data?, _ HTTPStatusCode: Int, _ error: NSError?) -> Void) {
        var request = URLRequest(url: targetURL)
        request.httpMethod = "GET"
        
        let sessionConfiguration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfiguration)
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data!, response: URLResponse!, error: Error!) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                completion(data, (response as! HTTPURLResponse).statusCode, error as NSError?)
            })
        })
        task.resume()
    }
}
