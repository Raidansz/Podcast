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
            if let duration = self?.basePlayer?.currentItem?.duration.seconds, !duration.isNaN {
                self?.updatePlaybackTime(currentTime: currentTime, duration: duration)
                self?.currentDuration = duration // Set currentDuration
            }
        }
    }

    
    
    
    private func updatePlaybackTime(currentTime: Double, duration: Double) {
           delegate?.playbackTimeDidChange(currentTime: currentTime, duration: duration)
       }
    
    
//    func seekForward(seconds: Double) {
//           if let player = basePlayer {
//               let currentTime = CMTimeGetSeconds(player.currentTime())
//               let newTime = currentTime + seconds
//               let timeToSeek = CMTimeMakeWithSeconds(newTime, preferredTimescale: 1)
//               player.seek(to: timeToSeek)
//           }
//       }
    
    func seekForward(seconds: Double) {
        if let player = basePlayer {
            let currentTime = CMTimeGetSeconds(player.currentTime())
            let newTime = currentTime + seconds
            
            if newTime <= currentDuration ?? 0 {
                let timeToSeek = CMTimeMakeWithSeconds(newTime, preferredTimescale: Int32.max)
                player.seek(to: timeToSeek)
            } else {
                // Handle seeking beyond the duration of the media
                // You may want to pause or stop playback here
            }
        }
    }
    
    

//       func seekBackward(seconds: Double) {
//           if let player = basePlayer {
//               let currentTime = CMTimeGetSeconds(player.currentTime())
//               let newTime = max(currentTime - seconds, 0)
//               let timeToSeek = CMTimeMakeWithSeconds(newTime, preferredTimescale: 1)
//               player.seek(to: timeToSeek)
//           }
//       }
    
    
    func seekBackward(seconds: Double) {
        if let player = basePlayer {
            let currentTime = CMTimeGetSeconds(player.currentTime())
            let newTime = max(currentTime - seconds, 0)
            
            // Use a higher timescale for better precision
            let preferredTimescale: Int32 = Int32.max // You can adjust this value as needed
            
            let timeToSeek = CMTimeMakeWithSeconds(newTime, preferredTimescale: preferredTimescale)
            player.seek(to: timeToSeek)
        }
    }

}
