//
//  HomeView.swift
//  Podcast
//
//  Created by Raidan on 30/07/2024.
//

import SwiftUI

struct HomeView: View {
    // MARK: Animated View Properties
    @State var currentIndex: Int = 0
    @State var currentTab: String = "Podcasts"
    @StateObject var viewModel: HomeViewModel
    // MARK: Detail View Properties
    @State var detailPodcast: Feed?
    @State var showDetailView: Bool = false
    // FOR MATCHED GEOMETRY EFFECT STORING CURRENT CARD SIZE
    @State var currentCardSize: CGSize = .zero
    @Namespace var animation
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ZStack {
            // BG
            BGView()
            // MARK: Main View Content
            VStack {
                // Custom Nav Nar
                navBar()
                // Check out the Snap Carousel Video
                // Link in Description
                SnapCarousel(
                    spacing: 20,
                    trailingSpace: 110,
                    index: $currentIndex,
                    items: viewModel.podcastList
                ) { podcast in
                    GeometryReader { proxy in
                        let size = proxy.size
                        AsyncImage(url: URL(string: podcast.image)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 331, height: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: size.width, height: size.height)
                                    .cornerRadius(15)
                                    .matchedGeometryEffect(id: podcast.id, in: animation)
                                    .onTapGesture {
                                        currentCardSize = size
                                        detailPodcast = podcast
                                        withAnimation(.easeInOut) {
                                            showDetailView = true
                                        }
                                    }
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
                    }
                }
                // Since Carousel is Moved The current Card a little bit up
                // Using Padding to Avoid the Undercovering the top element
                .padding(.top, 70)
                // Custom Indicator
                customIndicator()
                HStack {
                    Text("Popular")
                        .font(.title3.bold())
                    Spacer()
                    Button("See More") {}
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(viewModel.podcastList) { movie in
                            AsyncImage(url: URL(string: movie.image))
                            //.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 120)
                                .cornerRadius(15)
                        }
                    }
                    .padding()
                }
            }
            .overlay {
                if let podcast = detailPodcast, showDetailView {
                    DetailView(
                        podcast: podcast,
                        showDetailView: $showDetailView,
                        detailPodcast: $detailPodcast,
                        currentCardSize: $currentCardSize,
                        animation: animation
                    )
                }
            }
        }
    }
    // MARK: Custom Indicator
    @ViewBuilder
    func customIndicator() -> some View {
        HStack(spacing: 5) {
            ForEach(viewModel.podcastList.indices, id: \.self) { index in
                Circle()
                    .fill(currentIndex == index ? .blue : .gray.opacity(0.5))
                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10 : 6)
            }
        }
        .animation(.easeInOut, value: currentIndex)
    }
    // MARK: Custom Nav Bar
    @ViewBuilder
    func navBar() -> some View {
        HStack(spacing: 0) {
            ForEach(["Podcasts", "Search"], id: \.self) { tab in
                Button {
                    withAnimation {
                        currentTab = tab
                    }
                } label: {
                    Text(tab)
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 20)
                        .background {
                            if currentTab == tab {
                                Capsule()
                                    .fill(.regularMaterial)
                                    .environment(\.colorScheme, .dark)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                }
            }
        }
        .padding()
    }
    // MARK: Blurred BG
    @ViewBuilder
    func BGView() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            TabView(selection: $currentIndex) {
                ForEach(viewModel.podcastList.indices, id: \.self) { index in
                    AsyncImage(url: URL(string: viewModel.podcastList[index].image))
                    // Image(viewModel.podcastList[index].artwork)
                    // .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            let color: Color = (scheme == .dark ? .black : .white)
            // Custom Gradient
            LinearGradient(colors: [
                .black,
                .clear,
                color.opacity(0.15),
                color.opacity(0.5),
                color.opacity(0.8),
                color,
                color
            ], startPoint: .top, endPoint: .bottom)
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}
