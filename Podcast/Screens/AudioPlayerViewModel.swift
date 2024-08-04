//
//  AudioPlayerViewModel.swift
//  Podcast
//
//  Created by Raidan on 03/08/2024.
//

import Foundation
import AVKit

class AudioPlayerViewModel: ObservableObject {
    @Published var player: AVPlayer?
    @Published var isPlaying = false
    @Published var totalTime: TimeInterval = 0.0
    @Published var currentTime: TimeInterval = 0.0

    private var timeObserver: Any?

    init(audioFile: String) {
        setupAudio(with: audioFile)
    }

    private func setupAudio(with audioFile: String) {
        guard let url = URL(string: audioFile) else {
            print("Invalid URL for audio file")
            return
        }
        player = AVPlayer(url: url)
        player?.play()
        isPlaying = true
        addPeriodicTimeObserver()
    }

    private func addPeriodicTimeObserver() {
        guard let player = player else { return }
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: 600), queue: .main) { [weak self] time in
            self?.updateProgress(time: time)
        }
    }

    private func updateProgress(time: CMTime) {
        guard let player = player else { return }
        currentTime = CMTimeGetSeconds(time)
        totalTime = CMTimeGetSeconds(player.currentItem?.duration ?? CMTime())
    }

    func playAudio() {
        player?.play()
        isPlaying = true
    }

    func pauseAudio() {
        player?.pause()
        isPlaying = false
    }

    func seekToTime(_ time: TimeInterval) {
        let newTime = CMTime(seconds: time, preferredTimescale: 600)
        player?.seek(to: newTime)
    }
}
