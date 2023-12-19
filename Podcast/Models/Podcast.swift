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

//    func encode(with aCoder: NSCoder) {
//        print("Trying to transform Podcast into Data")
//        aCoder.encode(trackName ?? "", forKey: Keys.trackNameKey)
//        aCoder.encode(artistName ?? "", forKey: Keys.artistNameKey)
//        aCoder.encode(artworkUrl600 ?? "", forKey: Keys.artworkKey)
//        aCoder.encode(feedUrlSting ?? "", forKey: Keys.feedKey)
//    }
//
//    init?(coder aDecoder: NSCoder) {
//        print("Trying to turn Data into Podcast")
//        trackName = aDecoder.decodeObject(forKey: Keys.) as? String
//        artistName = aDecoder.decodeObject(forKey: Keys.artistNameKey) as? String
//        artworkUrl600 = aDecoder.decodeObject(forKey: Keys.artworkKey) as? String
//        feedUrlSting = aDecoder.decodeObject(forKey: Keys.feedKey) as? String
//    }
     
}
