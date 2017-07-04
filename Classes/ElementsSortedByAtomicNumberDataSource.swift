//
//  ElementsSortedByAtomicNumberDataSource.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Provides the table view data for the elements sorted by atomic number.
*/

import UIKit

@objc(ElementsSortedByAtomicNumberDataSource)
class ElementsSortedByAtomicNumberDataSource: NSObject, UITableViewDataSource, ElementsDataSource {
    
    
    // protocol methods for "ElementsDataSourceProtocol"
    
    // return the data used by the navigation controller and tab bar item
    
    var navigationBarName: String {
        
        return "Sorted by Atomic Number"
    }
    
    var name: String {
        
        return "Number"
    }
    
    var tabBarImage: UIImage {
        
        return UIImage(named: "number_gray.png")!
    }
    
    // atomic number is displayed in a plain style tableview
    var tableViewStyle: UITableViewStyle {
        
        return .plain
    }
    
    // return the atomic element at the index in the sorted by numbers array
    func atomicElementForIndexPath(_ indexPath: IndexPath) -> AtomicElement? {
        
        return PeriodicElements.sharedPeriodicElements.elementsSortedByNumber[indexPath.row]
    }
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "AtomicElementTableViewCell") as! AtomicElementTableViewCell
        
        // set the element for this cell as specified by the datasource. The atomicElementForIndexPath: is declared
        // as part of the ElementsDataSource Protocol and will return the appropriate element for the index row
        //
        cell.element = self.atomicElementForIndexPath(indexPath)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // this table has only one section
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // get the shared elements object
        // ask for, and return, the number of elements in the array of elements sorted by number
        return PeriodicElements.sharedPeriodicElements.elementsSortedByNumber.count
    }
    
}
