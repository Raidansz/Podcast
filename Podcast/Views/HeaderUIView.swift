//
//  HeaderUIView.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 13..
//

import UIKit

class HeaderUIView: UIView {

    private let Imageview:UIImageView = {
        let imageView = UIImageView()
       
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "hero")
        return imageView
            
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Imageview.frame = bounds
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(Imageview)
    }
    required  init?(coder: NSCoder) {
        fatalError()
    }
}
