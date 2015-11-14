//
//  FootprintBottomBarView.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/13/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit

class FootprintBottomBarView: UIView {
      
      struct Static {
            static let nibName: String = "FootprintBottomBarView"
      }
      
      @IBOutlet weak var view: UIView!
      @IBOutlet weak var contentContainer: UIView!
      
      @IBOutlet weak var avatar: UIImageView!
      
      @IBOutlet weak var titleLabel: UILabel!
      @IBOutlet weak var subtitleLabel: UILabel!
      
      @IBOutlet weak var venueView: UIImageView!
      @IBOutlet weak var venueTitleLabel: UILabel!
      @IBOutlet weak var venueSubtitleLabel: UILabel!
      
      @IBOutlet weak var arrow: UIImageView!
      
      
      var venueVisible: Bool = false

      override func drawRect(rect: CGRect) {
            super.drawRect(rect)
            
            let path = UIBezierPath(ovalInRect: avatar.bounds)
            let mask = CAShapeLayer()
            mask.path = path.CGPath
            avatar.layer.mask = mask
            
            let vPath = UIBezierPath(roundedRect: venueView.bounds, cornerRadius: 3)
            let vMask = CAShapeLayer()
            vMask.path = vPath.CGPath
            venueView.layer.mask = vMask

      }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
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
            
            arrow?.colorOverlay = UIColor.blackColor()
      }
      
      
      @IBAction func venueButtonTapped(sender: UIButton) {
            if !venueVisible {
                  displayVenueView(visible: true)
            }
      }
      
      
      func displayVenueView(visible visible: Bool) {
            venueVisible = visible
            let origin: CGFloat = visible ? venueVisibleOrigin() : 0
            let alpha: CGFloat = visible ? 1.0 : 0.0
            
            let arrowBlock: Void -> Void = {
                  self.arrow.alpha = alpha
            }
            let block: Void -> Void = {
                  self.contentContainer.frame.origin.x = origin
                  self.venueTitleLabel.alpha = alpha
                  self.venueSubtitleLabel.alpha = alpha
            }
            let options: UIViewAnimationOptions = [.CurveEaseInOut, .BeginFromCurrentState, .AllowUserInteraction]
            
            if visible {
                  UIView.animateWithDuration(0.25, delay: 0.1, options: options, animations: arrowBlock, completion: nil)
                  UIView.animateWithDuration(0.55, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: options, animations: block, completion: nil)
            } else {
                  UIView.animateWithDuration(0.15, delay: 0, options: options, animations: arrowBlock) { finished in
                        UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: options, animations: block, completion: nil)
                  }
            }

      }
      
      private func venueVisibleOrigin() -> CGFloat {
            let gutter: CGFloat = 15
            let val = CGRectGetMinX(venueView.frame)
            return gutter - val
      }
      
      override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
            let view = super.hitTest(point, withEvent: event)
            if view != nil && venueVisible {
                  let arrowRect = arrow.frame
                  print("Point: \(point), rect: \(arrowRect)")

                  if point.x > CGRectGetMinX(arrowRect)-22 {
                        displayVenueView(visible: false)
                  }
            }
            return view
      }

}
