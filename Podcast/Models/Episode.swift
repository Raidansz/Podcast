//
//  Episode.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 02. 11..
//

import FeedKit
import Foundation

struct Episode: Codable, Identifiable {
    var id: String
    
    let title: String
    let pubDate: Date
    let description: String
    let author: String
    let streamUrl: String

    var fileUrl: String?
    var imageUrl: String?

    init(feedItem: RSSFeedItem) {
        streamUrl = feedItem.enclosure?.attributes?.url ?? ""
        title = feedItem.title ?? ""
        pubDate = feedItem.pubDate ?? Date()
        description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
        author = feedItem.iTunes?.iTunesAuthor ?? ""
        imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
        id = feedItem.guid?.value ?? ""
    }
}
