//
//  UILabel+Extensions.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 25..
//

import Foundation
import UIKit


extension UILabel {
    func configureWith(_ text: String,
                       color: UIColor,
                       alignment: NSTextAlignment,
                       size: CGFloat,
                       weight: UIFont.Weight = .regular) {
        self.font = .systemFont(ofSize: size, weight: weight)
        self.text = text
        self.textColor = color
        self.textAlignment = alignment
    }
}
