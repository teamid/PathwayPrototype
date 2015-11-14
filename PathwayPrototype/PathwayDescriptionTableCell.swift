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
            static let leftInset: CGFloat = 36
            static let rightInset: CGFloat = leftInset
            
            static let topInset: CGFloat = 25
            static let bottomInset: CGFloat = 40
            
            static let font: UIFont = UIFont(name: "SFUIText-Regular", size: 15)!
            
            static func heightWithConstrainedWidth(string: String) -> CGFloat {
                  let width = UIScreen.width - leftInset - rightInset
                  let constraintRect = CGSize(width: width, height: UIScreen.height)
                  let boundingBox = string.boundingRectWithSize(constraintRect, options: [.UsesLineFragmentOrigin, .UsesFontLeading], attributes: [NSFontAttributeName: font], context: nil)
                  return boundingBox.height + topInset + bottomInset
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
