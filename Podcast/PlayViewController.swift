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
    var poster:String = "https://engineered.network/img/sleep/defaultEpisodeImage.jpg"
    var player: AVPlayer?
    
    @IBOutlet weak var posterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        posterImage.sd_setImage(with: URL(string: poster),completed: nil)
        print(poster)
    }
    
    func playSound(){
        let sound = url
        if let url = URL(string: sound) {
            self.player = AVPlayer(url: url)
        }
        player?.play()
        
    }
    
    
    
    
    
    @IBAction func play(_ sender: Any) {
        playSound()
    }
    
   
    @IBAction func pause(_ sender: Any) {
        player?.pause()
    }
    
}
