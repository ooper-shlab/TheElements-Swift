//
//  ElementsSortedByNameDataSource.swift
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
//Provides the table view data for the elements sorted by name.
//*/
//
//@import UIKit;
import UIKit
//
//#import "ElementsDataSourceProtocol.h"
//
//@interface ElementsSortedByNameDataSource : NSObject <UITableViewDataSource, ElementsDataSource> {
@objc(ElementsSortedByNameDataSource)
class ElementsSortedByNameDataSource: NSObject, UITableViewDataSource, ElementsDataSource {
//}
//
//@end
//
//
//#import "ElementsSortedByNameDataSource.h"
//#import "PeriodicElements.h"
//#import "AtomicElementTableViewCell.h"
//
//
//@implementation ElementsSortedByNameDataSource
//
//// protocol methods for "ElementsDataSourceProtocol"
//
//// return the data used by the navigation controller and tab bar item
//
//- (NSString *)name {
    var name: String {
//
//	return @"Name";
        return "Name"
//}
    }
//
//- (NSString *)navigationBarName {
    var navigationBarName: String {
//
//	return @"Sorted by Name";
        return "Sorted by Name"
//}
    }
//
//- (UIImage *)tabBarImage {
    var tabBarImage: UIImage {
//
//	return [UIImage imageNamed:@"name_gray.png"];
        return UIImage(named: "name_gray.png")!
//}
    }
//
//// atomic name is displayed in a plain style tableview
//
//- (UITableViewStyle)tableViewStyle {
    var tableViewStyle: UITableViewStyle {
//
//	return UITableViewStylePlain;
        return .Plain
//}
    }
//
//// return the atomic element at the index
//- (AtomicElement *)atomicElementForIndexPath:(NSIndexPath *)indexPath {
    func atomicElementForIndexPath(indexPath: NSIndexPath) -> AtomicElement? {
//
//	return [[PeriodicElements sharedPeriodicElements] elementsWithInitialLetter:[[PeriodicElements sharedPeriodicElements] elementNameIndexArray][indexPath.section]][indexPath.row];
        return PeriodicElements.sharedPeriodicElements.elementsWithInitialLetter(PeriodicElements.sharedPeriodicElements.elementNameIndexArray[indexPath.section])![indexPath.row]
//}
    }
//
//
//#pragma mark - UITableViewDataSource
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//	AtomicElementTableViewCell *cell =
        let cell =
//        (AtomicElementTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AtomicElementTableViewCell"];
        tableView.dequeueReusableCellWithIdentifier("AtomicElementTableViewCell")! as! AtomicElementTableViewCell
//
//	// set the element for this cell as specified by the datasource. The atomicElementForIndexPath: is declared
//	// as part of the ElementsDataSource Protocol and will return the appropriate element for the index row
//    //
//	cell.element = [self atomicElementForIndexPath:indexPath];
        cell.element = self.atomicElementForIndexPath(indexPath)
//
//	return cell;
        return cell
    }
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//
//	// this table has multiple sections. One for each unique character that an element begins with
//	// [A,B,C,D,E,F,G,H,I,K,L,M,N,O,P,R,S,T,U,V,X,Y,Z]
//	// return the count of that array
//	return [[[PeriodicElements sharedPeriodicElements] elementNameIndexArray] count];
        return PeriodicElements.sharedPeriodicElements.elementNameIndexArray.count
//}
    }
//
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//
//	// returns the array of section titles. There is one entry for each unique character that an element begins with
//	// [A,B,C,D,E,F,G,H,I,K,L,M,N,O,P,R,S,T,U,V,X,Y,Z]
//	return [[PeriodicElements sharedPeriodicElements] elementNameIndexArray];
        return PeriodicElements.sharedPeriodicElements.elementNameIndexArray
//}
    }
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
//
//	return index;
        return index
//}
    }
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//	// the section represents the initial letter of the element
//	// return that letter
//	NSString *initialLetter = [[PeriodicElements sharedPeriodicElements] elementNameIndexArray][section];
        let initialLetter = PeriodicElements.sharedPeriodicElements.elementNameIndexArray[section]
//
//	// get the array of elements that begin with that letter
//	NSArray *elementsWithInitialLetter = [[PeriodicElements sharedPeriodicElements] elementsWithInitialLetter:initialLetter];
        let elementsWithInitialLetter = PeriodicElements.sharedPeriodicElements.elementsWithInitialLetter(initialLetter)!
//
//	// return the count
//	return elementsWithInitialLetter.count;
        return elementsWithInitialLetter.count
//}
    }
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//	// this table has multiple sections. One for each unique character that an element begins with
//	// [A,B,C,D,E,F,G,H,I,K,L,M,N,O,P,R,S,T,U,V,X,Y,Z]
//	// return the letter that represents the requested section
//	// this is actually a delegate method, but we forward the request to the datasource in the view controller
//	//
//	return [[PeriodicElements sharedPeriodicElements] elementNameIndexArray][section];
        return PeriodicElements.sharedPeriodicElements.elementNameIndexArray[section]
//}
    }
//
//@end
}