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
            episodeLabel.text = episode.title
            
            let sound = episode.streamUrl
            if let url = URL(string: sound) {
                self.player = AVPlayer(url: url)
                authorLabel.text = episode.author
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
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    
    
}
