//
//  CollectionViewTableViewCell.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 13..
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject{
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell,viewModel:PosterPreviewViewModel,indexPath: IndexPath)
}


class CollectionViewTableViewCell: UITableViewCell {
     var delegate:CollectionViewTableViewCellDelegate?
    
    
    static let identifier = "CollectionViewTableViewCell"
    private var feeds:[Feed] = [Feed]()
    
    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout )
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       // contentView.backgroundColor = .blue
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    public func configure(with feeds: [Feed]){
        self.feeds = feeds
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

extension CollectionViewTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
   
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
            collectionView.deselectItem(at: indexPath, animated: true)
        let feed = feeds[indexPath.row]
       
        let viewModel = PosterPreviewViewModel(feed: feed)
       self.delegate?.collectionViewTableViewCellDidTapCell(self, viewModel: viewModel, indexPath: indexPath)
        
       
            }
        
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {return UICollectionViewCell()}
        
        cell.configure(with: feeds[indexPath.row].image)
        
        cell.contentView.layer.cornerRadius = 40
        cell.contentView.layer.masksToBounds = true
    
        return cell
    }
    
    
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return feeds.count
    }
    
}
