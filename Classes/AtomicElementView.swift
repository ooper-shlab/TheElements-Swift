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
        
        return CGSize(width: 256,height: 256)
    }
    
    // initialize the view, calling super and setting the properties to nil
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        // Initialization code here.
        element = nil
        viewController = nil
        // set the background color of the view to clearn
        self.backgroundColor = UIColor.clear
        
        // attach a tap gesture recognizer to this view so it can flip
        let tapGestureRecognizer =
        UITapGestureRecognizer(target: self, action: #selector(AtomicElementView.tapAction(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // yes this view can become first responder
    override var canBecomeFirstResponder : Bool {
        
        return true
    }
    
    @objc func tapAction(_ gestureRecognizer: UIGestureRecognizer) {
        
        // when a tap gesture occurs tell the view controller to flip this view to the
        // back and show the AtomicElementFlippedView instead
        //
        self.viewController?.flipCurrentView()
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let element = self.element else {return}
        // get the background image for the state of the element
        // position it appropriately and draw the image
        let backgroundImage = element.stateImageForAtomicElementView
        let elementSymbolRectangle = CGRect(x: 0, y: 0, width: backgroundImage.size.width, height: backgroundImage.size.height)
        backgroundImage.draw(in: elementSymbolRectangle)
        
        // all the text is drawn in white
        UIColor.white.set()
        
        // draw the element name
        var font: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 36)]
        var stringSize = element.name.size(withAttributes: font)
        var point = CGPoint(x: (self.bounds.size.width-stringSize.width)/2, y: 256/2-50)
        element.name.draw(at: point, withAttributes: font)
        
        // draw the element number
        font = [.font: UIFont.boldSystemFont(ofSize: 48)]
        point = CGPoint(x: 10,y: 0)
        String(element.atomicNumber).draw(at: point, withAttributes: font)
        
        // draw the element symbol
        font = [.font: UIFont.boldSystemFont(ofSize: 96)]
        stringSize = element.symbol.size(withAttributes: font)
        point = CGPoint(x: (self.bounds.size.width-stringSize.width)/2,y: 256-120)
        element.symbol.draw(at: point, withAttributes: font)
    }
    
    
    private func AEViewCreateGradientImage(_ pixelsWide: Int, _ pixelsHigh: Int) -> CGImage? {
        
        var theCGImage: CGImage? = nil
        
        // Our gradient is always black-white and the mask
        // must be in the gray colorspace
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        // create the bitmap context
        if let gradientBitmapContext = CGContext(data: nil, width: pixelsWide, height: pixelsHigh,
            bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue) {
                
                // define the start and end grayscale values (with the alpha, even though
                // our bitmap context doesn't support alpha the gradient requires it)
                let colors: [CGFloat] = [0.0, 1.0, 1.0, 1.0]
                
                // create the CGGradient and then release the gray color space
                let grayScaleGradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: nil, count: 2)
                
                // create the start and end points for the gradient vector (straight down)
                let gradientStartPoint = CGPoint.zero
                let gradientEndPoint = CGPoint(x: 0, y: CGFloat(pixelsHigh))
                
                // draw the gradient into the gray bitmap context
                gradientBitmapContext.drawLinearGradient (grayScaleGradient!, start: gradientStartPoint, end: gradientEndPoint, options: CGGradientDrawingOptions.drawsAfterEndLocation)
                
                // clean up the gradient
                
                // convert the context into a CGImageRef and release the context
                theCGImage = gradientBitmapContext.makeImage()
        }
        
        // clean up the colorspace
        
        // return the imageref containing the gradient
        return theCGImage
    }
    
    func reflectedImageRepresentationWithHeight(_ height: Int) -> UIImage? {
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // create a bitmap graphics context the size of the image
        guard let mainViewContentContext = CGContext(data: nil, width: Int(self.bounds.size.width), height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            
            // free the rgb colorspace
            
            return nil
        }
        
        // offset the context. This is necessary because, by default, the layer created by a view for
        // caching its content is flipped. But when you actually access the layer content and have
        // it rendered it is inverted. Since we're only creating a context the size of our
        // reflection view (a fraction of the size of the main view) we have to translate the context the
        // delta in size, render it, and then translate back
        
        let translateVertical = self.bounds.size.height - CGFloat(height)
        mainViewContentContext.translateBy(x: 0, y: -translateVertical)
        
        // render the layer into the bitmap context
        self.layer.render(in: mainViewContentContext)
        
        // translate the context back
        mainViewContentContext.translateBy(x: 0, y: translateVertical)
        
        // Create CGImageRef of the main view bitmap content, and then release that bitmap context
        let mainViewContentBitmapContext = mainViewContentContext.makeImage()
        
        // create a 2 bit CGImage containing a gradient that will be used for masking the
        // main view content to create the 'fade' of the reflection.  The CGImageCreateWithMask
        // function will stretch the bitmap image as required, so we can create a 1 pixel wide gradient
        let gradientMaskImage = AEViewCreateGradientImage(1, height)
        
        // Create an image by masking the bitmap of the mainView content with the gradient view
        // then release the pre-masked content bitmap and the gradient bitmap
        let reflectionImage = mainViewContentBitmapContext?.masking(gradientMaskImage!)!
        
        // convert the finished reflection image to a UIImage
        let theImage = UIImage(cgImage: reflectionImage!)
        
        return theImage
    }
    
}
