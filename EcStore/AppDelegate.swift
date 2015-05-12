//
//  AppDelegate.swift
//  EcStore
//
//  Created by takayama minoru on 2015/05/05.
//  Copyright (c) 2015年 minoru takayama. All rights reserved.
//

import UIKit
import ECSlidingViewController
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var slidingViewController: ECSlidingViewController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOpßtions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        setupSideMenu()
        setAccessToken()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func setupSideMenu() {
        slidingViewController = window!.rootViewController as? ECSlidingViewController
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        slidingViewController!.topViewController = mainStoryboard.instantiateViewControllerWithIdentifier("itemListNav") as! UIViewController
    }

    private func setAccessToken() {
//        Alamofire.request(Router.OAuth)
//            .validate(statusCode: 200..<400)
//            .responseJSON {(request, response, responseData, error) in
//                if let data: AnyObject = responseData {
//                    let json = SwiftyJSON.JSON(data)
//                    var userDefault = NSUserDefaults.standardUserDefaults()
//                    userDefault.setObject(json["refresh_token"].string, forKey: "refresh_token")
//                    userDefault.synchronize()
//        println(json["refresh_token"].string)
                    Alamofire.request(Router.ReOAuth)
                        .validate(statusCode: 200..<400)
                        .responseJSON {(request, response, responseData, error) in
                            if let data: AnyObject = responseData {
                                let json = SwiftyJSON.JSON(responseData!)
                                var userDefault = NSUserDefaults.standardUserDefaults()
                                userDefault.setObject(json["access_token"].string, forKey: "access_token")
                                userDefault.synchronize()
                                println(json["access_token"].string)
                            }
                            if let resError = error {
                                println("Connection failed2.\(resError.localizedDescription)")
                                return
                            }
                }
//                if let resError = error {
//                    println("Connection failed1.\(resError.localizedDescription)")
//                    return
//                }
//        }
    }
//    func menuBarController(menuBarController: RMPScrollingMenuBarController, menuBarItemAtIndex:NSInteger) -> RMPScrollingMenuBarItem {
//        var item = RMPScrollingMenuBarItem()
//        item.title = "Title \(menuBarItemAtIndex + 1)"
//        return item
//    }
}

