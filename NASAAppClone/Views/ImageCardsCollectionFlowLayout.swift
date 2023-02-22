//
//  ImageCardsCollectionFlowLayout.swift
//  NASAAppClone
//
//  Created by Kirti S on 2/22/23.
//

import UIKit

/// Class of UICollectionViewFlowLayout, to set the card like appearance of the deatil Image collection view
class ImageCardsCollectionFlowLayout: UICollectionViewFlowLayout {
    
    private var itemHeight = Int()
    private var itemWidth = Int()
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        itemWidth = Int(collectionView.frame.width - 50)
        itemHeight = Int(collectionView.frame.height - 50)
        
        scrollDirection = .horizontal
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let peekingItemWidth = itemSize.width / 10
        let horizontalInsets = (collectionView.frame.size.width - itemSize.width) / 2
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: horizontalInsets, bottom: 0, right: horizontalInsets)
        minimumLineSpacing = 10
        
        self.scrollDirection = .horizontal
    }

}
