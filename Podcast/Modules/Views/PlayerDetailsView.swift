//
//  PlayerDetailsView.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 30..
//

import UIKit
import AVFoundation
class PlayerDetailsView:UIView{
    var player: AVPlayer?
    
    
    
    var episode:Episode!{
        didSet{
            episodeLabel.text = episode.titleText
            
            let sound = episode.enclosure
            if let url = URL(string: sound) {
                self.player = AVPlayer(url: url)
                
            }
            
        }
    }
    @IBOutlet weak var episodeLabel: UILabel!{
        didSet{
            episodeLabel.numberOfLines = 2
        }
    }
    
    @IBAction func playPauseButton(_ sender: Any) {
        player?.play()
    }
    @IBOutlet weak var episodeImage: UIImageView!{
        didSet{
        
        }
    }
    
    
    @IBAction func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    
    
}
