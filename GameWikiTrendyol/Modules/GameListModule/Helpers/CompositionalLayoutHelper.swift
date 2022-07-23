//
//  CompositionalLayoutHelper.swift
//  GameWikiTrendyol
//
//  Created by Erkan Sevim on 22.07.2022.
//

import UIKit

struct CompositionalLayoutHelper {
    static  func createPlatformsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.46), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 2
        
        
        
        return section
    }
    
    static  func createGameListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.75  ))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(4)
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 4
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom)
        section.boundarySupplementaryItems = [footer]
        
        return section
    }
    
    
   
}
