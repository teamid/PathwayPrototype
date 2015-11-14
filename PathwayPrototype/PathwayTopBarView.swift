//
//  PathwayTopBarView.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/12/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit

protocol PathwayTopBarDelegate {
      func topBar(bar: PathwayTopBarView, closeIconWasTapped sender: UIButton!)
      func topBar(bar: PathwayTopBarView, topBarWasTapped sender: AnyObject!)
      func topBar(bar: PathwayTopBarView, rightIconWasTapped sender: AnyObject!)
      func setupTopBar()
}

class PathwayTopBarView: UIView {
      
      private struct Static {
            static let nibName: String = "PathwayTopBarView"
            
            static let height: CGFloat = 44
            static let windowHeight: CGFloat = UIScreen.height - height
            
            static let textFadeMult: CGFloat = 0.318
      }
      
      @IBOutlet weak var view: UIView!
      @IBOutlet weak var backgroundView: UIView!

      @IBOutlet weak var closeIcon: UIImageView!
      @IBOutlet weak var timeLabel: UILabel!
      @IBOutlet weak var postLabel: UILabel!
      
      private var showingTime: Bool = true
      
      override func layoutSubviews() {
            super.layoutSubviews()
            print("Laying out subs")
      }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
      
      private var delegate: PathwayTopBarDelegate?
      private var postTime: String?
      private var postTitle: String?

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
            addBottomBar()
      }
      
      private func addBottomBar() {
            let height: CGFloat = 0.5
            let rect = CGRect(x: 0, y: CGRectGetHeight(view.frame)-height, width: CGRectGetWidth(view.frame), height: height)
            let div = UIView(frame: rect)
            div.backgroundColor = UIColor.Gray(65)
            backgroundView.addSubview(div)
      }
      
      
      func setDelegate(delegate: PathwayTopBarDelegate, postTime: String, postTitle: String) {
            self.delegate = delegate
            self.postTime = postTime
            self.postTitle = postTitle
            
            self.timeLabel.text = "\(postTime) ago"
            self.postLabel.text = postTitle
      }
      
      @IBAction func closeTapped(sender: UIButton!) {
            delegate?.topBar(self, closeIconWasTapped: sender)
      }

      
      
      
      func handleScrollViewOffset(offset offset: CGFloat) {
            
            let percentage = offset/Static.height
            if percentage >= 0.0 || percentage <= 1.0 {
                  backgroundView.alpha = percentage
            }
            
            if percentage > 1.0 {
                  
                  let windowPercentage = (offset) / Static.windowHeight
                  let white: CGFloat = 100 * (1 - windowPercentage)
                  closeIcon.colorOverlay = UIColor.Gray(white)
                  
                  
                  
                  let textFadePoint = Static.windowHeight * Static.textFadeMult
                  if offset > textFadePoint {
                        let textPercentage = (offset-textFadePoint) / (Static.windowHeight - textFadePoint)
                        postLabel.alpha = textPercentage
                  } else {
                        postLabel.alpha = 0
                  }
                  
            }
      }
      
      
      
      
      
      
      
}
