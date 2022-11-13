//
//  Podcast.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2022. 11. 13..
//

import Foundation


struct Podcast:Codable {
    
    
    
var status:String
    var count:Int
    var query:String
    var description:String
 
    var feeds:[Feed]
   

}


