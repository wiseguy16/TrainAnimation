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
    var otherTap = UITapGestureRecognizer()
    var circleTap = UITapGestureRecognizer()
    var trainPassCount = 0
    var pnt1 = CGPoint()
    var pnt2 = CGPoint()
    var pnt3 = CGPoint()
    var timer: Timer?

    let imageView1 = UIImageView(image: #imageLiteral(resourceName: "trainEngine"))
    let imageView2 = UIImageView(image: #imageLiteral(resourceName: "trainCars"))
    let imageView3 = UIImageView(image: #imageLiteral(resourceName: "trainCars"))



    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showSettings), name: NSNotification.Name("ShowSettings"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showProfile), name: NSNotification.Name("ShowProfile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showLogin), name: NSNotification.Name("ShowSignIn"), object: nil)
        
        imageView1.frame = CGRect(x: 100, y: 100, width: 75, height: 93)
        imageView2.frame = CGRect(x: 400, y: 300, width: 75, height: 93)
        imageView1.isUserInteractionEnabled = true
        
        imageView3.frame = CGRect(x: 350, y: 350, width: 75, height: 93)

        
        let curvedView = CurvedView(frame: view.frame)
        curvedView.backgroundColor = .lightGray
        view.addSubview(curvedView)
        view.addSubview(imageView2)
        view.addSubview(imageView1)

        firstTap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        otherTap = UITapGestureRecognizer(target: self, action: #selector(moveObject))
        circleTap = UITapGestureRecognizer(target: self, action: #selector(moveInCircle))
        
        //view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        //view.addGestureRecognizer(firstTap)
        imageView1.addGestureRecognizer(otherTap)
        
        imageView3.addGestureRecognizer(circleTap)
        imageView3.isUserInteractionEnabled = true
        view.addSubview(imageView3)


        pnt1 = imageView1.center
        pnt2.x = pnt1.x + CGFloat(700.0)
        pnt2.y = pnt1.y
        pnt3.x = pnt1.x + CGFloat(775.0)
        pnt3.y = pnt1.y - CGFloat(1.0)
        timer = Timer()

 
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
    
    @objc func showSettings() {
        performSegue(withIdentifier: "SettingsSegue", sender: nil)
    }
    
    @objc func showProfile() {
        performSegue(withIdentifier: "ProfileSegue", sender: nil)
    }
    
    @objc func showLogin() {
        performSegue(withIdentifier: "LoginSegue", sender: nil)
    }
    
    @IBAction func menuToggleTapped(_ sender: UIBarButtonItem) {
        print("menu toggled")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    
    func method(completion: (Bool) -> ()) {
        print("First line of code executed")
        // do stuff here to determine what you want to send back.
        // we are just sending the Boolean value that was sent in "back"
        completion(true)
    }
    
    func moveInCircle() {
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "trainCars"))
//        imageView.frame = CGRect(x: 300, y: 300, width: 75, height: 93)
        
        let newAnimation = makeAnimationForTrain(aPath: circularPath().cgPath)
        imageView3.layer.add(newAnimation, forKey: nil)
        
        //view.addSubview(imageView)

        
    }
    
    func moveObject() {
       // guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(moveUpThenDown), userInfo: nil, repeats: true)
        timer?.fire()
        
        UIView.animate(withDuration: 4.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.imageView1.center = self.pnt2
        }) { (true) in
            self.moveCars()
        }
    }
    
 /*@objc*/ func moveUpThenDown() {
        UIView.animate(withDuration: 0.4, animations: {
            self.imageView1.transform = CGAffineTransform(translationX: 0, y: -30)
        }) { (true) in
            self.moveDown()
        }
    }
    
    func moveDown() {
        UIView.animate(withDuration: 0.4) {
            self.imageView1.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    func moveCars() {
        UIView.animate(withDuration: 3.0, animations: { 
            self.imageView2.center = self.pnt3
        }) { (true) in
            self.timer?.invalidate()
        }
    }
    
    
    func bounceTrain() {
        UIView.animate(withDuration: 0.5, animations: { 
            self.imageView1.transform = CGAffineTransform(translationX: 0, y: -30)
        }) { (true) in
            self.imageView1.transform = CGAffineTransform(translationX: 0, y: 0)
        }
//        UIView.animate(withDuration: 0.5) { 
//            self.imageView1.transform = CGAffineTransform(translationX: 0, y: -30)
//
//        }
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.autoreverse], animations: {
//            self.imageView1.transform = CGAffineTransform(translationX: 0, y: -30)
//        }) { (true) in
//            //self.imageView1.transform = CGAffineTransform(translationX: 0, y: 0)
//        }
    }
    
    func newBounceTrain() {
        //
    }
    
    func moveObjectWithCurve() {
        UIView.animate(withDuration: 4.0, delay: 0.0, options: .curveEaseInOut, animations: { 
            //
        }) { (true) in
            //
        }
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

func circularPath() -> UIBezierPath {
   // let screenSize = UIScreen.main.bounds
    //let screenEndX = screenSize.width/2
    //let screenBeginX = screenSize.width - screenSize.width
    //let screenHeight = screenSize.height
    //let halfHeight = screenHeight/2
    
    let cp10 = CGPoint(x: 350, y: 350)
    let cp20 = CGPoint(x: 600, y: 450)
    let cp30 = CGPoint(x: 600, y: 600)
    let cp40 = CGPoint(x: 350, y: 750)
    let cp50 = CGPoint(x: 150, y: 450)
    let cp60 = CGPoint(x: 150, y: 600)

    
    let path = UIBezierPath()
    path.move(to: cp10)
    path.addCurve(to: cp40, controlPoint1: cp20, controlPoint2: cp30)
    path.addCurve(to: cp10, controlPoint1: cp60, controlPoint2: cp50)
   // path.addArc(withCenter: cp30, radius: 75, startAngle: 45, endAngle: 45, clockwise: true)
    
//    path.move(to: CGPoint(x: screenBeginX, y: halfHeight))
//    let endPoint = CGPoint(x: screenEndX , y: halfHeight)
    
//    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    
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







