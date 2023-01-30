//
//  EpisodesTableViewController.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 30..
//

import UIKit

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell_Identifier)
        
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return XmlManager.shared.Episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell_Identifier, for: indexPath)
        cell.textLabel?.text = XmlManager.shared.Episodes[indexPath.row].titleText
        return cell
    }
}
