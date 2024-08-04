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

protocol AVPlayerItemObserver: AnyObject {
    func playerItem(_ playerItem: AVPlayerItem, didChangeDuration duration: Double)
}

class PlayerManager: NSObject {
    weak var delegate: PlayerManagerDelegate?
    static let shared = PlayerManager()
    private var timeObserver: Any?
    var currentDuration: Double?
    var minimumVolume: Float = 0.0

    private let durationCache = NSCache<NSURL, NSNumber>()
    private var durationDictionary = [String: Double]()
    private let userDefaultsKey = "PlayerManagerDurationCache"

    var basePlayer: AVPlayer? {
        didSet {
            if let oldPlayer = oldValue {
                removeObservers(from: oldPlayer)
            }
        }
    }

    override init() {
        super.init()
        loadCacheFromUserDefaults()
    }

    deinit {
        if let player = basePlayer {
            removeObservers(from: player)
        }
    }

    func adjustVolume(withMinimum volume: Float) {
        let adjustedVolume = max(volume, minimumVolume)
        basePlayer?.volume = adjustedVolume
    }

    func seekBackward(seconds: Double) {
        if let player = basePlayer {
            let currentTime = CMTimeGetSeconds(player.currentTime())
            let newTime = max(currentTime - seconds, 0)
            let timeToSeek = CMTimeMakeWithSeconds(newTime, preferredTimescale: 600)
            player.seek(to: timeToSeek)
        }
    }

    func seekForward(seconds: Double) {
        if let player = basePlayer, let currentDuration = currentDuration {
            let currentTime = CMTimeGetSeconds(player.currentTime())
            let newTime = min(currentTime + seconds, currentDuration)
            let timeToSeek = CMTimeMakeWithSeconds(newTime, preferredTimescale: 600)
            player.seek(to: timeToSeek)
        }
    }

    func playEpisode(url: URL) {
        if let player = basePlayer {
            player.pause()
        }

        if let cachedDuration = durationCache.object(forKey: url as NSURL) {
            currentDuration = cachedDuration.doubleValue
            initializePlayer(with: url)
        } else {
            self.basePlayer = AVPlayer(url: url)
            basePlayer?.play()
            addObserverForDuration()
        }
    }

    private func initializePlayer(with url: URL) {
        self.basePlayer = AVPlayer(url: url)
        basePlayer?.play()
        timeObserver = basePlayer?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 600), queue: .main) { [weak self] time in
            guard let self = self else { return }
            let currentTime = CMTimeGetSeconds(time)
            if let duration = self.currentDuration, !duration.isNaN {
                self.updatePlaybackTime(currentTime: currentTime, duration: duration)
            }
        }
    }

    private func addObserverForDuration() {
        if let playerItem = basePlayer?.currentItem {
            playerItem.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        }
    }

    private func removeObservers(from player: AVPlayer) {
        if let playerItem = player.currentItem {
            playerItem.removeObserver(self, forKeyPath: "duration")
        }
        if let timeObserver = timeObserver {
            player.removeTimeObserver(timeObserver)
            self.timeObserver = nil
        }
    }

    private func updatePlaybackTime(currentTime: Double, duration: Double) {
        delegate?.playbackTimeDidChange(currentTime: currentTime, duration: duration)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let playerItem = object as? AVPlayerItem {
            let duration = CMTimeGetSeconds(playerItem.duration)
            if !duration.isNaN {
                currentDuration = duration
                if let urlAsset = playerItem.asset as? AVURLAsset {
                    let url = urlAsset.url
                    durationCache.setObject(NSNumber(value: duration), forKey: url as NSURL)
                    durationDictionary[url.absoluteString] = duration
                    saveCacheToUserDefaults()
                }
                playerItemObserver?.playerItem(playerItem, didChangeDuration: duration)
            }
        }
    }

    weak var playerItemObserver: AVPlayerItemObserver?

    func playerItem(_ playerItem: AVPlayerItem, didChangeDuration duration: Double) {
        // Implement this method to handle duration changes outside the PlayerManager
    }

    private func loadCacheFromUserDefaults() {
        if let cachedDurations = UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: Double] {
            durationDictionary = cachedDurations
            for (key, value) in cachedDurations {
                if let url = URL(string: key) {
                    durationCache.setObject(NSNumber(value: value), forKey: url as NSURL)
                }
            }
        }
    }

    private func saveCacheToUserDefaults() {
        UserDefaults.standard.set(durationDictionary, forKey: userDefaultsKey)
    }
}




//import Foundation
//import AVFoundation
//
//protocol PlayerManagerDelegate: AnyObject {
//    func playbackTimeDidChange(currentTime: Double, duration: Double)
//}
//
//protocol AVPlayerItemObserver: AnyObject {
//    func playerItem(_ playerItem: AVPlayerItem, didChangeDuration duration: Double)
//}
//
//class PlayerManager: NSObject {
//    weak var delegate: PlayerManagerDelegate?
//    static let shared = PlayerManager()
//    private var timeObserver: Any?
//    var currentDuration: Double?
//    var minimumVolume: Float = 0.0
//    var durationCache = [URL: Double]()
//    var basePlayer: AVPlayer? {
//        didSet {
//            if let oldPlayer = oldValue {
//                removeObservers(from: oldPlayer)
//            }
//        }
//    }
//
//    deinit {
//        if let player = basePlayer {
//            removeObservers(from: player)
//        }
//    }
//
//    func adjustVolume(withMinimum volume: Float) {
//        let adjustedVolume = max(volume, minimumVolume)
//        basePlayer?.volume = adjustedVolume
//    }
//
//    func seekBackward(seconds: Double) {
//        if let player = basePlayer {
//            let currentTime = CMTimeGetSeconds(player.currentTime())
//            let newTime = max(currentTime - seconds, 0)
//            let timeToSeek = CMTimeMakeWithSeconds(newTime, preferredTimescale: 600)
//            player.seek(to: timeToSeek)
//        }
//    }
//
//    func seekForward(seconds: Double) {
//        if let player = basePlayer, let currentDuration = currentDuration {
//            let currentTime = CMTimeGetSeconds(player.currentTime())
//            let newTime = min(currentTime + seconds, currentDuration)
//            let timeToSeek = CMTimeMakeWithSeconds(newTime, preferredTimescale: 600)
//            player.seek(to: timeToSeek)
//        }
//    }
//
//    func playEpisode(url: URL) {
//        if let player = basePlayer {
//            player.pause()
//        }
//
//        if let cachedDuration = durationCache[url] {
//            currentDuration = cachedDuration
//            initializePlayer(with: url)
//        } else {
//            self.basePlayer = AVPlayer(url: url)
//            basePlayer?.play()
//            addObserverForDuration()
//        }
//    }
//
//    private func initializePlayer(with url: URL) {
//        self.basePlayer = AVPlayer(url: url)
//        basePlayer?.play()
//        timeObserver = basePlayer?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 600), queue: .main) { [weak self] time in
//            guard let self = self else { return }
//            let currentTime = CMTimeGetSeconds(time)
//            if let duration = self.currentDuration, !duration.isNaN {
//                self.updatePlaybackTime(currentTime: currentTime, duration: duration)
//            }
//        }
//    }
//
//    private func addObserverForDuration() {
//        if let playerItem = basePlayer?.currentItem {
//            playerItem.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
//        }
//    }
//
//    private func removeObservers(from player: AVPlayer) {
//        if let playerItem = player.currentItem {
//            playerItem.removeObserver(self, forKeyPath: "duration")
//        }
//        if let timeObserver = timeObserver {
//            player.removeTimeObserver(timeObserver)
//            self.timeObserver = nil
//        }
//    }
//
//    private func updatePlaybackTime(currentTime: Double, duration: Double) {
//        delegate?.playbackTimeDidChange(currentTime: currentTime, duration: duration)
//    }
//
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "duration", let playerItem = object as? AVPlayerItem {
//            let duration = CMTimeGetSeconds(playerItem.duration)
//            if !duration.isNaN {
//                currentDuration = duration
//                if let url = playerItem.asset as? AVURLAsset {
//                    durationCache[url.url] = duration
//                }
//                playerItemObserver?.playerItem(playerItem, didChangeDuration: duration)
//            }
//        }
//    }
//
//    weak var playerItemObserver: AVPlayerItemObserver?
//
//    func playerItem(_ playerItem: AVPlayerItem, didChangeDuration duration: Double) {
//        // Implement this method to handle duration changes outside the PlayerManager
//    }
//}
