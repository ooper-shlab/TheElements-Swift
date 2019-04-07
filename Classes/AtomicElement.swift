//
//  AtomicElement.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Simple object that encapsulate the Atomic Element values and images for the states.
*/
import UIKit

enum ElementState: String {
    case Solid, Liquid, Gas, Artificial
}

@objc(AtomicElement)
class AtomicElement: NSObject {
    
    var atomicNumber: Int
    var name: String
    var symbol: String
    var state: ElementState
    var atomicWeight: String
    var group: Int
    var period: Int
    var discoveryYear: String
    
    
    private var vertPos: Int
    private var horizPos: Int
    private var radioactive: Bool = false
    
    init(dictionary aDictionary: [String: Any]) {
        
        self.atomicNumber = aDictionary["atomicNumber"]! as! Int
        self.atomicWeight = aDictionary["atomicWeight"]! as! String
        self.discoveryYear = aDictionary["discoveryYear"]! as! String
        self.radioactive = (aDictionary["radioactive"]! as! NSString).boolValue //### Elements.plist contains radioactive field as String, why not Boolean?
        self.name = aDictionary["name"]! as! String
        self.symbol = aDictionary["symbol"]! as! String
        self.state = ElementState(rawValue: aDictionary["state"]! as! String)!
        //### Needed fix for `Ununoctium`, `Ununseptium` and `Ununtrium` in Elements.plist
        self.group = aDictionary["group"]! as! Int
        self.period = aDictionary["period"]! as! Int
        self.vertPos = aDictionary["vertPos"]! as! Int
        self.horizPos = aDictionary["horizPos"]! as! Int
        super.init()
    }
    
    
    // this returns the position of the element in the classic periodic table locations
    private var positionForElement: CGPoint {
        
        return CGPoint(x: CGFloat(horizPos)*26 - 8, y: CGFloat(vertPos)*26 + 35)
        
    }
    
    var stateImageForAtomicElementTileView: UIImage {
        
        return UIImage(named: "\(self.state)_37.png")!
    }
    
    var stateImageForAtomicElementView: UIImage {
        return UIImage(named: "\(self.state)_256.png")!
    }
    
    //- (UIImage *)stateImageForPeriodicTableView {
    //	return [UIImage imageNamed:[NSString stringWithFormat:@"%@_24.png", self.state]];
    //}
    
    var flipperImageForAtomicElementNavigationItem: UIImage {
        
        // return a 30 x 30 image that is a reduced version
        // of the AtomicElementTileView content
        // this is used to display the flipper button in the navigation bar
        let itemSize = CGSize(width: 30.0, height: 30.0)
        UIGraphicsBeginImageContext(itemSize)
        
        let backgroundImage = UIImage(named: "\(self.state)_30.png")!
        let elementSymbolRectangle = CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height)
        backgroundImage.draw(in: elementSymbolRectangle)
        
        // draw the element name
        UIColor.white.set()
        
        // draw the element number
        var font: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 8)]
        var point = CGPoint(x: 2, y: 1)
        String(atomicNumber).draw(at: point, withAttributes: font)
        
        // draw the element symbol
        font = [.font: UIFont.boldSystemFont(ofSize: 13)]
        let stringSize = self.symbol.size(withAttributes: font)
        point = CGPoint(x: (elementSymbolRectangle.size.width-stringSize.width)/2, y: 10)
        
        self.symbol.draw(at: point, withAttributes: font)
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage!
    }
    
}
