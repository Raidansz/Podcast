//
//  RSSFeed+Extension.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 02. 11..
//

import FeedKit

extension RSSFeed {

    func toEpisodes() -> [Episode] {
        let imageUrl = iTunes?.iTunesImage?.attributes?.href

        var episodes = [Episode]()
        items?.forEach { feedItem in
            var episode = Episode(feedItem: feedItem)

            if episode.imageUrl == nil {
                episode.imageUrl = imageUrl
            }

            episodes.append(episode)
        }

        return episodes
    }
}
