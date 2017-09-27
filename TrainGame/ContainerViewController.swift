//
//  ContainerViewController.swift
//  TrainGame
//
//  Created by Gregory Weiss on 9/27/17.
//  Copyright © 2017 gerusa04. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    var sideMenuIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func toggleSideMenu() {
        print("Recieved notification")
        if sideMenuIsOpen {
            sideMenuIsOpen = false
            sideMenuConstraint.constant = -240
        } else {
            sideMenuIsOpen = true
            sideMenuConstraint.constant = 0
        }
        self.view.setNeedsDisplay()
        
    }
    


}
