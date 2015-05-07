//
//  AppDelegate.swift
//  EcStore
//
//  Created by takayama minoru on 2015/05/05.
//  Copyright (c) 2015年 minoru takayama. All rights reserved.
//

import UIKit
import ECSlidingViewController
import RMPScrollingMenuBarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RMPScrollingMenuBarControllerDelegate {

    var window: UIWindow?
    var slidingViewController: ECSlidingViewController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOpßtions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        setupSideMenu()
        setupItemList()
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
    
    private func setupItemList() {
        var menuController = RMPScrollingMenuBarController()
        menuController.delegate = self
        
        // Customize appearance of menu bar.
        menuController.view.backgroundColor = UIColor.whiteColor()
        menuController.menuBar.indicatorColor = UIColor.blueColor()
        menuController.menuBar.style = RMPScrollingMenuBarStyle.InfinitePaging;
//        menuController.menuBar.showsIndicator = false;
//        menuController.menuBar.showsSeparatorLine = false;
        
        // Set ViewControllers for menu bar controller
        var viewControllers = NSMutableArray()
        for i in 0..<10 {
            var vc = ItemListViewController()
            vc.view.backgroundColor = UIColor.whiteColor()
//            vc.view.backgroundColor = [UIColor colorWithWhite:0.3+0.05*i alpha:1.0];
//            vc.message = "Message for No.\(i)"
            viewControllers.addObject(vc)
        }
        
        menuController.setViewControllers(viewControllers as [AnyObject], animated: true)
        var naviController = UINavigationController(rootViewController: menuController)
        window!.rootViewController = naviController
        window?.makeKeyAndVisible()
    }

    func menuBarController(menuBarController: RMPScrollingMenuBarController, menuBarItemAtIndex:NSInteger) -> RMPScrollingMenuBarItem {
        var item = RMPScrollingMenuBarItem()
        item.title = "Title \(menuBarItemAtIndex + 1)"
        return item
    }
}

