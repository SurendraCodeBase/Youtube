//
//  Video.swift
//  MyName
//
//  Created by Surendra Singh on 9/29/17.
//  Copyright © 2017 Surendra Singh. All rights reserved.
//

import UIKit

class Video: NSObject {

    var title: String
    var thumbnail: String
    var videoID: String
    
    init(title: String?, thumbnail: String?, videoID: String?) {
        
        self.title = title ?? ""
        self.thumbnail = thumbnail ?? ""
        self.videoID = videoID ?? ""
    }

}
