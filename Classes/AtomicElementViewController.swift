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
        
        let viewRect = CGRect(x: (self.view.bounds.width - preferredAtomicElementViewSize.width)/2,
            y: (self.view.bounds.height - preferredAtomicElementViewSize.height)/2 - 40,
            width: preferredAtomicElementViewSize.width,
            height: preferredAtomicElementViewSize.height)
        
        
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
        reflectionRect.size.height = reflectionRect.height * reflectionFraction
        
        // and is offset to be at the bottom of the view being reflected
        reflectionRect = reflectionRect.offsetBy(dx: 0, dy: viewRect.height)
        
        let localReflectionImageView = UIImageView(frame: reflectionRect)
        self.reflectionView = localReflectionImageView
        
        // determine the size of the reflection to create
        let reflectionHeight = Int(self.atomicElementView.bounds.height * reflectionFraction)
        
        // create the reflection image, assign it to the UIImageView and add the image view to the view controller's view
        self.reflectionView.image = self.atomicElementView.reflectedImageRepresentationWithHeight(reflectionHeight)
        self.reflectionView.alpha = reflectionOpacity
        
        self.view.addSubview(self.reflectionView)
        
        // setup our flip indicator button (placed as a nav bar item to the right)
        let localFlipIndicator = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        self.flipIndicatorButton = localFlipIndicator
        
        // front view is always visible at first
        self.flipIndicatorButton.setBackgroundImage(UIImage(named: "flipper_list_blue.png"), for: .normal)
        
        let flipButtonBarItem = UIBarButtonItem(customView: self.flipIndicatorButton)
        self.flipIndicatorButton.addTarget(self,
            action: #selector(AtomicElementViewController.flipCurrentView),
            for: .touchDown)
        self.navigationItem.setRightBarButton(flipButtonBarItem, animated: true)
    }
    
    @objc func flipCurrentView() {
        
        // disable user interaction during the flip animation
        self.view.isUserInteractionEnabled = false
        self.flipIndicatorButton.isUserInteractionEnabled = false
        
        // setup the animation group
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(kFlipTransitionDuration)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop(#selector(AtomicElementViewController.myTransitionDidStop(_:finished:context:)))
        
        // swap the views and transition
        if self.frontViewIsVisible {
            UIView.setAnimationTransition(.flipFromRight, for: self.view, cache: true)
            self.atomicElementView.removeFromSuperview()
            self.view.addSubview(self.atomicElementFlippedView)
            
            // update the reflection image for the new view
            let reflectionHeight = Int(self.atomicElementFlippedView.bounds.height * reflectionFraction)
            let reflectedImage = self.atomicElementFlippedView.reflectedImageRepresentationWithHeight(reflectionHeight)
            reflectionView.image = reflectedImage
        } else {
            UIView.setAnimationTransition(.flipFromLeft, for: self.view, cache: true)
            self.atomicElementFlippedView.removeFromSuperview()
            self.view.addSubview(self.atomicElementView)
            // update the reflection image for the new view
            let reflectionHeight = Int(self.atomicElementView.bounds.height * reflectionFraction)
            let reflectedImage = self.atomicElementView.reflectedImageRepresentationWithHeight(reflectionHeight)
            reflectionView.image = reflectedImage
        }
        UIView.commitAnimations()
        
        // swap the nav bar button views
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(kFlipTransitionDuration)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop(#selector(AtomicElementViewController.myTransitionDidStop(_:finished:context:)))
        
        if self.frontViewIsVisible {
            UIView.setAnimationTransition(.flipFromRight, for: self.flipIndicatorButton, cache: true)
            self.flipIndicatorButton.setBackgroundImage(self.element?.flipperImageForAtomicElementNavigationItem, for: .normal)
        } else {
            UIView.setAnimationTransition(.flipFromLeft, for: self.flipIndicatorButton, cache: true)
            self.flipIndicatorButton.setBackgroundImage(UIImage(named: "flipper_list_blue.png"), for: .normal)
            
        }
        UIView.commitAnimations()
        
        // invert the front view state
        self.frontViewIsVisible = !self.frontViewIsVisible
    }
    
    @objc func myTransitionDidStop(_ animationID: String, finished: NSNumber, context: UnsafeMutableRawPointer) {
        // re-enable user interaction when the flip animation is completed
        self.view.isUserInteractionEnabled = true
        self.flipIndicatorButton.isUserInteractionEnabled = true
    }
    
}
