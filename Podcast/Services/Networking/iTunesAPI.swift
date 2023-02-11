//
//  iTunesAPI.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 02. 11..
//

import Foundation
import Moya

enum ITunesAPI {

    case search(term: String)
}

extension ITunesAPI: TargetType {

    var baseURL: URL {
        guard let url = URL(string: "https://itunes.apple.com/") else {
            fatalError("Error in base url: https://itunes.apple.com/")
        }
        return url
    }

    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }

    var method: Moya.Method {
        .get
    }

    var sampleData: Data {
        Data()
    }

    var task: Task {
        switch self {
        case let .search(term):
            let parameters = ["term": term.urlEscapedString, "media": "podcast"]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        ["Content-type": "application/json"]
    }
}
