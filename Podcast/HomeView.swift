//
//  HomeView.swift
//  Podcast
//
//  Created by Raidan on 30/07/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        NavigationStack {
            HStack(content: {
                Text("Promoted Podcasts")
                    .bold()
                    .frame(alignment: .leading)
                    .padding(.horizontal, 35)
                Spacer()
            })
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.podcastList) { podcast in
                        HomeCellView(podcast: podcast , image: podcast.artwork , isStandAloneCell: true)
                    }
                    .listStyle(.plain)
                    
                }
                .padding()
            }
            HStack(content: {
                Text("Trending Podcasts")
                    .bold()
                    .frame(alignment: .leading)
                    .padding(.trailing, 105)
                Text("see more")
                
            })
            List(viewModel.podcastList) { podcast in
                HomeCellView(podcast:podcast, image: podcast.artwork, isStandAloneCell: false)
            }
            .listStyle(.plain)
            
            
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
