//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by plum on 2016/10/24.
//  Copyright © 2016年 Razeware LLC. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
  
  func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
  
  func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}


class PinterestLayout: UICollectionViewLayout {

  //1
  var delegate: PinterestLayoutDelegate!
  
  //2
  var numberOfColumns = 2
  var cellPadding: CGFloat = 6.0
  
  //3
  private var cache = [UICollectionViewLayoutAttributes]()
  
  //4
  private var contentHeight: CGFloat = 0.0
  private var contenWidth: CGFloat {
    let inset = collectionView!.contentInset
    return CGRectGetWidth(collectionView!.bounds) - (inset.left + inset.right)
  }
		
  override func prepareLayout() {
    //1
    if cache.isEmpty {
      //2
      let columnWidth = contenWidth / CGFloat(numberOfColumns)
      var xOffsets = [CGFloat]()
      for column in 0 ..< numberOfColumns {
        xOffsets.append(CGFloat(column) * columnWidth)
      }
      var column = 0
      var yOffset = [CGFloat].init(count: numberOfColumns, repeatedValue: 0.0)
      
      //3
      for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
        let indexPath = NSIndexPath.init(forItem: item, inSection: 0)
        
        //4
        let width = columnWidth - 2 * cellPadding
        let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
        let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
        let height = photoHeight + annotationHeight + 2 * cellPadding
        
        let frame = CGRectMake(xOffsets[item], yOffset[item], width, height)
        let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
        
        //5
        let attribute = UICollectionViewLayoutAttributes.init(forCellWithIndexPath: indexPath)
        attribute.frame = insetFrame
        cache.append(attribute)
        
        //6
        contentHeight = max(contentHeight, CGRectGetMaxY(frame))
        yOffset[column] = yOffset[column] + height
        column = column >= (numberOfColumns - 1) ? 0 : ++column
      }
      
    }
  }
  
  override func collectionViewContentSize() -> CGSize {
    return CGSizeMake(contenWidth, contentHeight)
  }
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes = [UICollectionViewLayoutAttributes]();
    for attribute in cache {
      if CGRectIntersectsRect(rect, attribute.frame) {
        layoutAttributes.append(attribute)
      }
    }
    return layoutAttributes
  }
		
}
