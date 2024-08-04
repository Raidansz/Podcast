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
    
    private func fetchEpisode(with url: String) {
        Task {
            do {
                let episodes = try await parseFeed(url: url)
                await updateEpisodes(episodes: episodes)
            } catch {
                print("Failed to parse XML feed: \(error.localizedDescription)")
            }
        }
    }
    
    private func parseFeed(url: String) async throws -> [Episode] {
        return try await withCheckedThrowingContinuation { continuation in
            let parser = FeedParser(URL: URL(string: url)!)
            parser.parseAsync { result in
                switch result {
                case let .success(feed):
                    guard let rssFeed = feed.rssFeed else {
                        continuation.resume(returning: [])
                        return
                    }
                    let episodes = rssFeed.toEpisodes()
                    continuation.resume(returning: episodes)
                case let .failure(parserError):
                    continuation.resume(throwing: parserError)
                }
            }
        }
    }
    
    @MainActor
    private func updateEpisodes(episodes: [Episode]) {
        self.episodes = episodes
        print("The URL for the image is \(String(describing: episodes.first?.imageUrl))")
    }
}


//final class EpisodeListViewModel: ObservableObject {
//    @Published var episodes = [Episode]()
//    init(with url: String) {
//        fetchEpisode(with: url)
//    }
//    private func  fetchEpisode(with url: String){
//        DispatchQueue.global(qos: .default).async {
//            let parser = FeedParser(URL: URL(string: url)!)
//            parser.parseAsync { result in
//                switch result {
//                case let .success(feed):
//                    print("Successfully parse feed:", feed)
//                    guard let rssFeed = feed.rssFeed else { return }
//                    let episodes = rssFeed.toEpisodes()
//                    self.episodes = episodes
//                    print("the url for the image is \(String(describing: episodes.first?.imageUrl))")
//                case let .failure(parserError):
//                    print("Failed to parse XML feed:", parserError)
//                }
//            }
//        }
//    }
//}
