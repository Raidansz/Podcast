//
//  PlayerDetailsView.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 30..
//

import UIKit
import AVFoundation
import MediaPlayer
class PlayerDetailsView:UIView{
    var currentEpisodePlayer: AVPlayer?
    
//    var player: AVPlayer = {
//        let player = AVPlayer()
//        player.automaticallyWaitsToMinimizeStalling = false
//        return player
//    }()
    
    
    
    var episode:Episode!{
        didSet{
            episodeLabel.text = episode.title
            playEpisode()
           
            
        }
    }
    @IBOutlet weak var episodeLabel: UILabel!{
        didSet{
            episodeLabel.numberOfLines = 2
        }
    }
    
    
    func playEpisode() {
      
       

            if let url = URL(string: episode.streamUrl) {
                PlayerManager.shared.playEpisode(url: url)
                
            
                enlargeEpisodeImage()
                
            }
        }
    
    
   

    
    @IBOutlet weak var playPauseButtonOutlet: UIButton!{
        didSet{
            playPauseButtonOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playPauseButtonOutlet.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)

        }
    }
    
    
    @objc func handlePlayPause() {
        
            if  PlayerManager.shared.basePlayer?.timeControlStatus == .paused {
                PlayerManager.shared.basePlayer?.play()
                playPauseButtonOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                enlargeEpisodeImage()
            } else {
                PlayerManager.shared.basePlayer?.pause()
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
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let sessionError {
            print("Failed to activate session", sessionError.localizedDescription)
        }
    }

    private func setupRemoteControl() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { _ in
            PlayerManager.shared.basePlayer?.play()
            return .success
        }
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { _ in
            PlayerManager.shared.basePlayer?.pause()
            return .success
        }
        
        //TODO: Set up other commands like skip forward, skip backward, etc.
        
        // Update the now playing info using MPNowPlayingInfoCenter
        var nowPlayingInfo: [String: Any] = [:]
        nowPlayingInfo[MPMediaItemPropertyTitle] =  "null"
        // other relevant metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }


    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupRemoteControl()
        setupAudioSession()
       

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
    
    @IBAction func Backwards(_ sender: UIButton) {
        PlayerManager.shared.seekBackward(seconds: 15)
    }
    
    @IBAction func forward(_ sender: UIButton) {
        PlayerManager.shared.seekForward(seconds: 15)
    }
    
}
