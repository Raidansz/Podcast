//
//  ViewController.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2022. 11. 13..
//

import UIKit

class ViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let item: CustomTabBarItem
    
    init(item: CustomTabBarItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupProperties()
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
    
    private func setupHierarchy() {
        view.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setupProperties() {
        titleLabel.configureWith(item.name, color: .black, alignment: .center, size: 28, weight: .bold)
        view.backgroundColor = .white
    }
}
