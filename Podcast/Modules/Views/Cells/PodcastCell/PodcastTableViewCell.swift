//
//  PodcastTableViewCell.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 02. 12..
//


import UIKit

class PodcastTableViewCell: UITableViewCell {
    let identifier = "PodcastTableViewCell"
    var podcast: Podcast!{
        didSet{
            trackName.text = podcast.trackName
            contentView.layer.cornerRadius = 40
                    contentView.layer.masksToBounds = true
            podcastImageView.layer.cornerRadius = 30
            podcastImageView.layer.masksToBounds = true
            
            podcastImageView.sd_setImage(with: URL(string: self.podcast?.artworkUrl600 ?? ""))
            artistName.text = podcast.artistName
            if let safenumber = podcast.trackCount{
                numberOFEpisodes.text = "\(safenumber) episodes"
            }
           
           
                      
        }
    }
    
    @IBOutlet weak var podcastImageView: UIImageView!
    
    
    @IBOutlet weak var trackName: UILabel!
    
    
    @IBOutlet weak var artistName: UILabel!
    
    
    @IBOutlet weak var numberOFEpisodes: UILabel!
    
}
