//
//  GameDetailViewController.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 4.07.2022.
//

import UIKit

final class GameDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var metacriticLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var relaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var playTimeLabel: UILabel!
    @IBOutlet weak var publishersLabel: UILabel!
    @IBOutlet weak var visitRedditStack: UIStackView!
    @IBOutlet weak var visitWebsiteStack: UIStackView!
    
    
    
    var presenter: GameDetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.notifyViewWillAppear()
    }
    
    @IBAction func didTapDescp(sender: UITapGestureRecognizer){
        presenter?.didTapDesc()
    }
    
    @IBAction func didTapVisitReddit(sender: UITapGestureRecognizer){
        presenter?.didTapVisitReddit()
    }
    @IBAction func didTapVisitWebsite(sender: UITapGestureRecognizer){
        presenter?.didTapVisitWebsite()
    }
}

extension GameDetailViewController: GameDetailViewInterface {
    func changeDescp(with descExpanded: Bool) {
        descriptionLabel.numberOfLines = descExpanded ? 4 : 0
        descriptionLabel.lineBreakMode = descExpanded ? .byTruncatingTail : .byWordWrapping
    }
    
    func setupView() {
        self.metacriticLabel.borderWidth = 2
        
    }
    
    func setupData(){
        guard let game = presenter?.getGameDetail() else {
            print("no game")
            return
        }
                   
        print(game.descriptionRaw)
        print(game)
        DispatchQueue.main.async {
            self.nameLabel.text = game.name
            self.metacriticLabel.text = "\(game.metacritic ?? -1)"
            self.descriptionLabel.text = "\(game.descriptionRaw ?? "no descp")"
            self.relaseDateLabel.text = "\(game.released)"
            self.playTimeLabel.text = "\(game.playtime ?? 0) hours"
            self.genresLabel.text = "\(game.genresString)"
            self.publishersLabel.text = "\(game.publishersString)"
            self.visitRedditStack.isHidden = game.redditUrl != nil ? false : true
            self.visitWebsiteStack.isHidden = game.website != nil ? false : true
            self.metacriticLabel.textColor = game.color ?? .label
            self.metacriticLabel.borderColor = game.color ?? .label
        }
        
    }
    
    func setScreenTitle(with title: String) {
        self.title = title
    }
    
}
