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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell_Identifier, for: indexPath) as? PodcastTableViewCell
       
        cell?.podcast = podcasts[indexPath.row]
        return cell ?? UITableViewCell()
    }
     
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        cell.textLabel?.text = podcasts[index]
//        cell.imageView?.image = UIImage(systemName: "square.and.arrow.down.fill")
//        return cell
//    }
   
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
    
//    private func  fetchEpisode(with url:String){
//        DispatchQueue.global(qos: .default).async {
//                let parser = FeedParser(URL: URL(string: url)!)
//
//                parser.parseAsync { result in
//                    switch result {
//                    case let .success(feed):
//                        print("Successfully parse feed:", feed)
//                        guard let rssFeed = feed.rssFeed else { return }
//                        let episodes = rssFeed.toEpisodes()
//                        self.episodes = episodes
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//                    case let .failure(parserError):
//                        print("Failed to parse XML feed:", parserError)
//                    }
//                }
//            }
//        
//    }

    
    struct SearchResults:Decodable{
        let results:[Podcast]
    }
}
