//
//  PathwayFootprintCell.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/13/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit

class PathwayFootprintCell: UITableViewCell {
      
      @IBOutlet weak var footprintImageView: UIImageView!
      @IBOutlet weak var barView: FootprintBottomBarView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
