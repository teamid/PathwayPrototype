//
//  Triangleswift
//  PathwayPrototype
//
//  Created by David Smith on 11/13/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit



struct TriangleHelper {
      struct Static {
            static let height: CGFloat = 198
            static let width: CGFloat = height*2.5
            
            static let g: CGFloat = 1.618
            static let a: CGFloat = 1 - (1/g)
            
            static let lineWidth: CGFloat = 3
      }
      
      enum Triangle {
            case Left
            case Top(offset: CGFloat)
            case Bottom(offset: CGFloat)
            case Right(maxX: CGFloat, down: Bool)
            
      }
      
      struct MTriangleData {
            let rect: CGRect
            let path: UIBezierPath
            let index: Int
            
            let triangle: Triangle
            
            init(index: Int, triangle: Triangle) {
                  self.index = index
                  self.rect = TriangleHelper.rectForTriangle(triangle)
                  self.path = TriangleHelper.pathForTriangle(triangle)
                  self.triangle = triangle
            }
      }
      
      static func rectForTriangle(triangle: Triangle) -> CGRect {
            var rect: CGRect
            switch triangle {
            case .Left:
                  rect = LeftTriangle.rect
                  break
            case .Top(let offset):
                  rect = TopTriangle.rect
                  rect.origin.x = offset
                  break
            case .Bottom(let offset):
                  rect = TopTriangle.rect
                  rect.origin.x = offset
                  break
            case .Right(let max, let down):
                  rect = down ? RightTriangle.rect : LeftTriangle.rect
                  rect.origin.x = max - CGRectGetWidth(rect)
                  break
            }
            return rect
      }
      
      static func pathForTriangle(triangle: Triangle) -> UIBezierPath {
            switch triangle {
            case .Left:
                  return LeftTriangle.rightTrianglePath()
            case .Top:
                  return TopTriangle.pathInRect()
            case .Bottom:
                  return TopTriangle.pathInRect()
            case .Right( _, let down):
                  return down ? RightTriangle.pathInRect() : LeftTriangle.rightTrianglePath()
            }
      }
      
      
      
      
      
      
      
      
      struct LeftTriangle {
            static let rect: CGRect = CGRect(x: 0, y: 0, width: Static.width*0.75, height: Static.height)
            static func rightTrianglePath() -> UIBezierPath {
                  let triangleRect = rect
                  
                  let path = UIBezierPath()
                  let topLeft = CGPointMake(CGRectGetMinX(triangleRect), CGRectGetMinY(triangleRect))
                  let bottomLeft = CGPointMake(CGRectGetMinX(triangleRect), CGRectGetMaxY(triangleRect))
                  let bottomRight = CGPointMake(CGRectGetMaxX(triangleRect), CGRectGetMaxY(triangleRect))
                  
                  path.moveToPoint(topLeft)
                  path.addLineToPoint(bottomLeft)
                  path.addLineToPoint(bottomRight)
                  path.closePath()
                  
                  return path
            }
      }
      
      struct TopTriangle {
            static let rect: CGRect = CGRect(x: 0, y: 0, width: Static.width, height: Static.height)
            static func getVertice(forWidth w: CGFloat, height h: CGFloat) -> CGPoint {
                  
                  let n: CGFloat = 3*w / (7 - 4*Static.a)
                  let x: CGFloat = n
                  
                  let y: CGFloat = (4*h)/(3*w) * x
                  return CGPointMake(x, y)
            }
            
            static func pathInRect() -> UIBezierPath {
                  let triangleRect = rect
                  
                  let path = UIBezierPath()
                  let topLeft = CGPointMake(CGRectGetMinX(triangleRect),CGRectGetMinY(triangleRect))
                  let topRight = CGPointMake(CGRectGetMaxX(triangleRect), topLeft.y)
                  let vertice = getVertice(forWidth: triangleRect.size.width, height: triangleRect.size.height)
                  
                  path.moveToPoint(topLeft)
                  path.addLineToPoint(topRight)
                  path.addLineToPoint(vertice)
                  path.closePath()
                  
                  return path
            }
      }
      
      struct BottomTriangle {
            
            static func pathInRect() -> UIBezierPath {
                  let path = TopTriangle.pathInRect()
                  let transform = CGAffineTransformMakeScale(-1, -1)
                  path.applyTransform(transform)
                  return path
            }
      }
      
      struct RightTriangle {
            static let rect: CGRect = CGRect(x: 0, y: 0, width: Static.width * (1 - Static.a), height: Static.height)
            
            static func pathInRect() -> UIBezierPath {
                  let triangleRect = rect
                  
                  let path = UIBezierPath()
                  let bottomLeft = CGPointMake(rect.origin.x, CGRectGetMaxY(triangleRect))
                  let bottomRight = CGPointMake(CGRectGetMaxX(triangleRect), bottomLeft.y)
                  let topRight = CGPointMake(bottomRight.x, CGRectGetMinY(triangleRect))
                  
                  path.moveToPoint(bottomLeft)
                  path.addLineToPoint(bottomRight)
                  path.addLineToPoint(topRight)
                  path.closePath()
                  return path
            }
      }
      
      
      
      static func maskView(view: UIView, path: UIBezierPath) {
            
            let mask = CAShapeLayer()
            mask.path = path.CGPath
            view.layer.mask = mask
            view.layer.masksToBounds = true
            
            
            let shape = CAShapeLayer()
            shape.path = path.CGPath
            
            shape.frame = view.bounds
            shape.path = path.CGPath
            shape.lineWidth = Static.lineWidth
            shape.strokeColor = UIColor.whiteColor().CGColor
            shape.fillColor = UIColor.clearColor().CGColor
            
            view.layer.addSublayer(shape)
            
      }
      
      static func generateTriangle(triangle: Triangle) -> UIImageView {
            switch triangle {
            case .Left:
                  let rect = LeftTriangle.rect
                  let path = LeftTriangle.rightTrianglePath()
                  
                  let view = UIImageView(frame: rect)
                  maskView(view, path: path)
                  
                  return view
            case .Top(let offset):
                  let rect = TopTriangle.rect
                  let path = TopTriangle.pathInRect()
                  
                  
                  let view = UIImageView(frame: rect)
                  view.frame.origin.x = offset
                  maskView(view, path: path)
                  
                  return view
            case .Bottom(let offset):
                  let rect = TopTriangle.rect
                  let path = TopTriangle.pathInRect()
                  let view = UIImageView(frame: rect)
                  maskView(view, path: path)
                  
                  view.transform = CGAffineTransformMakeScale(-1, -1)
                  
                  view.frame.origin.x = offset
                  
                  return view
            case .Right(let maxX, let down):
                  let rect = down ? RightTriangle.rect : LeftTriangle.rect
                  let path = down ? RightTriangle.pathInRect() : LeftTriangle.rightTrianglePath()
                  let view = UIImageView(frame: rect)
                  let scalar: CGFloat = down ? 1 : -1
                  
                  maskView(view, path: path)
                  view.transform = CGAffineTransformMakeScale(scalar, scalar)
//                  let view: UIImageView
//                  let path: UIBezierPath
//                  if down {
//                        let rect = RightTriangle.rect
//                        view = UIImageView(frame: rect)
//                        path = RightTriangle.pathInRect()
//                        maskView(view, path: path)
//                        
//                        
//                  } else {
//                        
//                        let rect = LeftTriangle.rect
//                        view = UIImageView(frame: rect)
//                        path = LeftTriangle.rightTrianglePath()
//                        maskView(view, path: path)
//                        
//                        view.transform = CGAffineTransformMakeScale(-1, -1)
//                  }
                  
                  
                  view.frame.origin.x = maxX - CGRectGetWidth(path.bounds)

                  return view
            }
      }
      
      
      static func generateTriangles(count: Int) -> [Triangle] {
            var triangles: [Triangle] = []
            var m: CGFloat = 0
            for i in 0...count-1 {
                  if i == 0 {
                        triangles.append(.Left)
                  } else if i == count-1 {
                        let down = i % 2 == 0 ? true : false
                        if !down {
                              let nextInterval = round(CGFloat(count)/3) * Static.width
                              if m < nextInterval {
                                    m = m + Static.width*Static.a - Static.lineWidth
                              }
                              m = min(m,nextInterval)
                        }
                        
                        let maxX = !down ? m + Static.width*Static.a : m + Static.width*(1-Static.a) - Static.lineWidth
                        
                        let right = Triangle.Right(maxX: maxX, down: down)
                        triangles.append(right)
                        
                  } else {
                        let top = i % 2 != 0 ? true : false
                        if top {
                              m -= Static.lineWidth
                              triangles.append(.Top(offset: m))
                              m += Static.width*Static.a
                              
                        } else {
                              m -= Static.lineWidth
                              triangles.append(.Bottom(offset: m))
                              m += Static.width*Static.a*(1-Static.a)
                        }
                  }
            }
            return triangles
      }
      
      
      static func generateViews(count:Int) -> [UIImageView] {
            var views = [UIImageView]()
            let triangles = generateTriangles(count)
            for triangle in triangles {
                  let view = generateTriangle(triangle)
                  switch triangle {
                  case .Bottom:
                        //                        view.frame.origin.x -= 6*Static.a
                        break
                  case .Top:
                        //                        view.frame.origin.x -= 6*Static.a
                        break
                  default:
                        break
                  }
                  views.append(view)
            }
            return views
      }
      
}

extension TriangleHelper.MTriangleData {
      
      static func labelCenter(data: TriangleHelper.MTriangleData, rect: CGRect) -> CGPoint {
            var center = rect.center
            
            let w = CGRectGetWidth(rect)
            let h = CGRectGetHeight(rect)
            switch data.triangle {
            case .Left:
                  center.x -= w/4
                  center.y += h/5
                  break
            case .Top:
                  center.x += w/40
                  center.y -= h/5
                  break
            case .Bottom:
                  center.x += w/16
                  center.y -= h/5
                  break
            case .Right(_,let down):
                  if down {
                        center.x += w/5
                        center.y += h/5
                  } else {
                        center.x -= w/4
                        center.y += h/5
                  }
                  break
            }
            
            print("Returned label center: \(center)")
            return center
      }
}

extension TriangleHelper.Triangle: Equatable {
}
func ==(lhs: TriangleHelper.Triangle, rhs: TriangleHelper.Triangle) -> Bool {
      let tuple = (lhs,rhs)
      switch tuple {
      case (let .Top(offset1), let .Top(offset2)):
            return offset1 == offset2
      case (let .Bottom(offset1), let .Bottom(offset2)):
            return offset1 == offset2
      case (let .Right(max1,down1), let .Right(max2,down2)):
            return max1 == max2 && down1 == down2
      case (.Left, .Left):
            return true
      default:
            return false
      }
}
//      5     switch (lhs, rhs) {
//            6     case (let .UPCA(codeA1, codeB1), let .UPCA(codeA2, codeB2)):
//                  7         return codeA1 == codeA2 && codeB1 == codeB2
//                  8
//            9     case (let .QRCode(code1), let .QRCode(code2)):
//                  10         return code1 == code2
//                  11
//            12     case (.None, .None):
//                  13         return true
//                  14 
//            15     default:
//                  16         return false
//            17     }
//      18 }
//
//typealias Helper = TriangleHelper
//let triangles = generateTriangles(10)
//let data = triangles.enumerate().map { MTriangleData(index: $0.0, triangle: $0.1) }
