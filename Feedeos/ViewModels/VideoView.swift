//
//  VideoView.swift
//  Feedeos
//
//  Created by boqian cheng on 2019-03-05.
//  Copyright © 2019 boqiancheng. All rights reserved.
//

import Foundation

struct VideoView {
    
    var contentURL: URL?
    
    init(video: Video) {
        let name = video.fileName
        contentURL = Bundle.main.url(forResource: name, withExtension: "mp4")
    }
}
