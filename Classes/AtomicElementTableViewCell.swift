//
//  AtomicElementTableViewCell.swift
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
//Draws the tableview cell and lays out the subviews.
//*/
//
//@import UIKit;
import UIKit
//
//@class AtomicElement;
//
//@interface AtomicElementTableViewCell : UITableViewCell
@objc(AtomicElementTableViewCell)
class AtomicElementTableViewCell: UITableViewCell {
//
//@property (nonatomic,strong) AtomicElement *element;
    var element: AtomicElement? {
        didSet {didSetElement(oldValue)}
    }
//
//@end
//
//
//#import "AtomicElementTableViewCell.h"
//#import "AtomicElement.h"
//#import "AtomicElementTileView.h"
//
//@implementation AtomicElementTableViewCell
//
//// the element setter
//// we implement this because the table cell values need to be updated when this property
//// changes, and this allows for the changes to be encapsulated
////
//- (void)setElement:(AtomicElement *)anElement {
    private func didSetElement(anElement: AtomicElement?) {
//
//    if (anElement != _element) {
//		_element = anElement;
//	}
//
//    AtomicElementTileView *elementTileView = (AtomicElementTileView *)[self.contentView viewWithTag:1];
        let elementTileView = self.contentView.viewWithTag(1) as! AtomicElementTileView
//    elementTileView.element = _element;
        elementTileView.element = element
//
//	UILabel *labelView = (UILabel *)[self.contentView viewWithTag:2];
        let labelView = self.contentView.viewWithTag(2) as! UILabel
//    labelView.text = _element.name;
        labelView.text = element?.name
//
//	[elementTileView setNeedsDisplay];
        elementTileView.setNeedsDisplay()
//	[labelView setNeedsDisplay];
        labelView.setNeedsDisplay()
//}
    }
//
//@end
}