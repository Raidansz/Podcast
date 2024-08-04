//
//  EpisodeListView.swift
//  Podcast
//
//  Created by Raidan on 03/08/2024.
//
import SwiftUI

struct EpisodeListView: View {
    @StateObject var viewModel: EpisodeListViewModel
    @State private var shouldPlay = false
    @State private var selectedEpisode: Episode?

    var body: some View {
      //  NavigationView {
            VStack {
                if let imageUrl = selectedEpisode?.imageUrl {
                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .clipped()
                                .cornerRadius(8)
                                .padding()
                                .shadow(radius: 20)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .clipped()
                                .cornerRadius(8)
                                .padding()
                                .shadow(radius: 20)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                List(viewModel.episodes) { episode in
                    HomeCellView(image: episode.imageUrl, isStandAloneCell: false)
                        .onTapGesture {
                            self.selectedEpisode = episode
                            self.shouldPlay = true
                        }
                }
           // }
            .background(
                NavigationLink(destination: AudioPlayerView(viewModel: AudioPlayerViewModel(audioFile: selectedEpisode?.streamUrl ?? "")), isActive: $shouldPlay) {
                    EmptyView()
                }
            )
//            .navigationBarTitle("Episodes", displayMode: .inline)
//            .navigationBarBackButtonHidden()
        }
    }
}
