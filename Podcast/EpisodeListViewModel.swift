//
//  EpisodeListViewModel.swift
//  Podcast
//
//  Created by Raidan on 03/08/2024.
//

import Foundation
import FeedKit

final class EpisodeListViewModel: ObservableObject {
    @Published var episodes = [Episode]()
    init(with url: String) {
        fetchEpisode(with: url)
    }
    private func  fetchEpisode(with url: String){
        DispatchQueue.global(qos: .default).async {
            let parser = FeedParser(URL: URL(string: url)!)
            parser.parseAsync { result in
                switch result {
                case let .success(feed):
                    print("Successfully parse feed:", feed)
                    guard let rssFeed = feed.rssFeed else { return }
                    let episodes = rssFeed.toEpisodes()
                    self.episodes = episodes
                    print("the url for the image is \(String(describing: episodes.first?.imageUrl))")
                case let .failure(parserError):
                    print("Failed to parse XML feed:", parserError)
                }
            }
        }
    }
}
