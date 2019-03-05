//
//  VideoPlayingCell.swift
//  Feedeos
//
//  Created by boqian cheng on 2019-03-04.
//  Copyright © 2019 boqiancheng. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayingCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    
    var player: AVQueuePlayer!
    var playerLayer: AVPlayerLayer!
    var playerLooper: AVPlayerLooper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func createPlayer(videoView: VideoView) {
        
        if playerLayer != nil {
            // collection view resuable problem
            // remove playerlayer, if exist
            playerLayer.removeFromSuperlayer()
        }
    
        if let url = videoView.contentURL {
            
            let playItem = AVPlayerItem(url: url)
            player = AVQueuePlayer(playerItem: playItem)
    
            playerLayer = AVPlayerLayer(player: player)
            // repeat playing
            playerLooper = AVPlayerLooper(player: player, templateItem: playItem)
            
            playerLayer.videoGravity = .resize
            containerView.layer.addSublayer(playerLayer)
            playerLayer.frame = containerView.bounds
        }
    }
    
    func playVideo() {
        player.play()
    }
    
    func pauseVideo() {
        player.pause()
    }
}
