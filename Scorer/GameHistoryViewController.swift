//
//  GameHistoryViewController.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/12/28.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit
import RealmSwift

class GameHistoryViewController: UIViewController {

    var searchResults: [String] = []
    var gameHistoryCollectionView: UICollectionView!
//    var searchController = UISearchController()
    
    var games: Results<Game>?
    
    let realm = try! Realm()
    
    struct Cell {
        static let GameHistoryCell = "gameHistorCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        gameHistoryCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        gameHistoryCollectionView.collectionViewLayout = layout
        
        gameHistoryCollectionView.register(GameHistoryTableViewCell.self, forCellWithReuseIdentifier: Cell.GameHistoryCell)
        
        gameHistoryCollectionView.dataSource = self
        gameHistoryCollectionView.delegate = self
        
        self.view.addSubview(gameHistoryCollectionView)

//        searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.sizeToFit()
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.hidesNavigationBarDuringPresentation = false
//
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.title = "setting_game_history".localized
//        self.navigationItem.searchController = searchController
        
        self.games = realm.objects(Game.self).sorted(byKeyPath: "updatedAt", ascending: false)
        
        if self.games?.count == 0 {
            AlertDialog.showSimpleAlertDialog(title: "game_result_zero".localized, viewController: self)
        }
    }

    @objc func done(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - ColletionView Delegate, Datasource
extension GameHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell: GameHistoryTableViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.GameHistoryCell, for: indexPath) as? GameHistoryTableViewCell {
            
            if let game = games?[indexPath.row] {
                cell.game = game
            }
            
            return cell
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let game = self.games?[indexPath.row] {
            
            if let selectedGame = realm.objects(Game.self).filter("updatedAt == %@", game.updatedAt!).first {
                
                let topVC = self.gameHistoryCollectionView.topViewController()
                AlertDialog.showGameResultDeleteAlertDialog(viewController: topVC ?? GameHistoryViewController(), game: selectedGame, collectionView: collectionView)
                
                
            }
        }
    }
}
