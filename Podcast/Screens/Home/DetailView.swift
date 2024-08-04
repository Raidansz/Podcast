//
//  DetailView.swift
//  Podcast
//
//  Created by Raidan on 04/08/2024.
//

import SwiftUI

struct DetailView: View {
    var podcast: Feed
    @Binding var showDetailView: Bool
    @Binding var detailPodcast: Feed?
    @State private var navigateToEpisodeList = false
    @Binding var currentCardSize: CGSize
    var animation: Namespace.ID
    @State var showDetailContent: Bool = false
    @State var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            NavigationLink(destination: EpisodeListView(viewModel: EpisodeListViewModel(with: podcast.url)), isActive: $navigateToEpisodeList) {
                EmptyView()
            }
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                AsyncImage(url: URL(string: podcast.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 331, height: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: currentCardSize.width, height: currentCardSize.height)
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: podcast.id, in: animation)
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
                VStack(spacing: 15) {
                    Text("Story Plot")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 25)
                    Text(podcast.description)
                        .multilineTextAlignment(.leading)
                    Button {
                        navigateToEpisodeList = true
                    } label: {
                        Text("Check it out!")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.blue)
                            }
                    }
                    .padding(.top, 20)
                }
                .opacity(showDetailContent ? 1 : 0)
                .offset(y: showDetailContent ? 0 : 200)
            }
            .padding()
            .modifier(OffsetModifier(offset: $offset))
        }
        .coordinateSpace(name: "SCROLL")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(.easeInOut) {
                showDetailContent = true
            }
        }
        .onChange(of: offset) { newValue in
            // YOUR OWN CUSTOM THERSOLD
            if newValue > 120 {
                withAnimation(.easeInOut) {
                    showDetailContent = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.easeInOut) {
                        showDetailView = false
                    }
                }
            }
        }
    }
}
}
