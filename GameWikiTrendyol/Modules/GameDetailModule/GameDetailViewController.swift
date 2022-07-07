//
//  GameDetailViewController.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 4.07.2022.
//

import UIKit

class GameDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var presenter: GameDetailPresenterInterface?
    @IBOutlet weak var metacriticLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.notifyViewWillAppear()
    }

}

extension GameDetailViewController: GameDetailViewInterface {
    func setupView() {
    }
    
    func setupData(){
        let game = presenter?.getGameDetail()
         nameLabel.text = game?.name
        metacriticLabel.text = "\(game?.metacritic ?? -1)"
    }
    
    func setScreenTitle(with title: String) {
        print(title)
        self.title = title
    }
    
}
