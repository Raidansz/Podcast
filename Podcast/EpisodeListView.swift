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
    }
}
