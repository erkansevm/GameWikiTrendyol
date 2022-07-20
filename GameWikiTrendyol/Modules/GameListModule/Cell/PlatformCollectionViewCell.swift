//
//  PlatformCollectionViewCell.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 20.07.2022.
//

import UIKit

class PlatformCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var platformName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    
    func configure(name: String){
        platformName.text = name
    }
    
/*
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        let modifiedAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        modifiedAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return modifiedAttributes

    }
 */
}
