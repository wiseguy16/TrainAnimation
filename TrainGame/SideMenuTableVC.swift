//
//  SideMenuTableVC.swift
//  TrainGame
//
//  Created by Gregory Weiss on 9/27/17.
//  Copyright © 2017 gerusa04. All rights reserved.
//

import UIKit

class SideMenuTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        switch indexPath.row {
        case 0:
            NotificationCenter.default.post(name: NSNotification.Name("ShowProfile"), object: nil)
        case 1:
            NotificationCenter.default.post(name: NSNotification.Name("ShowSettings"), object: nil)
        case 2:
            NotificationCenter.default.post(name: NSNotification.Name("ShowSignIn"), object: nil)
        default:
            break
        }
        //
    }
    
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)

    }


}
