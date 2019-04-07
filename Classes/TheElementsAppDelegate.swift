//
//  TheElementsAppDelegate.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Application delegate that sets up the application.
*/

import UIKit

@UIApplicationMain
@objc(TheElementsAppDelegate)
class TheElementsAppDelegate: NSObject, UIApplicationDelegate {
    
    
    // each data source responsible for backing our 4 varying table view controllers
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // for each tableview 'screen' we need to create a datasource instance
        // (the class that is passed in) we then need to create an instance of
        // ElementsTableViewController with that datasource instance finally we need to return
        // a UINaviationController for each screen, with the ElementsTableViewController as the
        // root view controller.
        //
        let tabBarController = self.window!.rootViewController as! UITabBarController
        
        // the class type for the datasource is not crucial, but that it implements the
        // ElementsDataSource protocol and the UITableViewDataSource Protocol
        //
        
        let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        var viewControllers: [UINavigationController] = []
        viewControllers.reserveCapacity(4)
        
        // create our tabbar view controllers, since we already have one defined in our storyboard
        // we will create 3 more instances of it, and assign each it's own kind data source
        
        // by name
        var navController = storyboard.instantiateViewController(withIdentifier: "navForTableView") as! UINavigationController
        var viewController =
        navController.topViewController as! ElementsTableViewController
        var dataSource: ElementsDataSource & UITableViewDataSource = ElementsSortedByNameDataSource()
        viewController.dataSource = dataSource
        viewControllers.append(navController)
        
        // by atomic number
        navController = storyboard.instantiateViewController(withIdentifier: "navForTableView") as! UINavigationController
        viewController = navController.topViewController as! ElementsTableViewController
        dataSource = ElementsSortedByAtomicNumberDataSource()
        viewController.dataSource = dataSource
        viewControllers.append(navController)
        
        // by symbol
        navController = storyboard.instantiateViewController(withIdentifier: "navForTableView") as! UINavigationController
        viewController = navController.topViewController as! ElementsTableViewController
        dataSource = ElementsSortedBySymbolDataSource()
        viewController.dataSource = dataSource
        viewControllers.append(navController)
        
        // by state
        navController = storyboard.instantiateViewController(withIdentifier: "navForTableView") as! UINavigationController
        viewController = navController.topViewController as! ElementsTableViewController
        dataSource = ElementsSortedByStateDataSource()
        viewController.dataSource = dataSource
        viewControllers.append(navController)
        
        tabBarController.viewControllers = viewControllers
        
        return true
    }
    
}
