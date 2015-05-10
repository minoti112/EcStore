//
//  ItemListViewController.swift
//  EcStore
//
//  Created by takayama minoru on 2015/05/05.
//  Copyright (c) 2015年 minoru takayama. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
//import RMPScrollingMenuBarController
//
//class ItemListViewController: RMPScrollingMenuBarController {
class ItemListViewController: UIViewController {

    @IBOutlet weak var itemListScroll: UIScrollView!
    @IBOutlet weak var itemListItemView: ItemListItemView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createScrollView()

//        delegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        // Customize appearance of menu bar.
//        view.backgroundColor = UIColor.whiteColor()
//        menuBar.indicatorColor = UIColor.blueColor()
//        menuBar.style = RMPScrollingMenuBarStyle.InfinitePaging
////        menuBar.showsIndicator = false;
////        menuBar.showsSeparatorLine = false;
//        
//        // Set ViewControllers for menu bar controller
//        var vc1 = UIViewController()
//        vc1.view.backgroundColor = UIColor.whiteColor()
//        var vc2 = UIViewController()
//        vc2.view.backgroundColor = UIColor.blackColor()
//        var vc3 = UIViewController()
//        vc3.view.backgroundColor = UIColor.redColor()
//        var vc4 = UIViewController()
//        vc4.view.backgroundColor = UIColor.blueColor()
//        var viewControllers = [vc1, vc2, vc3, vc4]
//        
//        setViewControllers(viewControllers as [AnyObject], animated: true)

        // Do any additional setup after loading the view.
    }
    
    private func createScrollView() {
        Alamofire.request(Router.OAuth)
            .validate(statusCode: 200..<400)
            .responseJSON {(request, response, responseData, error) in
            
            println(SwiftyJSON.JSON(responseData!))
                
            if let data: AnyObject = responseData {
                Alamofire.request(Router.ReOAuth)
                    .validate(statusCode: 200..<400)
                    .responseJSON {(request, response, responseData, error) in
                        
                    println(SwiftyJSON.JSON(responseData!))
                    
                    if let data: AnyObject = responseData {
                        let json = SwiftyJSON.JSON(responseData!)
                        let access_token = json["access_token"].string
                        Alamofire.request(Router.ReOAuth)
                            .validate(statusCode: 200..<400)
                            .responseJSON {(request, response, responseData, error) in
                                
                            println(SwiftyJSON.JSON(responseData!))
                                
                        }
                    }
                    if let resError = error {
                        println("Connection failed2.\(resError.localizedDescription)")
                        return
                    }
                }
            }
            if let resError = error {
                println("Connection failed1.\(resError.localizedDescription)")
                return
            }
        }
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
