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
    public static let API_base = "https://api.podcastindex.org/api/1.0/"
    public static let POD_Identifier = "GoTo"
    public static let cell_Identifier = "cell"
    public static let EPSO_Identifier = "EPS"
    public static let Play_Identifier = "play"
    public static var sharedImage = ""
    public static let apiKey = "9YARVVTCERVCNJQJDAAT"
        public static let apiSecret = "dr75yrNvyQQGw4afAYzG7x72n7#Fy3KcevhcXXrj"
    public static let Home_Cell = "Homecell"
   
}

enum APIError:Error{
    case failedToGetData
}


class APICaller{
    static let shared = APICaller()
    
//     var result = "test"
//     var feeds:[Feed]?
     
     
    
    func getTrending(completion: @escaping (Swift.Result<[Feed], Error>) -> Void){
      
        // prep for crypto
        let timeInSeconds: TimeInterval = Date().timeIntervalSince1970
        let apiHeaderTime = Int(timeInSeconds)
        let data4Hash = Constants.apiKey + Constants.apiSecret + "\(apiHeaderTime)"
        
        // ======== Hash them to get the Authorization token ========
        let inputData = Data(data4Hash.utf8)
        let hashed = Insecure.SHA1.hash(data: inputData)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        // ======== Send the request and collect/show the results ========
       let url = Constants.API_base + "podcasts/trending?max=20?lang=en"
      
        
        var request = URLRequest(url: URL(string:url)!)
        request.httpMethod = "GET"
        request.addValue( "\(apiHeaderTime)", forHTTPHeaderField: "X-Auth-Date")
        request.addValue( Constants.apiKey, forHTTPHeaderField: "X-Auth-Key")
        request.addValue( hashString, forHTTPHeaderField: "Authorization")
        request.addValue( "SuperPodcastPlayer/1.8", forHTTPHeaderField: "User-Agent")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, _, error -> Void in
           // print(data!)
            guard let data = data, error == nil else {
           
                return
            }
            do{
                let results = try JSONDecoder().decode(Result.self, from: data)
                completion(.success(results.feeds))
            }catch{
                completion(.failure(error))
            }

           
        }
        )
        task.resume()
        
    }
    
    
    
   

    }
    


