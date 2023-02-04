//
//  HomeViewController.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 13..
//

import UIKit
import SwiftUI
enum Sections:Int{
    case Subscriptions = 0
    case YouMightLike = 1
    case Trending = 2
}
class HomeViewController: UIViewController {
    var feed:Feed?
    let sectionTitles : [String] = ["Subscriptions","You Might Like", "Trending"]

    
 
    
 let myView =  CollectionViewTableViewCell()
    private let homeFeedTable:UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.showsVerticalScrollIndicator = false
       
        return table
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        let swift = UIHostingController(rootView: SwiftUIView()).view
        swift?.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 650)
        homeFeedTable.tableHeaderView = swift
       
       
        
    }


}


extension HomeViewController: UITableViewDelegate,UITableViewDataSource,CollectionViewTableViewCellDelegate{
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell,viewModel: PosterPreviewViewModel, indexPath: IndexPath) {
        
        DispatchQueue.main.async { [weak self] in
            self?.feed = viewModel.feed
            let vc = EpisodesTableViewController()
            vc.podcast = self?.feed
            self?.navigationController?.pushViewController(vc, animated: true)
          //  self?.present(vc, animated: true)
          //  self?.performSegue(withIdentifier: Constants.takeMeToPodcast, sender: self)
            print("pressemd")
        }
    }
    
   
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if(segue.identifier == Constants.takeMeToPodcast){
              let vc = segue.destination as! EpisodesViewController
             
               vc.feed = feed
           }
       }

    
  
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case Sections.Subscriptions.rawValue:
            return 1
            
        case Sections.YouMightLike.rawValue:
            return 2
            
        case Sections.Trending.rawValue:
            return 2
            
        default:
            return 0
        }
       
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for:indexPath) as? CollectionViewTableViewCell else { return UITableViewCell()}
        cell.delegate = self
        switch indexPath.section{
        case Sections.Subscriptions.rawValue:
            APICaller.shared.getTrending { results in
                switch results{
                case .success(let result):
                    let twoDimArray = result.chunked(by: result.count/2)
                    if(indexPath.row == 0){
                        cell.configure(with: twoDimArray[0]) // first row
                    }else{
                        cell.configure(with: twoDimArray[1])              // second row
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
        case Sections.YouMightLike.rawValue:
            
            APICaller.shared.getTrending { results in
                switch results{
                case .success(let result):
                    let twoDimArray = result.chunked(by: result.count/2)
                    if(indexPath.row == 0){
                        cell.configure(with: twoDimArray[0]) // first row
                    }else{
                        cell.configure(with: twoDimArray[1])              // second row
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                
            }
        case Sections.Trending.rawValue:
            
            APICaller.shared.getTrending { results in
                switch results{
                case .success(let result):
                    let twoDimArray = result.chunked(by: result.count/2)
                    if(indexPath.row == 0){
                        cell.configure(with: twoDimArray[0]) // first row
                    }else{
                        cell.configure(with: twoDimArray[1])              // second row
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
                
                
            }
         
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
  
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
////                if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
////    changeTabBar(hidden: true, animated: true)
////            }
////               else{
////    changeTabBar(hidden: false, animated: true)
////              }
//   }
    
//    func changeTabBar(hidden:Bool, animated: Bool){
//        let tabBar = self.tabBarController?.tabBar
//        if tabBar!.isHidden == hidden{ return }
//        let frame = tabBar?.frame
//        let offset = (hidden ? (frame?.size.height)! : -(frame?.size.height)!)
//        let duration:TimeInterval = (animated ? 0.5 : 0.0)
//        tabBar?.isHidden = false
//        if frame != nil
//        {
//            UIView.animate(withDuration: duration,
//                animations: {tabBar!.frame = CGRectOffset(frame!, 0, offset)},
//                completion: {
//
//                if $0 {tabBar?.isHidden = hidden}
//            })
//        }
//    }
    
    

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return }
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.textColor = .white
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
    }
}

