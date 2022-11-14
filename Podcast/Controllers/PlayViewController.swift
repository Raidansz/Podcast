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
    var status: Bool = false

    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var image: UIImageView!
    
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
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.sd_setImage(with: URL(string: Constants.sharedImage))
        print(Constants.sharedImage)
    }
    
    func playSound(){
       
        player?.play()
        
    }
    
    
    
    
    
    @IBAction func play(_ sender: Any) {
       
        if(status == false){
            playSound()
            
            let image = UIImage(systemName: "pause.circle.fill" ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 45))
            btnImage.setImage(image, for: .normal)
            status = !status
            
        }else{
            let image = UIImage(systemName: "play.circle.fill" ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 45))
            btnImage.setImage(image, for: .normal)
            player?.pause()
            
            status = !status
        }
       
        
        
        
    }
    
   
    
}
