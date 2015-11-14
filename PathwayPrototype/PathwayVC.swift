//
//  PathwayVC.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/12/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit
import MapKit

struct Footprint {
      let image: UIImage
      let owner: String
      let caption: String?
      
      init(_ image: UIImage, _ owner: String) {
            self.image = image
            self.owner = owner
            
            let cap = Constants.Footprints.captions.randomItem
            self.caption = cap != "" ? cap : nil
      }
}

class PathwayVC: UIViewController {
      
      struct Static {
            static let postTime = NSDate(timeInterval: 1e5, sinceDate: NSDate())
            static let postTitle = "WHISTLER NYE 2015"
            
            static let screenHeight: CGFloat = UIScreen.height - 44
            static let parallaxConstant: CGFloat = 0.65
            
            struct CountInfo {
                  typealias Info = PathwayCountTableCell.CountInfo
                  static let cities: Info = (3,"CITIES")
                  static let footprints: Info = (72,"FOOTPRINTS")
                  static let places: Info = (11,"PLACES")
                  static let tagged: Info = (23,"TAGGED")
                  
                  
                  static let likes: Info = (34,"LIKED THIS")
                  static let comments: Info = (13,"LEFT COMMENTS")

                  
                  static let pathwayValues = [cities,footprints,places,tagged]
                  static let likeValues = [likes,comments]
            }
            
            static let cities: [String] = [
                  "Whistler, Canada",
                  "Vancouver, Canada",
                  "Seattle, USA",
                  "Rio de Janeiro, Brazil",
                  "Bangkok, Thailand"
            ]
            static let coords: [CLLocationCoordinate2D] = [
                  CLLocationCoordinate2D(latitude: 50.1164000, longitude: -122.9694600),
                  CLLocationCoordinate2D(latitude: 50.1164000, longitude: -122.9694600),
                  CLLocationCoordinate2D(latitude: 50.1164000, longitude: -122.9694600),
                  CLLocationCoordinate2D(latitude: 50.1164000, longitude: -122.9694600),
                  CLLocationCoordinate2D(latitude: 50.1164000, longitude: -122.9694600),
                  CLLocationCoordinate2D(latitude: 50.1164000, longitude: -122.9694600),
                  CLLocationCoordinate2D(latitude: 50.1164000, longitude: -122.9694600),
                  CLLocationCoordinate2D(latitude: 50.1164000, longitude: -122.9694600),
                  CLLocationCoordinate2D(latitude: 50.1164000, longitude: -122.9694600),
                  CLLocationCoordinate2D(latitude: 50.1164000, longitude: -122.9694600),
                  CLLocationCoordinate2D(latitude: 50.1164000, longitude: -122.9694600)
            ]
            
            static let footprints = Constants.Footprints.AllValues
            static let pathwayString = "Our trip to Whistler for New Year’s Eve was inspirational, incredible and altogether amazing. We drank too much, went heliskiing with a God, and enjoyed the finest snow that Canada has to offer. We’ll miss you, Whistler."
      }
      
      @IBOutlet weak var topBar: PathwayTopBarView!
      @IBOutlet weak var tableView: UITableView!
      
      
      @IBOutlet weak var bottomContainer: UIView!
      @IBOutlet weak var titleLabel: UILabel!
      @IBOutlet weak var subtitleLabel: UILabel!
      
      @IBOutlet weak var avatarView: UIImageView!
      @IBOutlet weak var userLabel: UILabel!
      
      private var mapController: TriangleCollectionController!
      private var mapImages = [ Int : UIImage ]() {
            didSet {
                  if let mapController = mapController, collectionView = mapController.collectionView, cells = collectionView.visibleCells() as? [MapTriangleCell] {
                        for cell in cells {
                              if let indexPath = collectionView.indexPathForCell(cell) where cell.imageView.image == nil {
                                    cell.imageView.image = mapImages[indexPath.row]
                              }
                        }
                  }
                  
                 
            }
      }
      
      override func prefersStatusBarHidden() -> Bool {
            return true
      }
      
      override func viewDidLoad() {
            super.viewDidLoad()
            setupTopBar()
            setupTableView()
            
            // Do any additional setup after loading the view.
      }
      
      override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            setupAvatar()
            generateMapImages()
      }
      
      override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
      }
      
      private func generateMapImages() {
            let size = CGSize(width: UIScreen.width, height: 188)
            for (i,coord) in Static.coords.enumerate() {
                  SnapshotHelper.createMapImage(atCoordinate: coord, targetSize: size) { [weak self] image in
                        self?.mapImages[i] = image
                        return
                  }
            }
      }
      
      
      /*
      // MARK: - Navigation
      
      // In a storyboard-based application, you will often want to do a little preparation before navigation
      override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
      }
      */
      
}


extension PathwayVC {
      
      private func setupTableView() {
            for chunk in Chunk.AllValues {
                  let identifier = Chunk.nib(chunk)
                  let nib = UINib(nibName: identifier, bundle: nil)
                  tableView.registerNib(nib, forCellReuseIdentifier: identifier)
            }
      }
      
      private func setupAvatar() {
            let path = UIBezierPath(ovalInRect: avatarView.bounds)
            let mask = CAShapeLayer()
            mask.path = path.CGPath
            avatarView.layer.mask = mask
            
            avatarView.addStrokeToPath(UIColor.whiteColor(), width: 1.0, path: path)
      }
}


// MARK: —— PathwayTopBar Delegate
extension PathwayVC: PathwayTopBarDelegate {
      
      func setupTopBar() {
            topBar.setDelegate(self, postTime: Static.postTime.offsetFrom(NSDate()), postTitle: Static.postTitle)
      }

      func topBar(bar: PathwayTopBarView, closeIconWasTapped sender: UIButton!) {
            dismissViewControllerAnimated(true, completion: nil)
      }
      func topBar(bar: PathwayTopBarView, topBarWasTapped sender: AnyObject!) {
            
      }
      func topBar(bar: PathwayTopBarView, rightIconWasTapped sender: AnyObject!) {
            
      }

}


extension PathwayVC {
      
      enum Chunk: Int {
            case Counts = 0
            case Map = 1
            case Description = 2
            case Footprints = 3
            case LikeComment = 4
            
            static let AllValues: [Chunk] = [.Counts,.Map,.Description,.Footprints,.LikeComment]
            
            static func nib(chunk: Chunk) -> String {
                  switch chunk {
                  case .Counts:
                        return Reuse.count
                  case .Map:
                        return Reuse.map
                  case .Description:
                        return Reuse.description
                  case .Footprints:
                        return Reuse.footprint
                  case .LikeComment:
                        return Reuse.count
                  }
            }
            static func nib(chunk: Chunk, row: Int) -> String {
                  switch chunk {
                  case .Footprints:
                        return row % 2 == 0 ? Reuse.footprint : Reuse.description
                  default:
                        return nib(chunk)
                  }
            }
            
            
            struct Reuse {
                  
                  static let count: String = "PathwayCountTableCell"
                  static let map: String = "PathwayMapTableCell"
                  static let description: String = "PathwayDescriptionTableCell"
                  static let footprint: String = "PathwayFootprintCell"
            }
      
      }
}


extension PathwayVC: UITableViewDataSource {
      
      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let chunk = Chunk.AllValues[indexPath.section]
            let identifier = Chunk.nib(chunk, row: indexPath.row)
            return tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
      }
      
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let chunk = Chunk.AllValues[section]
            switch chunk {
            case .Footprints:
                  return Static.footprints.count * 2
            default:
                  return 1
            }
      }
      
      func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return UIView()
      }
      
      func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            let chunk = Chunk.AllValues[section]
            switch chunk {
            case .Description:
                  return createDescriptionFooter()
            default:
                  return UIView()
            }
      }
      
      func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return Chunk.AllValues.count
      }
      
      private func createDescriptionFooter() -> UIView {
            let rect = CGRect(x: 0, y: 0, width: UIScreen.width, height: 44)
            let view = UIView(frame: rect)
            view.backgroundColor = UIColor.whiteColor()

            let divRect = CGRect(x: 0, y: 0, width: 54, height: 2)
            let divView = UIView(frame: divRect)
            divView.backgroundColor = UIColor.Gray(85)

            view.addSubview(divView)
            divView.center.x = view.center.x
            
            let mask = CAShapeLayer()
            mask.path = UIBezierPath(roundedRect: divView.bounds, cornerRadius: 1).CGPath
            divView.layer.mask = mask
            
            return view
      }
}


extension PathwayVC: UITableViewDelegate {
      
      func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            if section == 0 {
                  return UIScreen.height
            }
            return CGFloat.min
      }
      
      func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            let chunk = Chunk.AllValues[section]
            switch chunk {
            case .Description:
                  return 44
            default:
                  return CGFloat.min
            }
      }
      
      func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            let chunk = Chunk.AllValues[indexPath.section]
            switch chunk {
            case .Counts, .LikeComment:
                  return 88
            case .Map:
                  return 188
            case .Description:
                  return UITableViewAutomaticDimension
            case .Footprints:
                  if indexPath.row % 2 == 0 {
                        let i = Int(indexPath.row/2)
                        let image = Static.footprints[i].image
                        let height = UIScreen.width * (image.size.height / image.size.width)
                        return height
                  }
                  return UITableViewAutomaticDimension
            }
      }
      
      func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            let chunk = Chunk.AllValues[indexPath.section]
            switch chunk {
            case .Description:
                  let string = Static.pathwayString
                  let height = PathwayDescriptionTableCell.Static.heightWithConstrainedWidth(string)
                  return height
            case.Footprints:
                  if indexPath.row % 2 != 0 {
                        let i = Int(indexPath.row/2)
                        if let caption = Static.footprints[i].caption {
                              return PathwayDescriptionTableCell.Static.heightWithConstrainedWidth(caption)
                        }
                        return 60
                  }
            default:
                  break
            }
            return self.tableView(tableView, heightForRowAtIndexPath: indexPath)

      }
      
      func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
            if let cell = cell as? PathwayCountTableCell {
                  let chunk = Chunk.AllValues[indexPath.section]
                  let counts = chunk == .Counts ? Static.CountInfo.pathwayValues : Static.CountInfo.likeValues
                  let inset = chunk == .Counts ? UIEdgeInsetsZero : UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
                  cell.setCounts(counts, inset: inset)
            } else if let cell = cell as? PathwayMapTableCell where mapController == nil {
                  mapController = TriangleCollectionController()
                  mapController.delegate = self
                  mapController.setCollection(cell.collectionView, cities: Static.cities)
            } else if let cell = cell as? PathwayFootprintCell {
                  let i = Int(indexPath.row/2)
                  let footprint = Static.footprints[i]
                  cell.footprintImageView.image = footprint.image
                  cell.barView.titleLabel.text = footprint.owner
            } else if let cell = cell as? PathwayDescriptionTableCell {
                  print("DescriptionCell: \(cell.frame)")
                  let chunk = Chunk.AllValues[indexPath.section]
                  if chunk == .Footprints {
                        let i = Int(indexPath.row/2)
                        let footprint = Static.footprints[i]
                        cell.textView.text = footprint.caption
                        cell.setNeedsLayout()
                  } else {
                        cell.textView.text = Static.pathwayString
                  }
            }
      }
      
      
      func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            let chunk = Chunk.AllValues[section]
            switch chunk {
            case .Counts:
                  view.alpha = 0
            default:
                  view.backgroundColor = UIColor.whiteColor()
            }
      }
      
      
      
}



extension PathwayVC: UIScrollViewDelegate {
      
      func scrollViewDidScroll(scrollView: UIScrollView) {
            let yOffset = scrollView.contentOffset.y
            topBar.handleScrollViewOffset(offset: yOffset)
            bottomContainer.frame.origin.y = -yOffset * Static.parallaxConstant
            if yOffset >= 0 {
                  bottomContainer.alpha = 1 - (yOffset / Static.screenHeight)
            }
      }
      
      func scrollViewWillBeginDragging(scrollView: UIScrollView) {
            hideVenueViews()
      }
      
      
      private func hideVenueViews() {
            let bars = tableView.visibleCells.flatMap { $0 as? PathwayFootprintCell }.flatMap { $0.barView }.filter { $0.venueVisible == true }
            bars.forEach { $0.displayVenueView(visible: false) }
      }
}

extension PathwayVC: TriangleCollectionDelegate {
      
      func triangleCollection(controller: TriangleCollectionController, willDisplayCell cell: MapTriangleCell, forItemAtIndexPath indexPath: NSIndexPath) {
            cell.imageView.image = mapImages[indexPath.row]
      }
}


















protocol TriangleCollectionDelegate {
      func triangleCollection(controller: TriangleCollectionController, willDisplayCell cell: MapTriangleCell, forItemAtIndexPath indexPath: NSIndexPath)
}

class TriangleCollectionController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
      
      struct Static {
            static let identifier: String = "MapTriangleCell"
            private static func generateTriangleData(nTriangles n: Int) -> [TriangleHelper.MTriangleData] {
                  let triangles = TriangleHelper.generateTriangles(n)
                  return triangles.enumerate().map { TriangleHelper.MTriangleData(index: $0.0, triangle: $0.1) }
            }

      }
      
      weak var collectionView: UICollectionView!
      var cities = [String]()
      var triangleData: [TriangleHelper.MTriangleData] = []
      var delegate: TriangleCollectionDelegate?
      
      
      func setCollection(collectionView: UICollectionView!, cities: [String]) {
            print("SetCollection")
            self.cities = cities
            self.triangleData = Static.generateTriangleData(nTriangles: cities.count)
            
            self.collectionView = collectionView
            self.collectionView.registerNib(UINib(nibName: Static.identifier, bundle: nil), forCellWithReuseIdentifier: Static.identifier)
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.reloadData()
      }
      
      
      
      func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Static.identifier, forIndexPath: indexPath) as! MapTriangleCell
            let datum = triangleData[indexPath.row]
            cell.setTriangleData(datum)
            return cell
      }
      
      func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return cities.count
      }
      
      func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
            print("Displaying row: \(indexPath.row)")
            let datum = triangleData[indexPath.row]
            switch datum.triangle {
            case .Bottom:
                  cell.transform = CGAffineTransformMakeScale(-1, -1)
            case .Right(_, let down):
                  if !down {
                        cell.transform = CGAffineTransformMakeScale(-1, -1)
                  }
            default:
                  break
            }
            if let cell = cell as? MapTriangleCell {
                  cell.labelView?.titleLabel.text = cities[indexPath.row].uppercaseString
                  delegate?.triangleCollection(self, willDisplayCell: cell, forItemAtIndexPath: indexPath)
            }
      }
      
      
      
      
      
}

class TriangleLayout: UICollectionViewLayout {
      
      var triangleData: [TriangleHelper.MTriangleData]? {
                  if let dataSource = collectionView?.dataSource as? TriangleCollectionController {
                        return dataSource.triangleData
                  }
            return nil
      }
      
      override func collectionViewContentSize() -> CGSize {
            if let collectionView = collectionView, triangleData = triangleData {
                  let rects = triangleData.map { $0.rect }
                  var rect = CGRectZero
                  for tRect in rects {
                        rect = CGRectUnion(rect, tRect)
                  }
                  return CGSize(width: rect.size.width - 8, height: collectionView.bounds.height)
            }
            return collectionView!.bounds.size
      }
      override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            guard let indexPaths = indexPathsOfItemsInRect(rect) else {
                  return nil
            }
            return indexPaths.map { self.layoutAttributesForItemAtIndexPath($0) }.flatMap { $0 }
      }
      
      override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            if let triangleData = triangleData where triangleData.count > indexPath.row {
                  let datum = triangleData[indexPath.row]
                  attributes.frame = datum.rect
                  
                  
                  return attributes
            }
            return nil
      }
      
      
      func indexPathsOfItemsInRect(rect: CGRect) -> [NSIndexPath]? {
            if let triangleData = triangleData {
                  let data = triangleData.filter { CGRectIntersectsRect(rect, $0.rect) }
                  let indexPaths = data.map { NSIndexPath(forItem: $0.index, inSection: 0) }
                  return indexPaths
            }
            return nil
      }
}









