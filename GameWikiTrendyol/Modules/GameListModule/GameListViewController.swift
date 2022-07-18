//
//  GameListViewController.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 29.06.2022.
//

import UIKit

class GameListViewController: UIViewController {

    static let identifier: String = "GameListViewController"
    
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
        DispatchQueue.main.async {
            self.gameListCollectionView.reloadData()
        }
    }
    
    func setupInitialView() {
        // col view cart curt
        gameListCollectionView.dataSource = self
        gameListCollectionView.delegate = self
        gameListCollectionView.register(UINib(nibName: "GameItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GameItemCell")
        gameListCollectionView.setCollectionViewLayout(createCompositionalLayout(), animated: false)
    }
    
    func setScreenTitle(with title: String) {
        self.title = title
    }

}


extension GameListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let gameModels = presenter?.getGameModels() else {
            return 0
        }
        
        return gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameItemCell", for: indexPath) as! GameItemCollectionViewCell
        let game = presenter?.cellForItemAt(row: indexPath.row)
        cell.configure(viewModel: game ?? Game(id: 0, name: "no data", released: "no data", metacritic: 0, description_raw: " "))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath: indexPath)
    }
    
}


extension GameListViewController {
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnv in
            
            switch sectionIndex {
                
            default:
                return self?.createSection()
            }
            
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 2
        layout.configuration = config
        
        return layout
    }
    func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.65))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 2
        

        
        return section
    }
}
