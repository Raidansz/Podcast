//
//  UiStackView+Extensions.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 25..
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }
    
    func removeArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { removeArrangedSubview($0) }
    }
}
