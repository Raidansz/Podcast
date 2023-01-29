//
//  Array+Extensions.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 25..
//

import Foundation

extension Array {

    func chunked(by distance: Int) -> [[Element]] {
        precondition(distance > 0, "distance must be greater than 0") // prevents infinite loop

        if self.count <= distance {
            return [self]
        } else {
            let head = [Array(self[0 ..< distance])]
            let tail = Array(self[distance ..< self.count])
            return head + tail.chunked(by: distance)
        }
    }
    
    
    
}
