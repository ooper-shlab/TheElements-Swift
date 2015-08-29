//
//  TheElementsAppDelegate.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
///*
//Copyright (C) 2015 Apple Inc. All Rights Reserved.
//See LICENSE.txt for this sample’s licensing information
//
//Abstract:
//Application delegate that sets up the application.
//*/
//
//@import UIKit;
import UIKit
//
//@interface TheElementsAppDelegate : NSObject  <UIApplicationDelegate>
@UIApplicationMain
@objc(TheElementsAppDelegate)
class TheElementsAppDelegate: NSObject, UIApplicationDelegate {
//
//
//@end
//
//
//#import "TheElementsAppDelegate.h"
//#import "ElementsTableViewController.h"
//
//// each data source responsible for backing our 4 varying table view controllers
//#import "ElementsSortedByNameDataSource.h"
//#import "ElementsSortedByAtomicNumberDataSource.h"
//#import "ElementsSortedBySymbolDataSource.h"
//#import "ElementsSortedByStateDataSource.h"
//
//@implementation TheElementsAppDelegate
//
//@synthesize window;
    var window: UIWindow?
//
//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
//
//    // for each tableview 'screen' we need to create a datasource instance
//    // (the class that is passed in) we then need to create an instance of
//    // ElementsTableViewController with that datasource instance finally we need to return
//    // a UINaviationController for each screen, with the ElementsTableViewController as the
//    // root view controller.
//    //
//    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        let tabBarController = self.window!.rootViewController as! UITabBarController
//
//    // the class type for the datasource is not crucial, but that it implements the
//	// ElementsDataSource protocol and the UITableViewDataSource Protocol
//    //
//    id<ElementsDataSource, UITableViewDataSource> dataSource;
//
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
//    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:4];
        var viewControllers: [UINavigationController] = []
        viewControllers.reserveCapacity(4)
//
//    // create our tabbar view controllers, since we already have one defined in our storyboard
//    // we will create 3 more instances of it, and assign each it's own kind data source
//
//    // by name
//    UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
        var navController = storyboard.instantiateViewControllerWithIdentifier("navForTableView") as! UINavigationController
//    ElementsTableViewController *viewController =
        var viewController =
//        (ElementsTableViewController *)[navController topViewController];
            navController.topViewController as! ElementsTableViewController
//    dataSource = [[ElementsSortedByNameDataSource alloc] init];
        var dataSource: protocol<ElementsDataSource, UITableViewDataSource> = ElementsSortedByNameDataSource()
//    viewController.dataSource = dataSource;
        viewController.dataSource = dataSource
//    [viewControllers addObject:navController];
        viewControllers.append(navController)
//
//    // by atomic number
//    navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
        navController = storyboard.instantiateViewControllerWithIdentifier("navForTableView") as! UINavigationController
//    viewController = (ElementsTableViewController *)[navController topViewController];
        viewController = navController.topViewController as! ElementsTableViewController
//    dataSource = [[ElementsSortedByAtomicNumberDataSource alloc] init];
        dataSource = ElementsSortedByAtomicNumberDataSource()
//    viewController.dataSource = dataSource;
        viewController.dataSource = dataSource
//    [viewControllers addObject:navController];
        viewControllers.append(navController)
//
//    // by symbol
//    navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
        navController = storyboard.instantiateViewControllerWithIdentifier("navForTableView") as! UINavigationController
//    viewController = (ElementsTableViewController *)[navController topViewController];
        viewController = navController.topViewController as! ElementsTableViewController
//    dataSource = [[ElementsSortedBySymbolDataSource alloc] init];
        dataSource = ElementsSortedBySymbolDataSource()
//    viewController.dataSource = dataSource;
        viewController.dataSource = dataSource
//    [viewControllers addObject:navController];
        viewControllers.append(navController)
//
//    // by state
//    navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
        navController = storyboard.instantiateViewControllerWithIdentifier("navForTableView") as! UINavigationController
//    viewController = (ElementsTableViewController *)[navController topViewController];
        viewController = navController.topViewController as! ElementsTableViewController
//    dataSource = [[ElementsSortedByStateDataSource alloc] init];
        dataSource = ElementsSortedByStateDataSource()
//    viewController.dataSource = dataSource;
        viewController.dataSource = dataSource
//    [viewControllers addObject:navController];
        viewControllers.append(navController)
//
//    tabBarController.viewControllers = viewControllers;
        tabBarController.viewControllers = viewControllers
//
//    return YES;
        return true
//}
    }
//
//@end
//
}