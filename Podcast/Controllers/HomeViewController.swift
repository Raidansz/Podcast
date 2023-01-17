//
//  HomeViewController.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 13..
//

import UIKit
enum Sections:Int{
    case YouMightLike = 0
    case Trending = 1
}
class HomeViewController: UIViewController {

    let sectionTitles : [String] = ["You Might Like", "Trending"]
    
    
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

        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        homeFeedTable.tableHeaderView = HeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 750))
       
      
    }
    
//    func getTrendingPodcasts(){
//        APICaller.shared.getTrending { results in
//            switch results{
//            case .success(let podcasts):
//
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    

}


extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for:indexPath) as? CollectionViewTableViewCell else { return UITableViewCell()}
        
        switch indexPath.section{
        case Sections.YouMightLike.rawValue:
            
            
            APICaller.shared.getTrending { results in
                switch results{
                case .success(let result):
                    print("nothing")
                    
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
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return }
        header.textLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
    }
}

