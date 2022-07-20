//
//  GameListViewController.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 29.06.2022.
//

import UIKit

final class GameListViewController: UIViewController {

    static let identifier: String = "GameListViewController"
    
    var presenter: GameListPresenterInterface?
    
    @IBOutlet weak var gameListCollectionView: UICollectionView!
    @IBOutlet weak var platformFilterCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        DispatchQueue.main.async {
            self.gameListCollectionView.isHidden = true
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.gameListCollectionView.isHidden = false
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.gameListCollectionView.reloadData()
            self.platformFilterCollectionView.reloadData()
        }
        
    }
    
    func setupInitialView() {
        // col view cart curt
        gameListCollectionView.dataSource = self
        gameListCollectionView.delegate = self
        gameListCollectionView.register(UINib(nibName: "GameItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GameItemCell")
        gameListCollectionView.setCollectionViewLayout(createGameListCompositionalLayout(), animated: false)
        
        platformFilterCollectionView.dataSource = self
        platformFilterCollectionView.delegate = self
        platformFilterCollectionView.setCollectionViewLayout(createPlatformFilterCompositionalLayout(), animated: false)
        platformFilterCollectionView.register(UINib(nibName: "PlatformCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlatformCell")
     
    }
    
    func setScreenTitle(with title: String) {
        self.title = title
    }

}


extension GameListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == self.platformFilterCollectionView.tag {
            guard let platforms = presenter?.getPlatforms() else {
                return 0
            }
            
            return platforms.count
        }
        guard let gameModels = presenter?.getGameModels() else {
            return 0
        }
        return gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == self.platformFilterCollectionView.tag {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlatformCell", for: indexPath) as! PlatformCollectionViewCell
            let platform = presenter?.platformForItemAt(row: indexPath.row)
            cell.configure(name: platform?.name ?? "no data")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameItemCell", for: indexPath) as! GameItemCollectionViewCell
            let game = presenter?.cellForItemAt(row: indexPath.row)
            cell.configure(viewModel: game ?? Game(id: 0, name: "no data", released: "no data", metacritic: 0, description_raw: " "))
            return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == self.platformFilterCollectionView.tag {
            presenter?.didSelectPlatformAt(indexPath: indexPath)
            return
        }
        presenter?.didSelectRowAt(indexPath: indexPath)
    }

}


extension GameListViewController {
    func createGameListCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnv in
            
            switch sectionIndex {
            default:
                return self?.createGameListSection()
            }
            
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        
        return layout
    }
    
    func createPlatformFilterCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnv in
            
            switch sectionIndex {
            default:
                return self?.createPlatformsSection()
            }
            
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        
        return layout
    }
    func createGameListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.65))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 2
        

        
        return section
    }
    
    
    func createPlatformsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.46), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 2
        

        
        return section
    }
    
}
