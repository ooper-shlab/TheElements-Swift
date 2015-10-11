//
//  ElementsTableViewController.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Coordinates the tableviews and element data sources. It also responds to changes of selection in the table view and provides the cells.
*/

import UIKit

@objc(ElementsTableViewController)
class ElementsTableViewController: UITableViewController {
    
    var dataSource: protocol<ElementsDataSource, UITableViewDataSource>? {
        didSet {didSetDataSource(oldValue)}
    }
    
    
    private func didSetDataSource(oldDataSource: protocol<ElementsDataSource, UITableViewDataSource>?) {
        
        // retain the data source
        
        // set the title, and tab bar images from the dataSource
        // object. These are part of the ElementsDataSource Protocol
        self.title = dataSource?.name
        self.tabBarItem.image = dataSource?.tabBarImage
        
        // set the long name shown in the navigation bar
        self.navigationItem.title = dataSource?.navigationBarName
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.sectionIndexMinimumDisplayRowCount = 10
        
        self.tableView.delegate = self
        self.tableView.dataSource = self.dataSource
        
        // create a custom navigation bar button and set it to always say "back"
        let temporaryBarButtonItem = UIBarButtonItem()
        temporaryBarButtonItem.title = "Back"
        self.navigationItem.backBarButtonItem = temporaryBarButtonItem
    }
    
    
    //MARK: - UITableViewDelegate
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {
            
            let selectedIndexPath = self.tableView.indexPathForSelectedRow!
            
            // find the right view controller
            let element = self.dataSource?.atomicElementForIndexPath(selectedIndexPath)
            let viewController =
            segue.destinationViewController as! AtomicElementViewController
            
            // hide the bottom tabbar when we push this view controller
            viewController.hidesBottomBarWhenPushed = true
            
            // pass the element to this detail view controller
            viewController.element = element
        }
    }
    
}