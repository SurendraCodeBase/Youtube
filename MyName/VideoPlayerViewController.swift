//
//  VideoPlayerViewController.swift
//  MyName
//
//  Created by Surendra Singh on 9/29/17.
//  Copyright © 2017 Surendra Singh. All rights reserved.
//

import UIKit

class VideoPlayerViewController: UIViewController {
    
    @IBOutlet weak var playerView: YTPlayerView!
    var video:Video?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        self.title = self.video?.title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playerView.load(withVideoId: self.video?.videoID)
    }
}
