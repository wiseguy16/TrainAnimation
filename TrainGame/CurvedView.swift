//
//  CurvedView.swift
//  TrainGame
//
//  Created by Gregory Weiss on 9/18/17.
//  Copyright © 2017 gerusa04. All rights reserved.
//

import UIKit

class CurvedView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 200))
//        
//        let endPoint = CGPoint(x: 400, y: 200)
//     //   let endPoint2 = CGPoint(x: self.view.frame.bounds, y: 200)
//        
//        // path.addLine(to: endPoint)
//        let cp1 = CGPoint(x: 100, y: 100)
//        let cp2 = CGPoint(x: 200, y: 300)
//        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        
        //let path = customPath()
        let path1 = backwardsPath()
        path1.lineWidth = 3
        path1.stroke()
        
        let path2 = forwardsPath()
        path2.lineWidth = 3
        path2.stroke()
        
        let path3 = circularPath()
        path3.lineWidth = 3
        path3.stroke()


        
    }
    

}


