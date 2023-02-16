//
//  SearchResult.swift
//  Podcast
//
//  Created by Raidan on 2023. 02. 16..
//

import Foundation
// Raw output
struct Result:Codable {

    var count:Int
    var feeds:[Feed] // Podcasts
}

struct SearchResults:Decodable{
    let results:[Podcast]
}
