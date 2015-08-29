//
//  AtomicElementView.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Displays the Atomic Element information in a large format tile.
*/

import UIKit

@objc(AtomicElementView)
class AtomicElementView: UIView {
    
    var element: AtomicElement?
    weak var viewController: AtomicElementViewController?
    
    
    // the preferred size of this view is the size of the background image
    class func preferredViewSize() -> CGSize {
        
        return CGSizeMake(256,256)
    }
    
    // initialize the view, calling super and setting the properties to nil
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        // Initialization code here.
        element = nil
        viewController = nil
        // set the background color of the view to clearn
        self.backgroundColor = UIColor.clearColor()
        
        // attach a tap gesture recognizer to this view so it can flip
        let tapGestureRecognizer =
        UITapGestureRecognizer(target: self, action: "tapAction:")
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // yes this view can become first responder
    override func canBecomeFirstResponder() -> Bool {
        
        return true
    }
    
    func tapAction(gestureRecognizer: UIGestureRecognizer) {
        
        // when a tap gesture occurs tell the view controller to flip this view to the
        // back and show the AtomicElementFlippedView instead
        //
        self.viewController?.flipCurrentView()
    }
    
    override func drawRect(rect: CGRect) {
        
        guard let element = self.element else {return}
        // get the background image for the state of the element
        // position it appropriately and draw the image
        let backgroundImage = element.stateImageForAtomicElementView
        let elementSymbolRectangle = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)
        backgroundImage.drawInRect(elementSymbolRectangle)
        
        // all the text is drawn in white
        UIColor.whiteColor().set()
        
        // draw the element name
        var font = [NSFontAttributeName: UIFont.boldSystemFontOfSize(36)]
        var stringSize = (element.name as NSString).sizeWithAttributes(font)
        var point = CGPointMake((self.bounds.size.width-stringSize.width)/2, 256/2-50)
        (element.name as NSString).drawAtPoint(point, withAttributes: font)
        
        // draw the element number
        font = [NSFontAttributeName: UIFont.boldSystemFontOfSize(48)]
        point = CGPointMake(10,0)
        (String(element.atomicNumber) as NSString).drawAtPoint(point, withAttributes: font)
        
        // draw the element symbol
        font = [NSFontAttributeName: UIFont.boldSystemFontOfSize(96)]
        stringSize = (element.symbol as NSString).sizeWithAttributes(font)
        point = CGPointMake((self.bounds.size.width-stringSize.width)/2,256-120)
        (element.symbol as NSString).drawAtPoint(point, withAttributes: font)
    }
    
    
    private func AEViewCreateGradientImage(pixelsWide: Int, _ pixelsHigh: Int) -> CGImage? {
        
        var theCGImage: CGImage? = nil
        
        // Our gradient is always black-white and the mask
        // must be in the gray colorspace
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        // create the bitmap context
        if let gradientBitmapContext = CGBitmapContextCreate(nil, pixelsWide, pixelsHigh,
            8, 0, colorSpace, CGImageAlphaInfo.None.rawValue) {
                
                // define the start and end grayscale values (with the alpha, even though
                // our bitmap context doesn't support alpha the gradient requires it)
                let colors: [CGFloat] = [0.0, 1.0, 1.0, 1.0]
                
                // create the CGGradient and then release the gray color space
                let grayScaleGradient = CGGradientCreateWithColorComponents(colorSpace, colors, nil, 2)
                
                // create the start and end points for the gradient vector (straight down)
                let gradientStartPoint = CGPointZero
                let gradientEndPoint = CGPointMake(0, CGFloat(pixelsHigh))
                
                // draw the gradient into the gray bitmap context
                CGContextDrawLinearGradient (gradientBitmapContext, grayScaleGradient, gradientStartPoint, gradientEndPoint, CGGradientDrawingOptions.DrawsAfterEndLocation)
                
                // clean up the gradient
                
                // convert the context into a CGImageRef and release the context
                theCGImage = CGBitmapContextCreateImage(gradientBitmapContext)
        }
        
        // clean up the colorspace
        
        // return the imageref containing the gradient
        return theCGImage
    }
    
    func reflectedImageRepresentationWithHeight(height: Int) -> UIImage? {
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // create a bitmap graphics context the size of the image
        guard let mainViewContentContext = CGBitmapContextCreate(nil, Int(self.bounds.size.width), height, 8, 0, colorSpace, CGImageAlphaInfo.PremultipliedLast.rawValue) else {
            
            // free the rgb colorspace
            
            return nil
        }
        
        // offset the context. This is necessary because, by default, the layer created by a view for
        // caching its content is flipped. But when you actually access the layer content and have
        // it rendered it is inverted. Since we're only creating a context the size of our
        // reflection view (a fraction of the size of the main view) we have to translate the context the
        // delta in size, render it, and then translate back
        
        let translateVertical = self.bounds.size.height - CGFloat(height)
        CGContextTranslateCTM(mainViewContentContext, 0, -translateVertical)
        
        // render the layer into the bitmap context
        self.layer.renderInContext(mainViewContentContext)
        
        // translate the context back
        CGContextTranslateCTM(mainViewContentContext, 0, translateVertical)
        
        // Create CGImageRef of the main view bitmap content, and then release that bitmap context
        let mainViewContentBitmapContext = CGBitmapContextCreateImage(mainViewContentContext)
        
        // create a 2 bit CGImage containing a gradient that will be used for masking the
        // main view content to create the 'fade' of the reflection.  The CGImageCreateWithMask
        // function will stretch the bitmap image as required, so we can create a 1 pixel wide gradient
        let gradientMaskImage = AEViewCreateGradientImage(1, height)
        
        // Create an image by masking the bitmap of the mainView content with the gradient view
        // then release the pre-masked content bitmap and the gradient bitmap
        let reflectionImage = CGImageCreateWithMask(mainViewContentBitmapContext, gradientMaskImage)!
        
        // convert the finished reflection image to a UIImage
        let theImage = UIImage(CGImage: reflectionImage)
        
        return theImage
    }
    
}