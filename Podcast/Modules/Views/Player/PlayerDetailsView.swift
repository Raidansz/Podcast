//
//  PlayerDetailsView.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 30..
//

import UIKit
import AVFoundation
class PlayerDetailsView:UIView{
    var player: AVPlayer = {
        let player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()
    
    
    
    var episode:Episode!{
        didSet{
            episodeLabel.text = episode.title
            playEpisode()
            //            let sound = episode.streamUrl
//            if let url = URL(string: sound) {
//                self.player = AVPlayer(url: url)
//                authorLabel.text = episode.author
//            }
            
        }
    }
    @IBOutlet weak var episodeLabel: UILabel!{
        didSet{
            episodeLabel.numberOfLines = 2
        }
    }
    
    func playEpisode(){
        if let url = URL(string: episode.streamUrl){
           
            player = AVPlayer(url: url)
            player.play()
           
        }
        
    }

    
    @IBOutlet weak var playPauseButtonOutlet: UIButton!{
        didSet{
            playPauseButtonOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playPauseButtonOutlet.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)

        }
    }
    
    @objc func handlePlayPause(){
        if player.timeControlStatus == .paused{
            player.play()
            playPauseButtonOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            imageIfPlayed()
        }else{
            player.pause()
            playPauseButtonOutlet.setImage(UIImage(systemName: "play.fill"), for: .normal)
            imageIfPaused()
        }
       
       
    }
    
    func imageIfPlayed(){
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1) {
            self.episodeImage.transform = .identity
        }
    }
    
    
    func imageIfPaused(){
        let scale:CGFloat = 0.7
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1) {
            self.episodeImage.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    
    @IBOutlet weak var episodeImage: UIImageView!{
        didSet{
            episodeImage.layer.cornerRadius = 10
            episodeImage.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    
    
}
