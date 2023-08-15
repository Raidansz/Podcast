//
//  PlayerDetailsView.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 30..
//

import UIKit
import AVFoundation
import MediaPlayer
class PlayerDetailsView:UIView, PlayerManagerDelegate{
    func playbackTimeDidChange(currentTime: Double, duration: Double) {
        let progress = Float(currentTime / duration)
               progressBar.setProgress(progress, animated: true)
    }
    
    var currentEpisodePlayer: AVPlayer?
    

    @IBOutlet weak var minVolumeSlider: UISlider!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
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

    func setupInitialVolume() {
           // Set up audio playback and initial minimum volume level
           let initialMinVolume = minVolumeSlider.value
           PlayerManager.shared.adjustVolume(withMinimum: initialMinVolume)
           // ... (other setup code)
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupRemoteControl()
        setupAudioSession()
        setupInitialVolume()
        PlayerManager.shared.delegate = self
        progressBar.isUserInteractionEnabled = true
        
        // Add tap gesture recognizer
               let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
               progressBar.addGestureRecognizer(tapGesture)
               
               // Add pan gesture recognizer
               let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
               progressBar.addGestureRecognizer(panGesture)

    }
    
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        guard let duration = PlayerManager.shared.currentDuration else {
            return
        }
        
        let tapPoint = gesture.location(in: progressBar)
        let progress = max(0, min(1, Float(tapPoint.x / progressBar.bounds.width)))
        let seekTime = Double(progress) * duration
        
        PlayerManager.shared.seekForward(seconds: seekTime)
    }

    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let duration = PlayerManager.shared.currentDuration else {
            return
        }
        
        switch gesture.state {
        case .began:
            // Handle gesture began state (e.g., pause playback)
            break
        case .changed:
            let translation = gesture.translation(in: progressBar)
            let xOffset = translation.x
            let totalWidth = progressBar.bounds.width
            let progress = max(0, min(1, Float(xOffset / totalWidth)))
            let seekTime = Double(progress) * duration
            PlayerManager.shared.seekForward(seconds: seekTime)
        case .ended:
            // Handle gesture ended state (e.g., resume playback)
            break
        default:
            break
        }
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
    
    @IBAction func minVolumeSliderValueChanged(_ sender: UISlider) {
        let newMinVolume = sender.value
                PlayerManager.shared.adjustVolume(withMinimum: newMinVolume)
    }
}
