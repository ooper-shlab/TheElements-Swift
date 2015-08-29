//
//  ElementsTableViewController.swift
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
//Coordinates the tableviews and element data sources. It also responds to changes of selection in the table view and provides the cells.
//*/
//
//@import UIKit;
import UIKit
//#import "ElementsDataSourceProtocol.h"
//
//@interface ElementsTableViewController : UITableViewController
@objc(ElementsTableViewController)
class ElementsTableViewController: UITableViewController {
//
//@property (nonatomic,strong) id<ElementsDataSource, UITableViewDataSource> dataSource;
    var dataSource: protocol<ElementsDataSource, UITableViewDataSource>? {
        didSet {didSetDataSource(oldValue)}
    }
//
//@end
//
//
//#import "ElementsTableViewController.h"
//#import "AtomicElementViewController.h"
//
//
//@implementation ElementsTableViewController
//
//- (void)setDataSource:(id<ElementsDataSource,UITableViewDataSource>)dataSource {
    private func didSetDataSource(oldDataSource: protocol<ElementsDataSource, UITableViewDataSource>?) {
//
//    // retain the data source
//    _dataSource = dataSource;
//
//    // set the title, and tab bar images from the dataSource
//    // object. These are part of the ElementsDataSource Protocol
//    self.title = [_dataSource name];
        self.title = dataSource?.name
//    self.tabBarItem.image = [_dataSource tabBarImage];
        self.tabBarItem.image = dataSource?.tabBarImage
//
//    // set the long name shown in the navigation bar
//    self.navigationItem.title = [_dataSource navigationBarName];
        self.navigationItem.title = dataSource?.navigationBarName
//}
    }
//
//- (void)viewDidLoad {
    override func viewDidLoad() {
//
//    [super viewDidLoad];
        super.viewDidLoad()
//
//    self.tableView.sectionIndexMinimumDisplayRowCount = 10;
        self.tableView.sectionIndexMinimumDisplayRowCount = 10
//
//    self.tableView.delegate = self;
        self.tableView.delegate = self
//	self.tableView.dataSource = self.dataSource;
        self.tableView.dataSource = self.dataSource
//
//    // create a custom navigation bar button and set it to always say "back"
//    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
        let temporaryBarButtonItem = UIBarButtonItem()
//    temporaryBarButtonItem.title = @"Back";
        temporaryBarButtonItem.title = "Back"
//    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
        self.navigationItem.backBarButtonItem = temporaryBarButtonItem
//}
    }
//
//
//#pragma mark - UITableViewDelegate
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//
//    if ([segue.identifier isEqualToString:@"showDetail"]) {
        if segue.identifier == "showDetail" {
//        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
            let selectedIndexPath = self.tableView.indexPathForSelectedRow!
//
//        // find the right view controller
//        AtomicElement *element = [self.dataSource atomicElementForIndexPath:selectedIndexPath];
            let element = self.dataSource?.atomicElementForIndexPath(selectedIndexPath)
//        AtomicElementViewController *viewController =
            let viewController =
//            (AtomicElementViewController *)segue.destinationViewController;
                segue.destinationViewController as! AtomicElementViewController
//
//        // hide the bottom tabbar when we push this view controller
//        viewController.hidesBottomBarWhenPushed = YES;
            viewController.hidesBottomBarWhenPushed = true
//
//        // pass the element to this detail view controller
//        viewController.element = element;
            viewController.element = element
//    }
        }
//}
    }
//
//@end
}