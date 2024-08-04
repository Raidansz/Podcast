//
//  HomeViewModel.swift
//  Podcast
//
//  Created by Raidan on 03/08/2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
 @Published var podcastList: [Feed] = []
    init() {
        APICaller.shared.getTrending { results in
            switch results {
            case .success(let result):
                DispatchQueue.main.async {
                    self.podcastList = result
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
