//
//  PlayerDetailsView.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 30..
//

import UIKit

class PlayerDetailsView:UIView{
    
    var episode:Episode!{
        didSet{
            episodeLabel.text = episode.titleText
        }
    }
    @IBOutlet weak var episodeLabel: UILabel!{
        didSet{
            episodeLabel.numberOfLines = 2
        }
    }
    
    @IBAction func playPauseButton(_ sender: Any) {
    }
    @IBOutlet weak var episodeImage: UIImageView!{
        didSet{
           
        }
    }
    
    
    @IBAction func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    
    
}
