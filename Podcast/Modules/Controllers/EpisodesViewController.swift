////
////  EpisodesViewController.swift
////  Podcast
////
////  Created by Raidan Shugaa Addin on 2022. 11. 13..
////
//
import UIKit

class EpisodesViewController: UIViewController {
    var feed :Feed?
    var posterImage:String = String()
    var tappedPod:String = String()
    var url:String = ""


    @IBOutlet weak var poster: UIImageView!

    @IBOutlet weak var podcastTitle: UILabel!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let safeFeed = feed{
            url = safeFeed.url
            posterImage = safeFeed.image

        }

//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell_Identifier)
//        tableView.delegate = self
//        tableView.dataSource = self

        DispatchQueue.global(qos: .default).async{
            XmlManager.shared.doParse(path: self.url)

            DispatchQueue.main.async {
                               //self.tableView.reloadData()
                           }
        }



    }



    func configure(with feed:Feed){
        self.feed = feed
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //poster.sd_setImage(with: URL(string: posterImage))
        if let safefeed = feed{
            podcastTitle.text = safefeed.title
        }

      //  poster.layer.cornerRadius = 20
        //poster.layer.masksToBounds = true
    }

}


extension EpisodesViewController:UITableViewDelegate,UITableViewDataSource{



     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

          tappedPod = XmlManager.shared.Episodes[indexPath.row].enclosure
        performSegue(withIdentifier: Constants.Play_Identifier, sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.Play_Identifier){
            let vc = segue.destination as! PlayViewController
            Constants.sharedImage = self.posterImage
            vc.url = self.tappedPod

        }
    }


     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return XmlManager.shared.Episodes.count
    }


     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell_Identifier, for: indexPath)
        cell.textLabel?.text = XmlManager.shared.Episodes[indexPath.row].titleText
        return cell

    }

}





