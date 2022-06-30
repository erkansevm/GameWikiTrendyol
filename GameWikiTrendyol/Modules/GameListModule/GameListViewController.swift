//
//  GameListViewController.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 29.06.2022.
//

import UIKit

class GameListViewController: UIViewController {

    var presenter: GameListPresenterInterface?
    
    @IBOutlet weak var gameListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.notifyViewWillAppear()
    }

}

extension GameListViewController: GameListViewInterface {
    func showLoading() {
    }
    
    func hideLoading() {
        
    }
    
    func reloadData() {
        gameListCollectionView.reloadData()
    }
    
    func setupInitialView() {
        // col view cart curt
        gameListCollectionView.dataSource = self
        gameListCollectionView.delegate = self
    }
    
    func setScreenTitle(with title: String) {
        self.title = title
    }
    
    
}


extension GameListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let gameViewModels = presenter?.getGameViewModels() else {
            return 0
        }
        
        return gameViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        
        return UICollectionViewCell()
    }
    
    
}
