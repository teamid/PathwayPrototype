//
//  SnapshotHelper.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/13/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import MapKit

struct SnapshotHelper {
      
      static private func snapshotOptions(region: MKCoordinateRegion, size: CGSize) -> MKMapSnapshotOptions {
            let options = MKMapSnapshotOptions()
            options.scale = UIScreen.mainScreen().scale
            options.showsBuildings = true
            options.showsPointsOfInterest = true
            options.region = region
            options.size = size
            return options
      }
      
      static func createMapImage(atCoordinate coordinate: CLLocationCoordinate2D, targetSize size: CGSize, callback: UIImage -> Void) {
            callOnBackgroundQueue {
                  let region = MKCoordinateRegionMakeWithDistance(coordinate, 1e6, 1e6)
                  let options = SnapshotHelper.snapshotOptions(region, size: size)
                  let snapshotter = MKMapSnapshotter(options: options)
                  
                  snapshotter.startWithQueue(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { (snap,error) in
                        
                        guard let snap = snap where error == nil else {
                              print(error?.localizedDescription)
                              return
                        }
                        
                        let image = snap.image
                        
                        UIGraphicsBeginImageContextWithOptions(image.size, true, options.scale)
                        image.drawAtPoint(CGPointMake(0, 0))
                        
                        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        callOnMainQueue {
                              callback(finalImage)
                        }
                  }
            }
      }
      
      
      
}

