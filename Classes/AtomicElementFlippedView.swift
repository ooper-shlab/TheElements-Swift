//
//  AtomicElementFlippedView.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Displays the Atomic Element information with a link to Wikipedia.
*/

import UIKit

@objc(AtomicElementFlippedView)
class AtomicElementFlippedView: AtomicElementView {
    
    private var wikipediaButton: UIButton!
    
    
    private func setupUserInterface() {
        
        let buttonFrame = CGRect(x: 10.0, y: 209.0, width: 234.0, height: 37.0)
        
        // create the button
        self.wikipediaButton = UIButton(type: UIButtonType.roundedRect)
        self.wikipediaButton.frame = buttonFrame
        
        self.wikipediaButton.setTitle("View at Wikipedia", for: UIControlState())
        
        // Center the text on the button, considering the button's shadow
        self.wikipediaButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        self.wikipediaButton.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        
        self.wikipediaButton.addTarget(self, action: #selector(AtomicElementFlippedView.jumpToWikipedia(_:)), for: UIControlEvents.touchUpInside)
        
        self.addSubview(self.wikipediaButton)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.autoresizesSubviews = true
        self.setupUserInterface()
        
        // set the background color of the view to clearn
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func jumpToWikipedia(_ sender: AnyObject) {
        
        // create the string that points to the correct Wikipedia page for the element name
        let wikiPageString = "http://en.wikipedia.org/wiki/\(self.element!.name)"
        if !UIApplication.shared.openURL(URL(string: wikiPageString)!) {
            // there was an error trying to open the URL. for the moment we'll simply ignore it.
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let element = self.element else {return}
        
        // get the background image for the state of the element
        // position it appropriately and draw the image
        //
        let backgroundImage = element.stateImageForAtomicElementView
        let elementSymbolRectangle = CGRect(x: 0, y: 0, width: backgroundImage.size.width, height: backgroundImage.size.height)
        backgroundImage.draw(in: elementSymbolRectangle)
        
        // all the text is drawn in white
        UIColor.white.set()
        
        // draw the element number
        var font: [String: AnyObject] = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 32)]
        var point = CGPoint(x: 10, y: 5)
        String(element.atomicNumber).draw(at: point, withAttributes: font)
        
        // draw the element symbol
        var stringSize = element.symbol.size(attributes: font)
        point = CGPoint(x: (self.bounds.size.width-stringSize.width-10),y: 5)
        element.symbol.draw(at: point, withAttributes: font)
        
        // draw the element name
        font = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 32)]
        stringSize = element.name.size(attributes: font)
        point = CGPoint(x: (self.bounds.size.width-stringSize.width)/2,y: 50)
        element.name.draw(at: point, withAttributes: font)
        
        let verticalStartingPoint: CGFloat = 95
        
        // draw the element weight
        font = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)]
        let atomicWeightString = "Atomic Weight: \(element.atomicWeight)"
        stringSize = atomicWeightString.size(attributes: font)
        point = CGPoint(x: (self.bounds.size.width-stringSize.width)/2, y: verticalStartingPoint)
        atomicWeightString.draw(at: point, withAttributes: font)
        
        // draw the element state
        let stateString = "State: \(element.state)"
        stringSize = stateString.size(attributes: font)
        point = CGPoint(x: (self.bounds.size.width-stringSize.width)/2, y: verticalStartingPoint+20)
        stateString.draw(at: point, withAttributes: font)
        
        // draw the element period
        let periodString = "Period: \(element.period)"
        stringSize = periodString.size(attributes: font)
        point = CGPoint(x: (self.bounds.size.width-stringSize.width)/2, y: verticalStartingPoint+40)
        periodString.draw(at: point, withAttributes: font)
        
        // draw the element group
        let groupString = "Group: \(element.group)"
        stringSize = groupString.size(attributes: font)
        point = CGPoint(x: (self.bounds.size.width-stringSize.width)/2, y: verticalStartingPoint+60)
        groupString.draw(at: point, withAttributes: font)
        
        // draw the discovery year
        let discoveryYearString = "Discovered: \(element.discoveryYear)"
        stringSize = discoveryYearString.size(attributes: font)
        point = CGPoint(x: (self.bounds.size.width-stringSize.width)/2, y: verticalStartingPoint+80)
        discoveryYearString.draw(at: point, withAttributes: font)
    }
    
    
}
