//
//  PeriodicElements.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Encapsulates the collection of elements and returns them in presorted states.
*/
import UIKit


@objc(PeriodicElements)
class PeriodicElements: NSObject {
    
    var statesDictionary: [ElementState: [AtomicElement]] = [:]
    var elementsDictionary: [String: AtomicElement] = [:]
    var nameIndexesDictionary: [String: [AtomicElement]] = [:]
    var elementNameIndexArray: [String] = []
    var elementsSortedByNumber: [AtomicElement] = []
    var elementsSortedBySymbol: [AtomicElement] = []
    var elementPhysicalStatesArray: [ElementState] = [.Solid, .Liquid, .Gas, .Artificial]
    
    
    // we use the singleton approach, one collection for the entire application
    
    static let sharedPeriodicElements: PeriodicElements = PeriodicElements()
    
    // setup the data collection
    private override init() {
        super.init()
        self.setupElementsArray()
    }
    
    private func setupElementsArray() {
        
        // create dictionaries that contain the arrays of element data indexed by
        // name
        // physical state
        // unique first characters (for the Name index table)
        
        // create empty array entries in the states Dictionary or each physical state
        self.statesDictionary[.Solid] = []
        self.statesDictionary[.Liquid] = []
        self.statesDictionary[.Gas] = []
        self.statesDictionary[.Artificial] = []
        
        // read the element data from the plist
        let theURL = NSBundle.mainBundle().URLForResource("Elements", withExtension: "plist")!
        let rawElementsArray = NSArray(contentsOfURL: theURL)! as! [[String : AnyObject]]
        
        // iterate over the values in the raw elements dictionary
        for eachElement in rawElementsArray {
            // create an atomic element instance for each
            let anElement = AtomicElement(dictionary: eachElement)
            
            // store that item in the elements dictionary with the name as the key
            self.elementsDictionary[anElement.name] = anElement
            
            // add that element to the appropriate array in the physical state dictionary
            self.statesDictionary[anElement.state]?.append(anElement)
            
            // get the element's initial letter
            let firstLetter = anElement.name.substringToIndex(anElement.name.startIndex.successor())
            if self.nameIndexesDictionary[firstLetter] != nil {
                
                // if an array already exists in the name index dictionary
                // simply add the element to it, otherwise create an array
                // and add it to the name index dictionary with the letter as the key
                //
                self.nameIndexesDictionary[firstLetter]!.append(anElement)
            } else {
                self.nameIndexesDictionary[firstLetter] = [anElement]
            }
        }
        
        // create the dictionary containing the possible element states
        // and presort the states data
        self.presortElementsByPhysicalState()
        
        // presort the dictionaries now
        // this could be done the first time they are requested instead
        //
        self.presortElementInitialLetterIndexes()
        
        self.elementsSortedByNumber = self.presortElementsByNumber()
        self.elementsSortedBySymbol = self.presortElementsBySymbol()
    }
    
    // return the array of elements for the requested physical state
    func elementsWithPhysicalState(aState: ElementState) -> [AtomicElement]? {
        
        return self.statesDictionary[aState]
    }
    
    // presort each of the arrays for the physical states
    private func presortElementsByPhysicalState() {
        
        for stateKey in self.elementPhysicalStatesArray {
            self.presortElementsWithPhysicalState(stateKey)
        }
    }
    
    private func presortElementsWithPhysicalState(state: ElementState) {
        
        self.statesDictionary[state]!.sortInPlace{
            $0.name.compare($1.name, options: .CaseInsensitiveSearch, range: nil, locale: NSLocale.currentLocale()) == .OrderedAscending
        }
    }
    
    // return an array of elements for an initial letter (ie A, B, C, ...)
    func elementsWithInitialLetter(aKey: String) -> [AtomicElement]? {
        
        return self.nameIndexesDictionary[aKey]
    }
    
    // presort the name index arrays so the elements are in the correct order
    private func presortElementInitialLetterIndexes() {
        
        self.elementNameIndexArray = self.nameIndexesDictionary.keys.sort {
            $0.compare($1, options: .CaseInsensitiveSearch, range: nil, locale: NSLocale.currentLocale()) == .OrderedAscending
        }
        for eachNameIndex in self.elementNameIndexArray {
            self.presortElementNamesForInitialLetter(eachNameIndex)
        }
    }
    
    private func presortElementNamesForInitialLetter(aKey: String) {
        
        self.nameIndexesDictionary[aKey]!.sortInPlace{
            $0.name.compare($1.name, options: .CaseInsensitiveSearch, range: nil, locale: NSLocale.currentLocale()) == .OrderedAscending
        }
    }
    
    // presort the elementsSortedByNumber array
    private func presortElementsByNumber() -> [AtomicElement] {
        
        let sortedElements = self.elementsDictionary.values.sort {
            $0.atomicNumber < $1.atomicNumber
        }
        return sortedElements
    }
    
    // presort the elementsSortedBySymbol array
    private func presortElementsBySymbol() -> [AtomicElement] {
        
        let sortedElements = self.elementsDictionary.values.sort{
            $0.symbol.compare($1.symbol, options: .CaseInsensitiveSearch, range: nil, locale: NSLocale.currentLocale()) == .OrderedAscending
        }
        return sortedElements
    }
    
}