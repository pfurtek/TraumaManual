//
//  AppDelegate.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 12/20/17.
//  Copyright © 2017 Pawel Furtek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        TraumaModel.shared.createModel()
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = .white
        navigationBarAppearance.barTintColor = UIColor(hex: "#7D110C")
        navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let homeVC = ListTableViewController(nibName: "ListTableViewController", bundle: Bundle.main)
        homeVC.root = true
        homeVC.list = TraumaModel.shared.root.sorted(by: {$0.key < $1.key})
        homeVC.title = "IU Trauma Manual"
        let navigationControllerHome = UINavigationController(rootViewController: homeVC)
        navigationControllerHome.title = "Home"
        
        let bookVC = ListTableViewController(nibName: "ListTableViewController", bundle: Bundle.main)
        bookVC.bookmarks = true
        bookVC.list = TraumaModel.shared.bookmarks.sorted(by: {$0.key < $1.key})
        bookVC.title = "Bookmarks"
        let navigationControllerBook = UINavigationController(rootViewController: bookVC)
        navigationControllerBook.title = "Bookmarks"
        
        let recentVC = ListTableViewController(nibName: "ListTableViewController", bundle: Bundle.main)
        recentVC.recently = true
        recentVC.list = TraumaModel.shared.recentlyViewed
        recentVC.title = "Recently Viewed"
        let navigationControllerRecent = UINavigationController(rootViewController: recentVC)
        navigationControllerRecent.title = "Recently Viewed"
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([navigationControllerHome, navigationControllerBook, navigationControllerRecent], animated: false)
        navigationControllerHome.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        navigationControllerBook.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        navigationControllerRecent.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        tabBarController.tabBar.isTranslucent = false
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

