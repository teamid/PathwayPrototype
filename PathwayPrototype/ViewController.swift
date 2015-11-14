//
//  ViewController.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/12/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
      struct Static {
            static let cellID: String = "PathwayFeedCell"
      }
      
      @IBOutlet weak var tableView: UITableView!
      
      private var data = [Data]()
      
      override func viewDidLoad() {
            super.viewDidLoad()
            tableView.registerNib(UINib(nibName: Static.cellID, bundle: nil), forCellReuseIdentifier: Static.cellID)
            
            for _ in 0...8 {
                  data += Data.AllValues
            }
            // Do any additional setup after loading the view, typically from a nib.
      }

      override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
      }


}
// MARK: —— Data
extension ViewController {
      
      enum Data: Int {
            case Ibiza = 0
            case Whistler = 1
            case Rio = 2
            
            static let AllValues: [Data] = [.Ibiza, .Whistler, .Rio]
            
            static let images: [UIImage!] = [Constants.Images.ibiza, Constants.Images.whistler, Constants.Images.rio]
            static let titles: [String] = ["Ibiza Summer", "Whistler nye 2015", "World Cup in Rio"]
            static let locations: [String] = ["Ibiza, Spain", "Whistler, Canada", "Rio de Janeiro, Brazil"]
            static let names: [String] = ["Guy Nakamura", "David Smith", "Mike Davis"]

            static func image(data: Data) -> UIImage! {
                  return images[data.rawValue]
            }
            static func title(data: Data) -> String {
                  return titles[data.rawValue]
            }
            static func location(data: Data) -> String {
                  return locations[data.rawValue]
            }
            static func name(data: Data) -> String {
                  return names[data.rawValue]
            }
      }
      
}



extension ViewController: UITableViewDataSource {
      
      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            return tableView.dequeueReusableCellWithIdentifier(Static.cellID, forIndexPath: indexPath)
      }
      
      func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView()
      }
      
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
      }
      
      func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return data.count
      }
}


extension ViewController: UITableViewDelegate {

      func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 232
      }
      
      func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 2
      }
      
      
      func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
            guard let cell = cell as? PathwayFeedCell else {
                  return
            }
            let datum = data[indexPath.section]
            cell.tripPreview.image = Data.image(datum)
            cell.titleLabel.text = Data.title(datum).uppercaseString
            cell.subtitleLabel.text = Data.location(datum)
            cell.userLabel.text = Data.name(datum)
            
      }
      
      func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let datum = data[indexPath.section]
            if datum == .Whistler {
                  performSegueWithIdentifier("goPathway", sender: self)
            }
      }

}

