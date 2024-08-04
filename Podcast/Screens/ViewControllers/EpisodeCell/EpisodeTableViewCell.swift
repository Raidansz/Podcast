//
//  EpisodeTableViewCell.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 30..
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    let identifier = "EpisodeTableViewCell"
    var episode: Episode!{
        didSet{
            
            //cell.contentView.layer.cornerRadius = 40
           //        cell.contentView.layer.masksToBounds = true
                   episodeImageView.layer.cornerRadius = 30
                  episodeImageView.layer.masksToBounds = true
    
            episodeImageView.sd_setImage(with: URL(string: self.episode?.imageUrl ?? ""))
                   
                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "MMM dd, yyyy"
            pubDate.text = dateFormatter.string(from: episode.pubDate)
            title.text = episode.title
           
            eDescription.text = episode.description.description
            eDescription.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var episodeImageView: UIImageView!
    
    @IBOutlet weak var eDescription: UILabel!
    
    @IBOutlet weak var pubDate: UILabel!
    
    @IBOutlet weak var title: UILabel!{
        didSet{
            title.numberOfLines = 2
        }
    }
    
    
    @IBOutlet weak var episodeDescription: UILabel!{
        didSet{
            episodeDescription.numberOfLines = 2
        }
    }
}
