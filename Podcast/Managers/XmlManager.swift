//
//  XmlManager.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 22..
//

import Foundation

class XmlManager:NSObject,XMLParserDelegate{

    static let shared = XmlManager()
    public var Episodes: [Episode] = []
   
    var elementName: String = String()
    var titleText:String = String()
    var enclosure:String = String()
    var url:String = ""
    var mp3URL:String = ""
 
    func doParse(path:String){
        
        if let path = URL(string: path) {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
    }
    
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
               // let episode = Episode(enclosure: enclosure,titleText:titleText)
              //  Episodes.append(episode)
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
            
                
            }

}
