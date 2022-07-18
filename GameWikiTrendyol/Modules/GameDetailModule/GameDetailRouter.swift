//
//  GameDetailRouter.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 4.07.2022.
//




class GameDetailRouter {
    weak var presenter: GameDetailPresenter?
    static func createModule(gameId: Int) -> GameDetailViewController {
        print(gameId)
        let router = GameDetailRouter()
        let interactor = GameDetailInteractor()
        let viewStoryBoard = AppStoryboard.GameDetail.instance
        let view = viewStoryBoard.instantiateViewController(withIdentifier: "GameDetailViewController") as! GameDetailViewController
        
        let presenter = GameDetailPresenter(gameId: gameId,router: router, interactor: interactor)
        
        router.presenter = presenter
        interactor.presenter = presenter
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}


extension GameDetailRouter: GameDetailRouterInterface {
    func goBack() {
        print("go back")
    }
    
    
}
