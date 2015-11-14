//
//  PathwayDescriptionCell.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/12/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit

class PathwayDescriptionTableCell: UITableViewCell {
      
      
      struct Static {
            static let leftInset: CGFloat = 30
            static let rightInset: CGFloat = leftInset
            
            static let font: UIFont = UIFont(name: "SFUIText-Regular", size: 15)!
            
            static func heightWithConstrainedWidth(string: String) -> CGFloat {
                  return 188
//                  print("Getting height for string: \(string)")
//                  print(font)
//                  
//                  let width = UIScreen.width - leftInset - rightInset
//                  print(width)
//
//                  let constraintRect = CGSize(width: width, height: UIScreen.height)
//                  print(constraintRect)
//
//                  
//                  let boundingBox = string.boundingRectWithSize(constraintRect, options: [.UsesLineFragmentOrigin, .UsesFontLeading], attributes: [NSFontAttributeName: font], context: nil)
//                  print(boundingBox)
//                  return boundingBox.height
            }

      }

      @IBOutlet weak var textView: UITextView!
      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
