//
//  HeaderUIView.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 13..
//

import UIKit
import SwiftUI

class HeaderUIView: UIView {
    let swiftUIController = UIHostingController(rootView: SwiftUIView())
//    private let Imageview:UIImageView = {
//        let imageView = UIImageView()
//       
//        imageView.contentMode = .scaleToFill
//        imageView.clipsToBounds = true
//        imageView.image = UIImage(named: "hero")
//        return imageView
//            
//    }()
    
//        @IBSegueAction func swift(_ coder: NSCoder) -> UIViewController? {
//        return UIHostingController(coder: coder, rootView: SwiftUIView())
//    }
    
    func swift(_ coder: NSCoder) -> UIViewController? {
            return UIHostingController(coder: coder, rootView: SwiftUIView())
        }
        
        
    
    override func layoutSubviews() {
        super.layoutSubviews()
      // Imageview.frame = bounds
  
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
     //   addSubview(Imageview)
       
    }
    required  init?(coder: NSCoder) {
        fatalError()
    }
}
