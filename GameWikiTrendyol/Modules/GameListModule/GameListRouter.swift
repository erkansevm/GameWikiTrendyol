//
//  GameListRouter.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 29.06.2022.
//


import UIKit

class GameListRouter {
    weak var presenter: GameListPresenterInterface?
    weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController) -> GameListViewController {
        // Create layers
        let router = GameListRouter()
        let interactor = GameListInteractor()
        let presenter = GameListPresenter(router: router, interactor: interactor)

        let gameListStoryBoard = AppStoryboard.GameList.instance
        let gameListView = gameListStoryBoard.instantiateViewController(withIdentifier: "GameListViewController") as! GameListViewController
        // Connect Layers
        presenter.view = gameListView
        gameListView.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        router.navigationController = navigationController
        
        return gameListView
    }
}


extension GameListRouter: GameListRouterInterface {
    func goGameDetail(with game: Game) {
        print(game)
        let vc = GameDetailRouter.createModule(game: game)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
 
    
    func presentPopup(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "AllRight", style: .default, handler: nil))
        self.navigationController?.visibleViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
}
