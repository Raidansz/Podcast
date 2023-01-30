//
//  EpisodesTableViewController.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 30..
//

import UIKit
import SDWebImage
class EpisodesTableViewController: UITableViewController {

    
    var podcast: Feed? {
        didSet{
            navigationItem.title = podcast?.title
            if let safeUrl = podcast?.url{
                fetchEpisode(with: safeUrl)
            }
            
           
        }
    }
    private func  fetchEpisode(with url:String){
        DispatchQueue.global(qos: .default).async{
            XmlManager.shared.doParse(path: url)

            DispatchQueue.main.async {
                self.tableView.reloadData()
       }
        }
        
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
        return XmlManager.shared.Episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell_Identifier, for: indexPath) as? EpisodeTableViewCell
       
        cell?.episode = XmlManager.shared.Episodes[indexPath.row]
        cell?.episodeImageView.sd_setImage(with: URL(string: self.podcast?.image ?? ""))
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = XmlManager.shared.Episodes[indexPath.row]
        let window = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first
        //UIApplication.shared.keyWindow
        let playerDetailsView = Bundle.main.loadNibNamed("PlayerDetailsView", owner: self)?.first as! PlayerDetailsView
        playerDetailsView.episode = episode
        playerDetailsView.episodeImage.sd_setImage(with: URL(string: self.podcast?.image ?? ""))
        playerDetailsView.frame = self.view.frame
        window?.addSubview(playerDetailsView)
        
    }
}
