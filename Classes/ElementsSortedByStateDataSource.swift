//
//  ElementsSortedByStateDataSource.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Provides the table view data for the elements sorted by their standard physical state.
*/

import UIKit

@objc(ElementsSortedByStateDataSource)
class ElementsSortedByStateDataSource: NSObject, UITableViewDataSource, ElementsDataSource {
    
    
    // protocol methods for "ElementsDataSourceProtocol"
    
    // return the data used by the navigation controller and tab bar item
    
    var name: String {
        
        return "State"
    }
    
    var navigationBarName: String {
        
        return "Grouped by State"
    }
    
    var tabBarImage: UIImage {
        
        return UIImage(named: "state_gray.png")!
    }
    
    // atomic state is displayed in a grouped style tableview
    var tableViewStyle: UITableView.Style {
        
        return .plain
    }
    
    // return the atomic element at the index
    func atomicElementForIndexPath(_ indexPath: IndexPath) -> AtomicElement? {
        
        // this table has multiple sections. One for each physical state
        // [solid, liquid, gas, artificial]
        // the section represents the index in the state array
        // the row the index into the array of data for a particular state
        
        // get the state
        let elementState = PeriodicElements.sharedPeriodicElements.elementPhysicalStatesArray[indexPath.section]
        
        // return the element in the state array
        return PeriodicElements.sharedPeriodicElements.elementsWithPhysicalState(elementState)![indexPath.row]
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
        
        // this table has multiple sections. One for each physical state
        // [solid, liquid, gas, artificial]
        // return the number of items in the states array
        //
        return PeriodicElements.sharedPeriodicElements.elementPhysicalStatesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // this table has multiple sections. One for each physical state
        // [solid, liquid, gas, artificial]
        
        // get the state key for the requested section
        let stateKey = PeriodicElements.sharedPeriodicElements.elementPhysicalStatesArray[section]
        
        // return the number of items that are in the array for that state
        return PeriodicElements.sharedPeriodicElements.elementsWithPhysicalState(stateKey)!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        // this table has multiple sections. One for each physical state
        
        // [solid, liquid, gas, artificial]
        // return the state that represents the requested section
        // this is actually a delegate method, but we forward the request to the datasource in the view controller
        //
        return PeriodicElements.sharedPeriodicElements.elementPhysicalStatesArray[section].rawValue
    }
    
}
