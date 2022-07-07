//
//  GameItemCollectionViewCell.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 30.06.2022.
//

import UIKit

class GameItemCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("geldim")
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
    }

    func configure(viewModel: Game){
        nameLabel.text = viewModel.name
    }
}
