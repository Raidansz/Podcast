//
//  String+Extensions.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 30..
//

import Foundation

extension String {

    var httpsUrlString: String {
        contains("https") ? self : replacingOccurrences(of: "http", with: "https")
    }

    var urlEscapedString: String {
        // swiftlint:disable:next force_unwrapping
        addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
    
    func replaceSpacesWithPlus(line:String) -> String{
        return line.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
    }
}
