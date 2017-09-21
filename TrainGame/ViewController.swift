//
//  ViewController.swift
//  TrainGame
//
//  Created by Gregory Weiss on 9/18/17.
//  Copyright © 2017 gerusa04. All rights reserved.
//

import UIKit

let cp1 = CGPoint(x: 300, y: 100)
let cp2 = CGPoint(x: 500, y: 900)
let cp3 = CGPoint(x: 300, y: 100)
let cp4 = CGPoint(x: 500, y: 900)



class ViewController: UIViewController {
    var firstTap = UITapGestureRecognizer()
    var trainPassCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let curvedView = CurvedView(frame: view.frame)
        curvedView.backgroundColor = .lightGray
        view.addSubview(curvedView)
         firstTap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
       // view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        view.addGestureRecognizer(firstTap)
 
//        yourFunctionName {
//            
//            //do something here after running your function
//            print("Tada!!!!")
//        }
        
        yourFunctionName { () -> Void in
            print("completion happening")
        }
        
        method(completion: { (success) -> Void in
            print("Second line of code executed")
            if success { // this will be equal to whatever value is set in this method call
                print("true")
            } else {
                print("false")
            }
        })

    }
    
    func method(completion: (Bool) -> ()) {
        print("First line of code executed")
        // do stuff here to determine what you want to send back.
        // we are just sending the Boolean value that was sent in "back"
        completion(true)
    }
    
 
    
    func handleTap() {
      //  (0...10).forEach { (_) in
         //   generateAnimatedTrains()
        trainPassCount += 1
        firstTap.isEnabled = false
        if trainPassCount % 2 == 0 {
            forwardMoveSteamEngine {
                self.firstTap.isEnabled = true
            }
        } else {
            backUpSteamEngine {
                self.firstTap.isEnabled = true
            }
        }
    }
    
    func yourFunctionName(animationFinished: () -> Void) {
        print("Doing something!")
        //animationFinished()
        
    }
    
    func backUpSteamEngine(animationFinished: @escaping () -> Void) {
        //let image = drand48() > 0.5 ? #imageLiteral(resourceName: "trainEngine") : #imageLiteral(resourceName: "trainCars")
        let imageView = UIImageView(image: #imageLiteral(resourceName: "trainEngine"))
        imageView.frame = CGRect(x: 0, y: 0, width: 75, height: 93)
        let newAnimation = makeAnimationForTrain(aPath: backwardsPath().cgPath)
        imageView.layer.add(newAnimation, forKey: nil)
        
        view.addSubview(imageView)
        delay(bySeconds: 4.0, dispatchLevel: .background) {
            // delayed code that will run on background thread
            animationFinished()
        }
    }
    
    func forwardMoveSteamEngine(animationFinished: @escaping () -> Void) {
        let imageView1 = UIImageView(image: #imageLiteral(resourceName: "trainEngine"))
        let imageView2 = UIImageView(image: #imageLiteral(resourceName: "trainCars"))

        imageView1.frame = CGRect(x: 0, y: 0, width: 75, height: 93)
        imageView2.frame = CGRect(x: 0, y: 0, width: 75, height: 93)
        imageView1.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        imageView2.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))

        //imageView1.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi - 3.14159))
        
        let newAnimation = makeAnimationForTrain(aPath: forwardsPath().cgPath)
        imageView1.layer.add(newAnimation, forKey: nil)
        imageView2.layer.add(newAnimation, forKey: nil)
        view.addSubview(imageView1)
        
        delay(bySeconds: 0.25) {
            self.view.addSubview(imageView2)
        }
        
        delay(bySeconds: 4.0, dispatchLevel: .background) {
            // delayed code that will run on background thread
            animationFinished()
        }
    }

    
    func generateAnimatedTrains() {
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "trainEngine") : #imageLiteral(resourceName: "trainCars")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 75, height: 93)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = backwardsPath().cgPath
        animation.duration = 4 + drand48() * 3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.rotationMode = kCAAnimationRotateAuto
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        imageView.layer.add(animation, forKey: nil)
        
        view.addSubview(imageView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

func makeAnimationForTrain(aPath: CGPath) -> CAKeyframeAnimation {
    let animation = CAKeyframeAnimation(keyPath: "position")
    animation.path = aPath //forwardsPath().cgPath
    animation.duration = 4.0 //+ drand48() * 3
    animation.fillMode = kCAFillModeForwards
    animation.isRemovedOnCompletion = false
    animation.rotationMode = kCAAnimationRotateAuto
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    return animation
}


func customPath() -> UIBezierPath {
    let screenSize = UIScreen.main.bounds
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height
    let halfHeight = screenHeight/2

    let path = UIBezierPath()
    //path.move(to: CGPoint(x: 0, y: 200))
    path.move(to: CGPoint(x: 0, y: halfHeight))
    
    let endPoint = CGPoint(x: screenWidth , y: halfHeight)
    
    // path.addLine(to: endPoint)
    let randomYShift = halfHeight + CGFloat(drand48() * 300)
    let cp1 = CGPoint(x: 100, y: 100 - randomYShift)
    let cp2 = CGPoint(x: 200, y: 300 + randomYShift)
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

func backwardsPath() -> UIBezierPath {
    let screenSize = UIScreen.main.bounds
    let screenEndX = screenSize.width + 100
    let screenBeginX = screenSize.width - screenSize.width - 75
    let screenHeight = screenSize.height
    let halfHeight = screenHeight/2
    
    let path = UIBezierPath()
    
    path.move(to: CGPoint(x: screenBeginX, y: halfHeight))
    let endPoint = CGPoint(x: screenEndX , y: halfHeight)
    
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    
    return path
}


func forwardsPath() -> UIBezierPath {
    let screenSize = UIScreen.main.bounds
    let screenEndX = screenSize.width + 100
    let screenBeginX = screenSize.width - screenSize.width - 75
    let screenHeight = screenSize.height
    let halfHeight = screenHeight/2
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: screenEndX, y: halfHeight))
    let endPoint = CGPoint(x: screenBeginX , y: halfHeight)
    path.addCurve(to: endPoint, controlPoint1: cp4, controlPoint2: cp3)
    return path
}

func forwardsPath2() -> UIBezierPath {
    let screenSize = UIScreen.main.bounds
    let screenEndX = screenSize.width + 50
    let screenBeginX = screenSize.width - screenSize.width - 100
    let screenHeight = screenSize.height
    let halfHeight = screenHeight/2
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: screenEndX, y: halfHeight))
    let endPoint = CGPoint(x: screenBeginX , y: halfHeight)
    
    let cp2 = CGPoint(x: 100, y: 100)
    let cp1 = CGPoint(x: 500, y: 900)
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}







