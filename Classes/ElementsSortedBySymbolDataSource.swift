//
//  ElementsSortedBySymbolDataSource.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Provides the table view data for the elements sorted by atomic symbol.
*/

import UIKit

@objc(ElementsSortedBySymbolDataSource)
class ElementsSortedBySymbolDataSource: NSObject, UITableViewDataSource, ElementsDataSource {
    
    
    // protocol methods for "ElementsDataSourceProtocol"
    
    // return the data used by the navigation controller and tab bar item
    
    var navigationBarName: String {
        
        return "Sorted by Atomic Symbol"
    }
    
    var name: String {
        
        return "Symbol"
    }
    
    var tabBarImage: UIImage {
        
        return UIImage(named: "symbol_gray.png")!
    }
    
    // atomic number is displayed in a plain style tableview
    var tableViewStyle: UITableViewStyle {
        
        return .plain
    }
    
    // return the atomic element at the index in the sorted by symbol array
    func atomicElementForIndexPath(_ indexPath: IndexPath) -> AtomicElement? {
        
        return PeriodicElements.sharedPeriodicElements.elementsSortedBySymbol[indexPath.row]
    }
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "AtomicElementTableViewCell")! as! AtomicElementTableViewCell
        
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
        // ask for, and return, the number of elements in the array of elements sorted by symbol
        
        return PeriodicElements.sharedPeriodicElements.elementsSortedBySymbol.count
    }
    
}
