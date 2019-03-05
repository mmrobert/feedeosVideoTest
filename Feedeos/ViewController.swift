//
//  ViewController.swift
//  Feedeos
//
//  Created by boqian cheng on 2019-03-04.
//  Copyright © 2019 boqiancheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var carolRoll: UICollectionView!
    
    var lastDisplayedCell: VideoPlayingCell?
    
    var videosList: [VideoView] = []
    
    let names = ["K9Advantix", "Sargento", "HowDoes", "RiceKrispies", "Gorilla2018", "ReeseEggs"]
    
    var currentPage: Int = 0
    
    fileprivate var pageSize: CGSize {
        
        let layout = self.carolRoll.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Short Videos"
        
        let vlist = VideosListView(names: names)
        videosList = vlist.videosList
        // Do any additional setup after loading the view, typically from a nib.
        
        let cellColl = UINib(nibName: "VideoPlayingCell", bundle: nil)
        self.carolRoll.register(cellColl, forCellWithReuseIdentifier: "cellColl")
        
        let flowLayout = UPCarouselFlowLayout()
        let itemWidth = UIScreen.main.bounds.size.width - 52
        let itemHeight = itemWidth * (9 / 16)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.89
        flowLayout.sideItemAlpha = 1.0
        flowLayout.spacingMode = .fixed(spacing: 14.0)
        
        self.carolRoll.collectionViewLayout = flowLayout
        self.carolRoll.delegate = self
        self.carolRoll.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // after screen first time showing, play the first cell
        let disPlayedIndex = IndexPath(item: currentPage, section: 0)
        lastDisplayedCell = carolRoll.cellForItem(at: disPlayedIndex) as? VideoPlayingCell
        
        lastDisplayedCell?.playVideo()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videosList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellColl", for: indexPath) as! VideoPlayingCell
        if self.videosList.count > 0 {
            let video = self.videosList[indexPath.row]
            
            cell.createPlayer(videoView: video)
            
            cell.playVideo()
            cell.pauseVideo()
        }
        
        return cell
    }
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // find the visible cell (page index)
        let layout = self.carolRoll.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        
        // pause invisible cell playing
        lastDisplayedCell?.pauseVideo()
        let disPlayedIndex = IndexPath(item: currentPage, section: 0)
        lastDisplayedCell = carolRoll.cellForItem(at: disPlayedIndex) as? VideoPlayingCell
        // play visible cell
        lastDisplayedCell?.playVideo()
    }
    
}

