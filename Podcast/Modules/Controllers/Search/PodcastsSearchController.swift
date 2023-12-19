//
//  PodcastsSearchController.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 02. 12..
//
import Alamofire
import UIKit
import FeedKit
class PodcastsSearchController:UITableViewController{
    let searchController = UISearchController(searchResultsController: nil)
    var podcasts:[Podcast] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
       
    }
    
    func  setupTableView(){
        let nib = UINib(nibName: PodcastTableViewCell().identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        DispatchQueue.main.async { [weak self] in
 
            let vc = EpisodesTableViewController()
            vc.searchPodcast = self?.podcasts[indexPath.row]
           
            self?.navigationController?.pushViewController(vc, animated: true)
         
            
        }
    }
    
    func setupSearchBar(){
        
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Search"
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? PodcastTableViewCell
       
        cell?.podcast = podcasts[indexPath.row]
        return cell ?? UITableViewCell()
    }
     
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
   
}

extension PodcastsSearchController :UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchTerm = searchText.replacingOccurrences(of: " ", with: "+")
        
        let url = "https://itunes.apple.com/search?term=\(searchTerm)&entity=podcast"
        AF.request(url).responseData { (responseData) in
            if let error = responseData.error{
                print(error)
            }
            
            if let dataResponse = responseData.data{
                do{
                    let result =   try JSONDecoder().decode(SearchResults.self, from: dataResponse)
                    self.podcasts = result.results
                    self.tableView.reloadData()
                }catch{
                    print(error)
                }
            }
        }
   }
    
}
