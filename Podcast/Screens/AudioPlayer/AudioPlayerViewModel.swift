//
//  AudioPlayerViewModel.swift
//  Podcast
//
//  Created by Raidan on 03/08/2024.
//

import Foundation
import AVKit

class AudioPlayerViewModel: ObservableObject {
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

        PlayerManager.shared.playEpisode(url: url)
        PlayerManager.shared.basePlayer?.play()
        isPlaying = true
        addPeriodicTimeObserver()
    }

    private func addPeriodicTimeObserver() {
      
        timeObserver = PlayerManager.shared.basePlayer?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: 600), queue: .main) { [weak self] time in
            self?.updateProgress(time: time)
        }
    }

    private func updateProgress(time: CMTime) {
        currentTime = CMTimeGetSeconds(time)
        totalTime = CMTimeGetSeconds(PlayerManager.shared.basePlayer?.currentItem?.duration ?? CMTime())
    }

    func playAudio() {
        PlayerManager.shared.basePlayer?.play()
        isPlaying = true
    }

    func pauseAudio() {
        PlayerManager.shared.basePlayer?.pause()
        isPlaying = false
    }

    func seekToTime(_ time: TimeInterval) {
        let newTime = CMTime(seconds: time, preferredTimescale: 600)
        PlayerManager.shared.basePlayer?.seek(to: newTime)
    }
}
