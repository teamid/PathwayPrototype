//
//  PathwayMapTableCell.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/12/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit

class PathwayMapTableCell: UITableViewCell {

//      @IBOutlet var collectionViews: [UICollectionView]!
      
      @IBOutlet weak var collectionView: UICollectionView!
      
      override func awakeFromNib() {
        super.awakeFromNib()
            collectionView?.contentInset.left = -4
            collectionView?.contentInset.right = -1
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
