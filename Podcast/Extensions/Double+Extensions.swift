//
//  Double+Extensions.swift
//  Podcast
//
//  Created by Raidan on 2023. 09. 05..
//

import Foundation

extension Double{
    // Helper method to format time in HH:MM:SS format
    func formatTime() -> String {
        let time = self
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60

        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return String(format: "00:%02d", seconds)
        }
    }

    
    
}

