//
//  Feed.swift
//  Podcast
//
//  Created by Raidan on 2023. 02. 16..
//

import Foundation

// Actual array of podcasts
struct Feed: Codable, Identifiable{
    var title:String
    var id:Int
   var url:String
   var description:String
  var author:String
   var image:String
   var artwork:String
}
