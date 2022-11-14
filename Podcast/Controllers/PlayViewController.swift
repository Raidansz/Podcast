//
//  PlayViewController.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2022. 11. 13..
//

import UIKit
import AVFoundation
import SDWebImage
class PlayViewController: UIViewController {
    var url:String = ""
    var poster:String = ""
    var player: AVPlayer?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(url)
        let sound = url
        if let url = URL(string: sound) {
            self.player = AVPlayer(url: url)
            
        }
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
     
    }
    
    func playSound(){
       
        player?.play()
        
    }
    
    
    
    
    
    @IBAction func play(_ sender: Any) {
        playSound()
    }
    
   
    @IBAction func pause(_ sender: Any) {
        player?.pause()
    }
    
}
