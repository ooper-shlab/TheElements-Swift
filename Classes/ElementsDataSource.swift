//
//  ElementsDataSource.swift
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
//Protocol that defines information each Element tableview datasource must provide.
//*/
//
//
//@import UIKit;
import UIKit
//#import "AtomicElement.h"
//
//@protocol ElementsDataSource <NSObject>
@objc(ElementsDataSource)
protocol ElementsDataSource: NSObjectProtocol {
//
//@required
//
//// these properties are used by the view controller
//// for the navigation and tab bar
//@property (readonly) NSString *name;
    var name: String {get}
//@property (readonly) NSString *navigationBarName;
    var navigationBarName: String {get}
//@property (readonly) UIImage *tabBarImage;
    var tabBarImage: UIImage {get}
//
//// this property determines the style of table view displayed
//@property (readonly) UITableViewStyle tableViewStyle;
    var tableViewStyle: UITableViewStyle {get}
//
//// provides a standardized means of asking for the element at the specific
//// index path, regardless of the sorting or display technique for the specific
//// datasource
//- (AtomicElement *)atomicElementForIndexPath:(NSIndexPath *)indexPath;
    func atomicElementForIndexPath(indexPath: NSIndexPath) -> AtomicElement?
//
//@optional
//
//// this optional protocol allows us to send the datasource this message, since it has the
//// required information
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
    optional func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
//
//@end
}