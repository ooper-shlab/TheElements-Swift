//
//  AtomicElementViewController.swift
//  TheElements
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/8/29.
//
//
/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Controller that manages the full tile view of the atomic information, creating the reflection, and the flipping of the tile.
*/

import UIKit

@objc(AtomicElementViewController)
class AtomicElementViewController: UIViewController {
    
    var element: AtomicElement?
    
    
    
    private let kFlipTransitionDuration = 0.75
    private let reflectionFraction: CGFloat = 0.35
    private let reflectionOpacity: CGFloat = 0.5
    
    private var frontViewIsVisible: Bool = true
    private var atomicElementView: AtomicElementView!
    private var reflectionView: UIImageView!
    private var atomicElementFlippedView: AtomicElementFlippedView!
    private var flipIndicatorButton: UIButton!
    
    
    //MARK: -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.frontViewIsVisible = true
        
        let preferredAtomicElementViewSize = AtomicElementView.preferredViewSize()
        
        let viewRect = CGRectMake((CGRectGetWidth(self.view.bounds) - preferredAtomicElementViewSize.width)/2,
            (CGRectGetHeight(self.view.bounds) - preferredAtomicElementViewSize.height)/2 - 40,
            preferredAtomicElementViewSize.width,
            preferredAtomicElementViewSize.height)
        
        
        // create the atomic element view
        let localAtomicElementView = AtomicElementView(frame: viewRect)
        self.atomicElementView = localAtomicElementView
        
        // add the atomic element view to the view controller's view
        self.atomicElementView.element = self.element
        self.view.addSubview(self.atomicElementView)
        
        self.atomicElementView.viewController = self
        
        // create the atomic element flipped view
        
        let localAtomicElementFlippedView = AtomicElementFlippedView(frame: viewRect)
        self.atomicElementFlippedView = localAtomicElementFlippedView
        
        self.atomicElementFlippedView.element = self.element
        self.atomicElementFlippedView.viewController = self
        
        // create the reflection view
        var reflectionRect = viewRect
        
        // the reflection is a fraction of the size of the view being reflected
        reflectionRect.size.height = CGRectGetHeight(reflectionRect) * reflectionFraction
        
        // and is offset to be at the bottom of the view being reflected
        reflectionRect = CGRectOffset(reflectionRect, 0, CGRectGetHeight(viewRect))
        
        let localReflectionImageView = UIImageView(frame: reflectionRect)
        self.reflectionView = localReflectionImageView
        
        // determine the size of the reflection to create
        let reflectionHeight = Int(CGRectGetHeight(self.atomicElementView.bounds) * reflectionFraction)
        
        // create the reflection image, assign it to the UIImageView and add the image view to the view controller's view
        self.reflectionView.image = self.atomicElementView.reflectedImageRepresentationWithHeight(reflectionHeight)
        self.reflectionView.alpha = reflectionOpacity
        
        self.view.addSubview(self.reflectionView)
        
        // setup our flip indicator button (placed as a nav bar item to the right)
        let localFlipIndicator = UIButton(frame: CGRectMake(0.0, 0.0, 30.0, 30.0))
        self.flipIndicatorButton = localFlipIndicator
        
        // front view is always visible at first
        self.flipIndicatorButton.setBackgroundImage(UIImage(named: "flipper_list_blue.png"), forState: .Normal)
        
        let flipButtonBarItem = UIBarButtonItem(customView: self.flipIndicatorButton)
        self.flipIndicatorButton.addTarget(self,
            action: "flipCurrentView",
            forControlEvents: UIControlEvents.TouchDown)
        self.navigationItem.setRightBarButtonItem(flipButtonBarItem, animated: true)
    }
    
    func flipCurrentView() {
        
        // disable user interaction during the flip animation
        self.view.userInteractionEnabled = false
        self.flipIndicatorButton.userInteractionEnabled = false
        
        // setup the animation group
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(kFlipTransitionDuration)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("myTransitionDidStop:finished:context:")
        
        // swap the views and transition
        if self.frontViewIsVisible {
            UIView.setAnimationTransition(.FlipFromRight, forView: self.view, cache: true)
            self.atomicElementView.removeFromSuperview()
            self.view.addSubview(self.atomicElementFlippedView)
            
            // update the reflection image for the new view
            let reflectionHeight = Int(CGRectGetHeight(self.atomicElementFlippedView.bounds) * reflectionFraction)
            let reflectedImage = self.atomicElementFlippedView.reflectedImageRepresentationWithHeight(reflectionHeight)
            reflectionView.image = reflectedImage
        } else {
            UIView.setAnimationTransition(.FlipFromLeft, forView: self.view, cache: true)
            self.atomicElementFlippedView.removeFromSuperview()
            self.view.addSubview(self.atomicElementView)
            // update the reflection image for the new view
            let reflectionHeight = Int(CGRectGetHeight(self.atomicElementView.bounds) * reflectionFraction)
            let reflectedImage = self.atomicElementView.reflectedImageRepresentationWithHeight(reflectionHeight)
            reflectionView.image = reflectedImage
        }
        UIView.commitAnimations()
        
        // swap the nav bar button views
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(kFlipTransitionDuration)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("myTransitionDidStop:finished:context:")
        
        if self.frontViewIsVisible {
            UIView.setAnimationTransition(.FlipFromRight, forView: self.flipIndicatorButton, cache: true)
            self.flipIndicatorButton.setBackgroundImage(self.element?.flipperImageForAtomicElementNavigationItem, forState: .Normal)
        } else {
            UIView.setAnimationTransition(.FlipFromLeft, forView: self.flipIndicatorButton, cache: true)
            self.flipIndicatorButton.setBackgroundImage(UIImage(named: "flipper_list_blue.png"), forState: .Normal)
            
        }
        UIView.commitAnimations()
        
        // invert the front view state
        self.frontViewIsVisible = !self.frontViewIsVisible
    }
    
    func myTransitionDidStop(animationID: String, finished: NSNumber, context: UnsafeMutablePointer<Void>) {
        // re-enable user interaction when the flip animation is completed
        self.view.userInteractionEnabled = true
        self.flipIndicatorButton.userInteractionEnabled = true
    }
    
}