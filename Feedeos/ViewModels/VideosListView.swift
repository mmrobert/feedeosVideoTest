//
//  VideosListView.swift
//  Feedeos
//
//  Created by boqian cheng on 2019-03-05.
//  Copyright © 2019 boqiancheng. All rights reserved.
//

import Foundation

struct VideosListView {
    
    var videosList: [VideoView]
    
    init(names: [String]) {
        videosList = [VideoView]()
        for name in names {
            let video: Video = Video(fileName: name)
            let videoView = VideoView(video: video)
            videosList.append(videoView)
        }
    }
}
