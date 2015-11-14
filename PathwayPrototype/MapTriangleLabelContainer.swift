//
//  MapTriangleLabelContainer.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/13/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit

class MapTriangleLabelContainer: UIView {
      
      struct Static {
            static let nibName: String = "MapTriangleLabelContainer"
      }
      
      
      @IBOutlet weak var view: UIView!
      @IBOutlet weak var titleLabel: UILabel!
      @IBOutlet weak var subtitleLabel: UILabel!


      override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
      }
      
      required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
      }
      
      private func commonInit() {
            NSBundle.mainBundle().loadNibNamed(Static.nibName, owner: self, options: nil)
            view.frame = bounds
            view.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
            addSubview(view)
      }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
