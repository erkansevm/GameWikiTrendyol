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
        let presenter = GameListPresenter()
        let interactor = GameListInteractor()
        
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Bla bla") as! GameListViewController
        
        // Connect Layers
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        router.navigationController = navigationController
        
        return view
    }
}


extension GameListRouter: GameListRouterInterface {
    func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func performSegue(with identifier: String) {
        self.navigationController?.visibleViewController?.performSegue(withIdentifier: identifier, sender: nil)
    }
    
    func presentPopup(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "AllRight", style: .default, handler: nil))
        self.navigationController?.visibleViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
}
