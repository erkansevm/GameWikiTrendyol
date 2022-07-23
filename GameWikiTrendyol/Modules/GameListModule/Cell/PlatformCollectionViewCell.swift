//
//  PlatformCollectionViewCell.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 20.07.2022.
//

import UIKit

class PlatformCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var platformName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    
    func configure(name: String){
        platformName.text = name
    }
    
    func cellSelected(){
        containerView.backgroundColor = .label
        platformName.textColor = .systemBackground
        isSelected = true
    }
    
    func didDeselected(){
        containerView.backgroundColor = .tertiarySystemGroupedBackground
        platformName.textColor = .label
        isSelected = false
    }
    
    override func prepareForReuse() {
        containerView.backgroundColor = .tertiarySystemGroupedBackground
        platformName.textColor = .label
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
