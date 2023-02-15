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
    
    private func  fetchEpisode(with url:String){
        DispatchQueue.global(qos: .default).async {
                let parser = FeedParser(URL: URL(string: url)!)

                parser.parseAsync { result in
                    switch result {
                    case let .success(feed):
                        print("Successfully parse feed:", feed)
                        guard let rssFeed = feed.rssFeed else { return }
                        print("Heelooo raidan")
                        let episodes = rssFeed.toEpisodes()
                        self.episodes = episodes
                       
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    case let .failure(parserError):
                        print("Failed to parse XML feed:", parserError)
                    }
                }
            }
        
        
      //  let parser = FeedParser(URL: URL(string: url )!)
//        parser.parseAsync(queue: DispatchQueue.global(qos: .default)) { (result) in
//            switch result {
//            case .success(let feed):
//
//                // Grab the parsed feed directly as an optional rss, atom or json feed object
//
//
//                // Or alternatively...
//                switch feed {
//                case .atom(_):
//                    break       // Atom Syndication Format Feed Model
//                case let .rss(feed):
//                    feed.items?.forEach({ (epi) in
//
//                        let episode = Episode(enclosure:epi.enclosure?.attributes?.url ?? "" , title: epi.title ?? "", pubDate: epi.pubDate ?? Date(), description: epi.description ?? "")
//                        self.episodes.append(episode)
//
//                    })
//
//                    break        // Really Simple Syndication Feed Model
//                case .json(_):
//                    break       // JSON Feed Model
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
        
//        DispatchQueue.global(qos: .default).async{
//            XmlManager.shared.doParse(path: url)
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//       }
//        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
       
        cell?.episode = episodes[indexPath.row]
        cell?.episodeImageView.sd_setImage(with: URL(string: self.podcast?.image ?? ""))
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
        
    }
}
