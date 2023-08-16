//
//  EpisodesTableViewController.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 30..
//

import UIKit
import SDWebImage
import FeedKit
class EpisodesTableViewController: UITableViewController {
var episodes = [Episode]()
 
//    var mirror = Mirror(reflecting: self?.podcasts[indexPath.row])
    var podcast:Feed? {
        didSet{
            navigationItem.title = podcast?.title
            if let safeUrl = podcast?.url{
                fetchEpisode(with: safeUrl)
            }
            
           
        }
    }
    
    // if we jump from the search controller
    var searchPodcast:Podcast? {
        didSet{
           

            navigationItem.title = searchPodcast?.trackName
            
            if let safeUrl = searchPodcast?.feedUrl{
              fetchEpisode(with: safeUrl)
               
            }
            
            
           
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
      
        
    }
    
    
    
    
    
    func setupTableView(){
        let nib = UINib(nibName: EpisodeTableViewCell().identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.cell_Identifier)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell_Identifier, for: indexPath) as? EpisodeTableViewCell
       let episode = episodes[indexPath.row]
        cell?.episode = episode
        cell?.episodeImageView.sd_setImage(with: URL(string: episode.imageUrl ?? ""))
        return cell ?? UITableViewCell()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
          let defaultOffset = view.safeAreaInsets.top
          let offset = scrollView.contentOffset.y + defaultOffset
  
          navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
      }
        
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        let window = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first
        //UIApplication.shared.keyWindow
        let playerDetailsView = Bundle.main.loadNibNamed("PlayerDetailsView", owner: self)?.first as! PlayerDetailsView
        playerDetailsView.episode = episode
        playerDetailsView.episodeImage.sd_setImage(with: URL(string: self.podcast?.image ?? self.searchPodcast?.artworkUrl600 ?? ""))
        playerDetailsView.frame = self.view.frame
        window?.addSubview(playerDetailsView)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
               appDelegate.playerDetailsViewREF = playerDetailsView 
    }
}

extension EpisodesTableViewController{
    
    private func  fetchEpisode(with url:String){
        DispatchQueue.global(qos: .default).async {
            let parser = FeedParser(URL: URL(string: url)!)
            
            parser.parseAsync { result in
                switch result {
                case let .success(feed):
                    print("Successfully parse feed:", feed)
                    guard let rssFeed = feed.rssFeed else { return }
                    
                    let episodes = rssFeed.toEpisodes()
                    self.episodes = episodes
                    print("the url for the image is \(episodes.first?.imageUrl)")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case let .failure(parserError):
                    print("Failed to parse XML feed:", parserError)
                }
            }
        }
        
        
    }}
