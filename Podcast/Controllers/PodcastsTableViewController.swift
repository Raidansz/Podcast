//
//  PodcastsTableViewController.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2022. 11. 13..
//

import UIKit

class PodcastsTableViewController: UITableViewController {
    var podcasts:[Feed]?
    var url:String = ""
    var poster:String = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell_Identifier, for: indexPath)
       
        if let safePocast = podcasts{
         //   let title = safePocast[indexPath.row].title
         //   cell.textLabel?.text = title
          
            
        }
        
        
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        url = podcasts![indexPath.row].url
//       poster = podcasts![indexPath.row].image
        performSegue(withIdentifier: Constants.EPSO_Identifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.EPSO_Identifier){
            let vc = segue.destination as! EpisodesViewController
            vc.url = url
            vc.posterImage = poster
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts?.count ?? 0
    }
}
