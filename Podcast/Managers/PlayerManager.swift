//
//  PlayerManager.swift
//  Podcast
//
//  Created by Raidan on 2023. 08. 15..
//

import Foundation
import AVFoundation

class PlayerManager {
    static let shared = PlayerManager()
    
  
    var basePlayer: AVPlayer? = {
            let player = AVPlayer()
            player.automaticallyWaitsToMinimizeStalling = false
            return player
       }()

    func playEpisode(url: URL) {
        if let player = basePlayer {
            player.pause()
        }
        
        basePlayer = AVPlayer(url: url)
        basePlayer?.play()
    }
}
