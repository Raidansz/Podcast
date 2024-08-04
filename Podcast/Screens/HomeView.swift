//
//  HomeView.swift
//  Podcast
//
//  Created by Raidan on 30/07/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Home")
                    .bold()
                    .padding(.horizontal, 35)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.podcastList) { podcast in
                            HomeCellView(podcast: podcast, image: podcast.artwork, isStandAloneCell: true)
                        }
                    }
                    .padding()
                }

                HStack {
                    Text("Trending Podcasts")
                        .bold()
                        .padding(.trailing, 105)
                    Spacer()
                    Text("see more")
                }
                .padding(.horizontal, 35)

                List(viewModel.podcastList) { podcast in
                    HomeCellView(podcast: podcast, image: podcast.artwork, isStandAloneCell: false)
                }
                .listStyle(.plain)
            }
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
