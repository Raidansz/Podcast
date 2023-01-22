//
//  ViewController.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2022. 11. 13..
//

import UIKit
import CryptoKit

class ViewController: UIViewController {
   
    var result = "test"
 //   var podcasts:?
    
    

    
    
    
    
    @IBOutlet weak var toBeLookedFor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constants.POD_Identifier){
          
          //  let vc = segue.destination as! PodcastsTableViewController
            
         //   vc.podcasts = podcasts?.feeds
        }
        
    }
    
//    func performRequest(query:String){
//
//
//        // prep for crypto
//        let timeInSeconds: TimeInterval = Date().timeIntervalSince1970
//        let apiHeaderTime = Int(timeInSeconds)
//        let data4Hash = Constants.apiKey + Constants.apiSecret + "\(apiHeaderTime)"
//
//        // ======== Hash them to get the Authorization token ========
//        let inputData = Data(data4Hash.utf8)
//        let hashed = Insecure.SHA1.hash(data: inputData)
//        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
//        // ======== Send the request and collect/show the results ========
//
//        let url = Constants.API_base + query
//        var request = URLRequest(url: URL(string:url)!)
//        request.httpMethod = "GET"
//        request.addValue( "\(apiHeaderTime)", forHTTPHeaderField: "X-Auth-Date")
//        request.addValue( Constants.apiKey, forHTTPHeaderField: "X-Auth-Key")
//        request.addValue( hashString, forHTTPHeaderField: "Authorization")
//        request.addValue( "SuperPodcastPlayer/1.8", forHTTPHeaderField: "User-Agent")
//        let session = URLSession.shared
//        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            if(error != nil){
//                print(error!)
//            }
//
//        //    if let safeData = data{
//              //  self.parseJson(data: safeData)
//            }
//
//
//       // })
//        task.resume()
//
//    }
    
    
    
//    func parseJson(data:Data){
//
//        let parser = JSONDecoder()
//        do{
////            let result = try parser.decode(Podcast.self, from: data)
////            self.podcasts = result
//
//            print("Successfull!!")
//            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: Constants.POD_Identifier, sender: self)
//            }
//
//        }catch{
//            print(error)
//        }
//
//
//
//
//
//
//    }
    
//    @IBAction func searchPressed(_ sender: Any) {
//      //  if let query =  toBeLookedFor.text    {
//           // let suitable = query.replacingOccurrences(of: " ", with: "+")
//          //  self.performRequest(query: suitable)
//
//        }else {return}
//
//    }
//
}
