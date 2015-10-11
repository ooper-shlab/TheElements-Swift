//
//  AtomicElementTableViewCell.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Draws the tableview cell and lays out the subviews.
*/

import UIKit

@objc(AtomicElementTableViewCell)
class AtomicElementTableViewCell: UITableViewCell {
    
    var element: AtomicElement? {
        didSet {didSetElement(oldValue)}
    }
    
    
    // the element setter
    // we implement this because the table cell values need to be updated when this property
    // changes, and this allows for the changes to be encapsulated
    //
    private func didSetElement(anElement: AtomicElement?) {
        
        let elementTileView = self.contentView.viewWithTag(1) as! AtomicElementTileView
        elementTileView.element = element
        
        let labelView = self.contentView.viewWithTag(2) as! UILabel
        labelView.text = element?.name
        
        elementTileView.setNeedsDisplay()
        labelView.setNeedsDisplay()
    }
    
}