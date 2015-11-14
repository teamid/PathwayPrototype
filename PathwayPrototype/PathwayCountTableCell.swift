//
//  PathwayCountTableCell.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/12/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit

class PathwayCountTableCell: UITableViewCell {
      
      private struct Static {
            static let cellID: String = "CountCell"
            static let itemWidth: Int -> CGFloat = { nItems in
                  return UIScreen.width / CGFloat(nItems)
            }
      }
      typealias CountInfo = (n: Int, sub: String)
      
      
      
      @IBInspectable var counts: Int = 0 {
            didSet {
                  nCounts = counts
                  itemWidth = (UIScreen.width - inset.left - inset.right) / CGFloat(nCounts)
            }
      }
      
      @IBOutlet weak var collectionView: UICollectionView!
      private var nCounts: Int = 0
      private var itemWidth: CGFloat = 0
      private var inset: UIEdgeInsets = UIEdgeInsetsZero
      
      private var infoArr = [CountInfo]()
      
      
      override func awakeFromNib() {
            super.awakeFromNib()
            collectionView?.registerNib(UINib(nibName: Static.cellID, bundle: nil), forCellWithReuseIdentifier: Static.cellID)
            // Initialization code
      }
      
      override func setSelected(selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            // Configure the view for the selected state
      }
      
      
      func setCounts(arr: [CountInfo], inset: UIEdgeInsets) {
            print("Set counts: \(arr)")
//            self.infoArr = []
//            self.collectionView.reloadData()
            self.inset = inset
            self.infoArr = arr
            self.counts = arr.count
            self.collectionView.reloadData()
      }
      
}

extension PathwayCountTableCell: UICollectionViewDataSource {
      func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            return collectionView.dequeueReusableCellWithReuseIdentifier(Static.cellID, forIndexPath: indexPath)
      }
      func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return nCounts
      }
}



extension PathwayCountTableCell: UICollectionViewDelegate {
      func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
            if let cell = cell as? CountCell where infoArr.count > indexPath.row {
                  let info = infoArr[indexPath.row]
                  cell.countLabel.text = "\(info.n)"
                  cell.subtitleLabel.text = info.sub
            }
      }
}

extension PathwayCountTableCell: UICollectionViewDelegateFlowLayout {
      
      func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return inset
      }
      func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
            return 0
      }
      func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
            return 0
      }
      func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
            return CGSizeZero
      }
      func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSizeZero
      }
      func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: itemWidth, height: collectionView.bounds.height)
      }
      
}

