//
//  ItemListViewController.swift
//  EcStore
//
//  Created by takayama minoru on 2015/05/05.
//  Copyright (c) 2015年 minoru takayama. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidAppear(animated: Bool) {
//        navigationController?.navigationBar.hidden = true
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        navigationController?.navigationBar.hidden = false
//    }
    
    override func viewWillAppear(animated: Bool) {
        
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //シャドウの設定
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5.0
        view.layer.shadowColor = UIColor.grayColor().CGColor
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        appDelegate.slidingViewController?.underLeftViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SideMenu") as! UIViewController
        appDelegate.slidingViewController?.anchorRightPeekAmount = 100.0
    }
    
    @IBAction func pushMenuButton(sender: AnyObject) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        view.addGestureRecognizer(appDelegate.slidingViewController!.panGesture)
        appDelegate.slidingViewController.anchorTopViewToRightAnimated(true)
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
