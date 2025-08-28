//
//  PinterestLayout.swift
//  CollectionView
//
//  Created by 송영민 on 8/25/25.
//

import UIKit

protocol PinterestLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView,
                      heightForItemAt indexPath: IndexPath) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {
  weak var delegate: PinterestLayoutDelegate?
  
  private let numberOfColumns = 2
  private let cellPadding: CGFloat = 6
  
  private var cache: [UICollectionViewLayoutAttributes] = []
  private var contentHeight: CGFloat = 0
  
  private var contentWidth: CGFloat {
    guard let collectionView = collectionView else { return 0 }
    let insets = collectionView.contentInset
    return collectionView.bounds.width - (insets.left +
                                          insets.right)
  }
}
