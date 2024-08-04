//
//  Podcast.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2022. 11. 13..
//

import Foundation



 struct Podcast: Decodable {

    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
     var artworkUrl100: String?
    var trackCount: Int?
    var feedUrl: String?
}
