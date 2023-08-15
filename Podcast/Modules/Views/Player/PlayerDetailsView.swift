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
           enlargeEpisodeImage()
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
        enlargeEpisodeImage()
        }else{
            player.pause()
            playPauseButtonOutlet.setImage(UIImage(systemName: "play.fill"), for: .normal)
            shrinkEpisodeImage()
        }
       
       
    }
    
    func enlargeEpisodeImage(){
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1) {
            self.episodeImage.transform = .identity
        }
    }
    
    
    func shrinkEpisodeImage(){
        let scale:CGFloat = 0.7
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1) {
            self.episodeImage.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //TODO
//       let time = CMTimeMake(value: 1, timescale: 3)
//        let times = [NSValue(time: time)]
////        player.addBoundaryTimeObserver(forTimes: times, queue: .main) {
////            self.enlargeEpisodeImage()
////            print("started plattitienginag")
//       // }
//
//
//            // Set initial time to zero
//
//            // Divide the asset's duration into quarters.
//
//
//            // Build boundary times at 25%, 50%, 75%, 100%
//
//
//            // Add time observer. Observe boundary time changes on the main queue.
//            player.addBoundaryTimeObserver(forTimes: times,
//                                                               queue: .main) { [weak self] in
//                // Update UI
//                self?.enlargeEpisodeImage()
//            }
    }
    
    @IBOutlet weak var episodeImage: UIImageView!{
        didSet{
            let scale:CGFloat = 0.7
            episodeImage.transform = CGAffineTransform(scaleX: scale, y: scale)
            episodeImage.layer.cornerRadius = 10
            episodeImage.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func handleDismiss(_ sender: Any) {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1) {
            self.removeFromSuperview()
        }
       
    }
    
    
    
}
