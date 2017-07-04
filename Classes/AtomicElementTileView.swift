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
    
    override func draw(_ rect: CGRect) {
        guard let element = self.element else {return}
        
        // get the image that represents the element physical state and draw it
        let backgroundImage = element.stateImageForAtomicElementTileView
        let elementSymbolRectangle = CGRect(x: 0,y: 0, width: backgroundImage.size.width, height: backgroundImage.size.height)
        backgroundImage.draw(in: elementSymbolRectangle)
        
        UIColor.white.set()
        
        // draw the element number
        var font: [String: Any] = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 11)]
        var point = CGPoint(x: 3,y: 2)
        String(element.atomicNumber).draw(at: point, withAttributes: font)
        
        // draw the element symbol
        font = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18)]
        let stringSize = element.symbol.size(attributes: font)
        point = CGPoint(x: (elementSymbolRectangle.size.width-stringSize.width)/2, y: 14.0)
        
        element.symbol.draw(at: point, withAttributes: font)
    }
    
}
