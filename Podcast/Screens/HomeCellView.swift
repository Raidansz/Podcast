//
//  HomeCellView.swift
//  Podcast
//
//  Created by Raidan on 30/07/2024.
//"https://picsum.photos/200/300"

import SwiftUI

struct HomeCellView: View {
    var podcast: Feed?
    var image: String?
    @State private var navigateToEpisodeList = false

    var isStandAloneCell: Bool
    var body: some View {
        ZStack {
            NavigationLink(destination: EpisodeListView(viewModel: EpisodeListViewModel(with: podcast?.url ?? "")), isActive: $navigateToEpisodeList) {
                EmptyView()
            }

            if isStandAloneCell {
                Button(action: {
                    navigateToEpisodeList = true
                }, label: {
                    AsyncImage(url: URL(string: image ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 331, height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 331, height: 200)
                                .clipped()
                                .cornerRadius(8)
                                .padding()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 331, height: 200)
                                .background(Color.gray)
                                .cornerRadius(8)
                                .padding()
                        @unknown default:
                            EmptyView()
                        }
                    }
                })
            } else {
                Button(action: {
                    // Add action for non-standalone cells if needed
                }, label: {
                    HStack {
                        AsyncImage(url: URL(string: image ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 108, height: 96)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 108, height: 96)
                                    .clipped()
                                    .cornerRadius(8)
                                    .padding()
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 108, height: 96)
                                    .background(Color.gray)
                                    .cornerRadius(8)
                                    .padding()
                            @unknown default:
                                EmptyView()
                            }
                        }

                        VStack(alignment: .leading) {
                            Text(podcast?.title ?? "Unknown Title")
                                .frame(alignment: .leading)
                                .frame(alignment: .leading)
                          
                        }
                        Spacer()
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                    }
                })
            }
        }
    }
}
