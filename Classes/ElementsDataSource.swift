//
//  ElementsDataSource.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Protocol that defines information each Element tableview datasource must provide.
*/


import UIKit

@objc(ElementsDataSource)
protocol ElementsDataSource: NSObjectProtocol {
    
    // these properties are used by the view controller
    // for the navigation and tab bar
    var name: String {get}
    var navigationBarName: String {get}
    var tabBarImage: UIImage {get}
    
    // this property determines the style of table view displayed
    var tableViewStyle: UITableView.Style {get}
    
    // provides a standardized means of asking for the element at the specific
    // index path, regardless of the sorting or display technique for the specific
    // datasource
    func atomicElementForIndexPath(_ indexPath: IndexPath) -> AtomicElement?
    
    // this optional protocol allows us to send the datasource this message, since it has the
    // required information
    @objc optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    
}
