//
//  ViewController.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 27.06.2022.
//

import UIKit

class ViewController: UIViewController {
    var gameResult: GameResult?
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchFirstPage(expectedType: GameResult.self) { [weak self] result in
            switch result {
                
            case .success(let gameResult):
                self?.gameResult = gameResult
                print(gameResult)
            case .failure(let error):
                print(error)
            }
        }
    }

    
}

