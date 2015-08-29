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
        
        let buttonFrame = CGRectMake(10.0, 209.0, 234.0, 37.0)
        
        // create the button
        self.wikipediaButton = UIButton(type: UIButtonType.RoundedRect)
        self.wikipediaButton.frame = buttonFrame
        
        self.wikipediaButton.setTitle("View at Wikipedia", forState: .Normal)
        
        // Center the text on the button, considering the button's shadow
        self.wikipediaButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        self.wikipediaButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        
        self.wikipediaButton.addTarget(self, action: "jumpToWikipedia:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(self.wikipediaButton)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.autoresizesSubviews = true
        self.setupUserInterface()
        
        // set the background color of the view to clearn
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func jumpToWikipedia(sender: AnyObject) {
        
        // create the string that points to the correct Wikipedia page for the element name
        let wikiPageString = "http://en.wikipedia.org/wiki/\(self.element!.name)"
        if !UIApplication.sharedApplication().openURL(NSURL(string: wikiPageString)!) {
            // there was an error trying to open the URL. for the moment we'll simply ignore it.
        }
    }
    
    override func drawRect(rect: CGRect) {
        guard let element = self.element else {return}
        
        // get the background image for the state of the element
        // position it appropriately and draw the image
        //
        let backgroundImage = element.stateImageForAtomicElementView
        let elementSymbolRectangle = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)
        backgroundImage.drawInRect(elementSymbolRectangle)
        
        // all the text is drawn in white
        UIColor.whiteColor().set()
        
        // draw the element number
        var font: [String: AnyObject] = [NSFontAttributeName: UIFont.boldSystemFontOfSize(32)]
        var point = CGPointMake(10, 5)
        (String(element.atomicNumber) as NSString).drawAtPoint(point, withAttributes: font)
        
        // draw the element symbol
        var stringSize = (element.symbol as NSString).sizeWithAttributes(font)
        point = CGPointMake((self.bounds.size.width-stringSize.width-10),5)
        (element.symbol as NSString).drawAtPoint(point, withAttributes: font)
        
        // draw the element name
        font = [NSFontAttributeName: UIFont.boldSystemFontOfSize(32)]
        stringSize = (element.name as NSString).sizeWithAttributes(font)
        point = CGPointMake((self.bounds.size.width-stringSize.width)/2,50)
        (element.name as NSString).drawAtPoint(point, withAttributes: font)
        
        let verticalStartingPoint: CGFloat = 95
        
        // draw the element weight
        font = [NSFontAttributeName: UIFont.boldSystemFontOfSize(14)]
        let atomicWeightString: NSString = "Atomic Weight: \(element.atomicWeight)"
        stringSize = atomicWeightString.sizeWithAttributes(font)
        point = CGPointMake((self.bounds.size.width-stringSize.width)/2, verticalStartingPoint)
        atomicWeightString.drawAtPoint(point, withAttributes: font)
        
        // draw the element state
        let stateString: NSString = "State: \(element.state)"
        stringSize = stateString.sizeWithAttributes(font)
        point = CGPointMake((self.bounds.size.width-stringSize.width)/2, verticalStartingPoint+20)
        stateString.drawAtPoint(point, withAttributes: font)
        
        // draw the element period
        let periodString: NSString = "Period: \(element.period)"
        stringSize = periodString.sizeWithAttributes(font)
        point = CGPointMake((self.bounds.size.width-stringSize.width)/2, verticalStartingPoint+40)
        periodString.drawAtPoint(point, withAttributes: font)
        
        // draw the element group
        let groupString: NSString = "Group: \(element.group)"
        stringSize = groupString.sizeWithAttributes(font)
        point = CGPointMake((self.bounds.size.width-stringSize.width)/2, verticalStartingPoint+60)
        groupString.drawAtPoint(point, withAttributes: font)
        
        // draw the discovery year
        let discoveryYearString: NSString = "Discovered: \(element.discoveryYear)"
        stringSize = discoveryYearString.sizeWithAttributes(font)
        point = CGPointMake((self.bounds.size.width-stringSize.width)/2, verticalStartingPoint+80)
        discoveryYearString.drawAtPoint(point, withAttributes: font)
    }
    
    
}