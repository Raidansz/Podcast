//
//  EpisodeListView.swift
//  Podcast
//
//  Created by Raidan on 03/08/2024.
//

import SwiftUI

struct EpisodeListView: View {
    @StateObject var viewModel: EpisodeListViewModel
    var body: some View {
//        List {
            Section {
                List(viewModel.episodes){ episode in
                    HomeCellView(image: episode.imageUrl, isStandAloneCell: false)
                }
            } header: {
                AsyncImage(url: URL(string: "https://picsum.photos/200/300")!) { image in
                    image
                        .resizable()
                        .clipped()
                        .cornerRadius(8)
                        .padding()
                        .shadow(radius: 20)
                } placeholder: {
                    ProgressView()
                }
            }
//        }
//        .listStyle(.plain)
    }
    
//    private func  fetchEpisode(with url:String){
//        DispatchQueue.global(qos: .default).async {
//            let parser = FeedParser(URL: URL(string: url)!)
//            
//            parser.parseAsync { result in
//                switch result {
//                case let .success(feed):
//                    print("Successfully parse feed:", feed)
//                    guard let rssFeed = feed.rssFeed else { return }
//                    
//                    let episodes = rssFeed.toEpisodes()
//                    self.episodes = episodes
//                    print("the url for the image is \(String(describing: episodes.first?.imageUrl))")
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                case let .failure(parserError):
//                    print("Failed to parse XML feed:", parserError)
//                }
//            }
//        }
//        
//        
//    }
}

//#Preview {
//    EpisodeListView()
//}
