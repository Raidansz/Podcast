//
//  PlayerManager.swift
//  Podcast
//
//  Created by Raidan on 2023. 08. 15..
//

import Foundation
import AVFoundation


protocol PlayerManagerDelegate: AnyObject {
    func playbackTimeDidChange(currentTime: Double, duration: Double)
}


class PlayerManager {
    weak var delegate: PlayerManagerDelegate?
    static let shared = PlayerManager()
    private var timeObserver: Any?
    var currentDuration: Double?
    var minimumVolume: Float = 0.0
    var basePlayer: AVPlayer? = {
            let player = AVPlayer()
            player.automaticallyWaitsToMinimizeStalling = false
            return player
       }()

    func adjustVolume(withMinimum volume: Float) {
            let adjustedVolume = max(volume, minimumVolume)
            basePlayer?.volume = adjustedVolume
        }
    
    func playEpisode(url: URL) {
        if let player = basePlayer {
            player.pause()
        }
        
        basePlayer = AVPlayer(url: url)
        basePlayer?.play()
        
        timeObserver = basePlayer?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { [weak self] time in
                   let currentTime = CMTimeGetSeconds(time)
                   if let duration = self?.basePlayer?.currentItem?.duration.seconds {
                       self?.updatePlaybackTime(currentTime: currentTime, duration: duration)
                   }
               }
        

        currentDuration = basePlayer?.currentItem?.duration.seconds

               
           
        
    }
    
    private func updatePlaybackTime(currentTime: Double, duration: Double) {
           delegate?.playbackTimeDidChange(currentTime: currentTime, duration: duration)
       }
    
    
    func seekForward(seconds: Double) {
           if let player = basePlayer {
               let currentTime = CMTimeGetSeconds(player.currentTime())
               let newTime = currentTime + seconds
               let timeToSeek = CMTimeMakeWithSeconds(newTime, preferredTimescale: 1)
               player.seek(to: timeToSeek)
           }
       }

       func seekBackward(seconds: Double) {
           if let player = basePlayer {
               let currentTime = CMTimeGetSeconds(player.currentTime())
               let newTime = max(currentTime - seconds, 0)
               let timeToSeek = CMTimeMakeWithSeconds(newTime, preferredTimescale: 1)
               player.seek(to: timeToSeek)
           }
       }
}
