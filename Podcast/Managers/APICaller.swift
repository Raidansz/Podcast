//
//  Constants.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2022. 11. 13..
//

import Foundation
import CryptoKit



struct Constants{
    //public static let API_base = "https://api.podcastindex.org/api/1.0/search/byterm?q="
    public static let aPIbase = "https://api.podcastindex.org/api/1.0/"
    public static let pODIdentifier = "GoTo"
    public static let cellIdentifier = "cell"
    public static let ePSOIdentifier = "EPS"
    public static let playIdentifier = "play"
    public static var sharedImage = ""
    public static let apiKey = "9YARVVTCERVCNJQJDAAT"
        public static let apiSecret = "dr75yrNvyQQGw4afAYzG7x72n7#Fy3KcevhcXXrj"
    public static let homeCell = "Homecell"
    public static let takeMeToPodcast =  "takeMeToPodcast"
}



enum APIError:Error{
    case failedToGetData
}



class APICaller{
    static let shared = APICaller()
    
    func getTrending(completion: @escaping (Swift.Result<[Feed], Error>) -> Void) {
        // Prep for crypto
        let apiHeaderTime = Int(Date().timeIntervalSince1970)
        let data4Hash = Constants.apiKey + Constants.apiSecret + "\(apiHeaderTime)"
        
        // Hash them to get the Authorization token
        let inputData = Data(data4Hash.utf8)
        let hashed = Insecure.SHA1.hash(data: inputData)
        let hashString = hashed.map { String(format: "%02x", $0) }.joined()
        
        // Construct URL
        let urlString = Constants.aPIbase + "podcasts/trending?max=20&lang=en"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        // Configure URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("\(apiHeaderTime)", forHTTPHeaderField: "X-Auth-Date")
        request.addValue(Constants.apiKey, forHTTPHeaderField: "X-Auth-Key")
        request.addValue(hashString, forHTTPHeaderField: "Authorization")
        request.addValue("SuperPodcastPlayer/1.8", forHTTPHeaderField: "User-Agent")
        
        // Perform network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(Result.self, from: data)
                completion(.success(results.feeds))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }

    
    
    
   

    }
    


