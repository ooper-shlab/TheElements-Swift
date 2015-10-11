//
//  AtomicElementTileView.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Draws the small tile view displayed in the tableview rows.
*/

import UIKit

@objc(AtomicElementTileView)
class AtomicElementTileView: UIView {
    
    var element: AtomicElement?
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        element = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        guard let element = self.element else {return}
        
        // get the image that represents the element physical state and draw it
        let backgroundImage = element.stateImageForAtomicElementTileView
        let elementSymbolRectangle = CGRectMake(0,0, backgroundImage.size.width, backgroundImage.size.height)
        backgroundImage.drawInRect(elementSymbolRectangle)
        
        UIColor.whiteColor().set()
        
        // draw the element number
        var font: [String: AnyObject] = [NSFontAttributeName: UIFont.boldSystemFontOfSize(11)]
        var point = CGPointMake(3,2)
        (String(element.atomicNumber) as NSString).drawAtPoint(point, withAttributes: font)
        
        // draw the element symbol
        font = [NSFontAttributeName: UIFont.boldSystemFontOfSize(18)]
        let stringSize = (element.symbol as NSString).sizeWithAttributes(font)
        point = CGPointMake((elementSymbolRectangle.size.width-stringSize.width)/2, 14.0)
        
        (element.symbol as NSString).drawAtPoint(point, withAttributes: font)
    }
    
}