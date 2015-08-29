//
//  AtomicElementTileView.swift
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
//Draws the small tile view displayed in the tableview rows.
//*/
//
//@import UIKit;
import UIKit
//
//@class AtomicElement;
//
//@interface AtomicElementTileView : UIView
@objc(AtomicElementTileView)
class AtomicElementTileView: UIView {
//
//@property (nonatomic, strong) AtomicElement *element;
    var element: AtomicElement?
//
//@end
//
//
//#import "AtomicElementTileView.h"
//#import "AtomicElement.h"
//
//
//@implementation AtomicElementTileView
//
//- (instancetype)initWithFrame:(CGRect)frame {
    override init(frame: CGRect) {
//
//    if (self = [super initWithFrame:frame]) {
        super.init(frame: frame)
//		_element = nil;
        element = nil
//    }
//    return self;
//}
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//
//- (void)drawRect:(CGRect)rect {
    override func drawRect(rect: CGRect) {
        guard let element = self.element else {return}
//
//	CGPoint point;
//
//	// get the image that represents the element physical state and draw it
//	UIImage *backgroundImage = self.element.stateImageForAtomicElementTileView;
        let backgroundImage = element.stateImageForAtomicElementTileView
//	CGRect elementSymbolRectangle = CGRectMake(0,0, [backgroundImage size].width, [backgroundImage size].height);
        let elementSymbolRectangle = CGRectMake(0,0, backgroundImage.size.width, backgroundImage.size.height)
//	[backgroundImage drawInRect:elementSymbolRectangle];
        backgroundImage.drawInRect(elementSymbolRectangle)
//
//	[[UIColor whiteColor] set];
        UIColor.whiteColor().set()
//
//	// draw the element number
//	NSDictionary *font = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:11]};
        var font: [String: AnyObject] = [NSFontAttributeName: UIFont.boldSystemFontOfSize(11)]
//	point = CGPointMake(3,2);
        var point = CGPointMake(3,2)
//	[[self.element.atomicNumber stringValue] drawAtPoint:point withAttributes:font];
        (String(element.atomicNumber) as NSString).drawAtPoint(point, withAttributes: font)
//
//	// draw the element symbol
//	font = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18]};
        font = [NSFontAttributeName: UIFont.boldSystemFontOfSize(18)]
//	CGSize stringSize = [self.element.symbol sizeWithAttributes:font];
        let stringSize = (element.symbol as NSString).sizeWithAttributes(font)
//	point = CGPointMake((elementSymbolRectangle.size.width-stringSize.width)/2, 14.0);
        point = CGPointMake((elementSymbolRectangle.size.width-stringSize.width)/2, 14.0)
//
//	[self.element.symbol drawAtPoint:point withAttributes:font];
        (element.symbol as NSString).drawAtPoint(point, withAttributes: font)
//}
    }
//
//@end
}