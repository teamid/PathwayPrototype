//
//  MapTriangleCell.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/12/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit

class MapTriangleCell: UICollectionViewCell {
      
      struct Static {
            static let lineWidth: CGFloat = 3
            
            static let invertTransform: CGAffineTransform = CGAffineTransformMakeScale(-1, -1)
            static let normalTransform: CGAffineTransform = CGAffineTransformMakeScale(1, 1)
            
            private static func transformationForData(data: TriangleHelper.MTriangleData) -> CGAffineTransform {
                  switch data.triangle {
                  case .Left, .Top:
                        return Static.normalTransform
                  case .Bottom:
                        return Static.invertTransform
                  case .Right(_, let down):
                        return down ? Static.normalTransform : Static.invertTransform
                  }
            }
      }
      
      
      private var data: TriangleHelper.MTriangleData? {
            didSet {
                  drawRect(bounds)
            }
      }
      @IBOutlet weak var imageView: UIImageView!
      
      weak var labelView: MapTriangleLabelContainer?
      
      
      override func drawRect(rect: CGRect) {
            super.drawRect(rect)
            if let data = data {
                  addMask(data)
                  if labelView == nil {
                        addLabelView(data)
                  }
                  adjustLabelView(data)
            }
      }
      
      
      private func addMask(data: TriangleHelper.MTriangleData) {
            let path = data.path
            
            let mask = CAShapeLayer()
            mask.path = path.CGPath
            layer.mask = mask
            
            
            let shape = CAShapeLayer()
            shape.path = path.CGPath
            shape.frame = bounds
            shape.path = path.CGPath
            shape.lineWidth = Static.lineWidth
            shape.strokeColor = UIColor.whiteColor().CGColor
            shape.fillColor = UIColor.clearColor().CGColor
            
            layer.addSublayer(shape)
            
      }
      
      private func addLabelView(data: TriangleHelper.MTriangleData) {
            let labelView = MapTriangleLabelContainer(frame: bounds)
            addSubview(labelView)
            self.labelView = labelView
      }
      
      private func adjustLabelView(data: TriangleHelper.MTriangleData) {
            print("Adjusting at index: \(data.index)")
            labelView?.center = TriangleHelper.MTriangleData.labelCenter(data, rect: bounds)
            labelView?.transform = Static.transformationForData(data)
      }
      
      
      
      override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
      }
      
      func setTriangleData(data: TriangleHelper.MTriangleData) {
            self.data = data
      }
      
      
}









