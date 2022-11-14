//
//  EpisodesViewController.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2022. 11. 13..
//

import UIKit

class EpisodesViewController: UIViewController {
    public var Episodes: [Episode] = []
    var toBePassedString:String = String()
    var elementName: String = String()
    var titleText:String = String()
    var enclosure:String = String()
    var posterImage:String = String()
    var tappedPod:String = String()
    var url:String = ""
    var mp3URL:String = ""
 
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell_Identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.global(qos: .default).async{
            
            if let path = URL(string: self.url) {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
               }
        }
                   

            
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        poster.sd_setImage(with: URL(string: posterImage))
    }

}





    
    
    
    extension EpisodesViewController:XMLParserDelegate{
        
        // 1
        func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            
            if elementName == "item" {
                titleText = String()
                enclosure = String()
                
            }
            
    
            if elementName == "enclosure"{
                if attributeDict["url"] != nil{
                    let PSIValue = attributeDict["url"]! as String
                    self.mp3URL = PSIValue
                    
                   
                }}

          
                
                
                
                self.elementName = elementName
            }
            
            
            
            
            
            // 2
            func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
                if elementName == "item" {
                    let episode = Episode(enclosure: enclosure,titleText:titleText)
                    Episodes.append(episode)
                }
            }
            
            // 3
            func parser(_ parser: XMLParser, foundCharacters string: String) {
                
                let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                
                
                if(self.elementName == "title"){
                    if (!data.isEmpty) {
                        
                        titleText += data
                       
                       
                    }
                    }
                
                
                if(self.elementName == "enclosure"){
                   
                   
                       
                        enclosure += mp3URL
                       
                    
                    }
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                   
                    
                }
                
                
                
                
                
            }
            
            
            
            

extension EpisodesViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
          tappedPod = Episodes[indexPath.row].enclosure
        performSegue(withIdentifier: Constants.Play_Identifier, sender: self)
        
    }
    
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.Play_Identifier){
            let vc = segue.destination as! PlayViewController
            vc.url = self.tappedPod
           
        }
    }
    
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Episodes.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell_Identifier, for: indexPath)
        cell.textLabel?.text = Episodes[indexPath.row].titleText
        return cell
    }
    
}
    
    
    

