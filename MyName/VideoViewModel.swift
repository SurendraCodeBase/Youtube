//
//  VideoViewModel.swift
//  MyName
//
//  Created by Surendra Singh on 9/29/17.
//  Copyright © 2017 Surendra Singh. All rights reserved.
//

import UIKit

class VideoViewModel: NSObject {
    
    weak var videoDelegate: VideoProtocol?
    private var video: Video?
    
    var titleText: String? {
        return video!.title
    }
    var imageUrl: String? {
        if let imageUrl = video?.thumbnail {
            return imageUrl
        } else {
            return nil
        }
    }
    
   
    func getVideoData(text: String) {
    
        let videoData = VideoData()
        videoData.fetchVideos(text: text, delegate: videoDelegate!)
    }
    
    convenience init? (video: Video) {
        self.init()
        self.video = video
    }

}
