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
    @IBOutlet weak var searchBar: UISearchBar!
    let refreshControl = UIRefreshControl()
    let noResultLabel = UILabel()
    
    @IBOutlet weak var bottomLoading: UIActivityIndicatorView!
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
    func bottomLoadingState(shouldShow: Bool) {
        if shouldShow {
            bottomLoading.startAnimating()
            bottomLoading.isHidden = false
        } else {
            bottomLoading.stopAnimating()
            bottomLoading.isHidden = true
        }
    }
    
    func showNoResult() {
        noResultLabel.isHidden = false
        gameListCollectionView.isHidden = true
    }
    
    func showLoading() {
        gameListCollectionView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        gameListCollectionView.isHidden = false
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func reloadGameListData() {
        gameListCollectionView.reloadData()
        gameListCollectionView.isHidden = false
        noResultLabel.isHidden = true
    }
    
    func reloadPlatformData() {
        platformFilterCollectionView.reloadData()
    }
    
    func setupInitialView() {
        // col view cart curt
        setGameListCollection()
        setPlatformListCollection()
        searchBar.delegate = self
        setNoResultLabel()
        setRefreshControl()
        bottomLoading.isHidden = true
    }
    
    @objc func refresh(_ sender: Any){
        presenter?.notifyFetchNext()
        refreshControl.endRefreshing()
    }
    
    func setScreenTitle(with title: String) {
        self.title = title
    }
    
    private func setGameListCollection(){
        gameListCollectionView.dataSource = self
        gameListCollectionView.delegate = self
        gameListCollectionView.register(UINib(nibName: "GameItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GameItemCell")
        gameListCollectionView.setCollectionViewLayout(createGameListCompositionalLayout(), animated: false)        
    }
    
    private func setPlatformListCollection(){
        platformFilterCollectionView.dataSource = self
        platformFilterCollectionView.delegate = self
        platformFilterCollectionView.setCollectionViewLayout(createPlatformFilterCompositionalLayout(), animated: false)
        platformFilterCollectionView.register(UINib(nibName: "PlatformCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlatformCell")
    }
    
    private func setRefreshControl(){
        refreshControl.addTarget(self, action: #selector(refresh(_ :)), for: .valueChanged)
        refreshControl.tintColor = .blue
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching new games ...")
        gameListCollectionView.refreshControl = refreshControl
    }
    private func setNoResultLabel(){
        noResultLabel.text = "No games has been found"
        noResultLabel.textColor = .label
        noResultLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        noResultLabel.textAlignment = .center
        noResultLabel.frame = view.bounds
        view.addSubview(noResultLabel)
        noResultLabel.isHidden = true
    }
    
}


extension GameListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else {
            return 0
        }
        let count = collectionView == platformFilterCollectionView ? presenter.getPlatforms().count : presenter.getGameModels().count

        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == platformFilterCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlatformCell", for: indexPath) as! PlatformCollectionViewCell
            let platform = presenter?.platformForItemAt(row: indexPath.row)
            cell.configure(name: platform?.name ?? "no data")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameItemCell", for: indexPath) as! GameItemCollectionViewCell
            let game = presenter?.cellForItemAt(row: indexPath.row)
            cell.configure(viewModel: game ?? Game(id: 0, name: "no data",backgroundImage: "none"))
            return cell
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let height = scrollView.contentSize.height
        if offsetY > height - scrollView.frame.size.height {
            presenter?.notifyFetchNext()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let presenter = presenter else {
            return false
        }
        if collectionView == platformFilterCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? PlatformCollectionViewCell {
                if cell.isSelected {
                    cell.didDeselected()
                    presenter.didDeSelectPlatform()
                    collectionView.reloadData()
                    return false
                }
            }
            presenter.didSelectPlatformAt(indexPath: indexPath)
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter = presenter else {
            return
        }
        if collectionView == platformFilterCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? PlatformCollectionViewCell {
                cell.cellSelected()
            }
            presenter.didSelectPlatformAt(indexPath: indexPath)
            return
        }
        presenter.didSelectRowAt(indexPath: indexPath)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let presenter = presenter else {
            return
        }
        if collectionView == platformFilterCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? PlatformCollectionViewCell {
                cell.didDeselected()
            }
            presenter.didSelectPlatformAt(indexPath: indexPath)
            return
        }
    }
    
    
    
}

extension GameListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let presenter = presenter else {
            return
        }
        presenter.notifySearchButtonPressed()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let presenter = presenter else {
            return
        }
        
        presenter.updateSerchTerm(text: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let presenter = presenter else{
            return
        }
        searchBar.text = nil
        presenter.notifySearchCancelButtonPressed()
    }
}



extension GameListViewController {
    func createGameListCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnv in
            
            switch sectionIndex {
            default:
                return CompositionalLayoutHelper.createGameListSection()
            }
            
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        
        return layout
    }
    
    func createPlatformFilterCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnv in
            
            switch sectionIndex {
            default:
                return CompositionalLayoutHelper.createPlatformsSection()
            }
            
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        
        return layout
    }
   
    
}
