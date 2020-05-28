//
//  UIView+extensions.swift
//  TopBrains
//
//  Created by Samuel P. Folledo on 5/9/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIView {
    
/// Constraint view to its superview
    func fitInSuperview() {
        guard let sv = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: sv.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: sv.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: sv.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: sv.rightAnchor).isActive = true
    }
    
/// Constraint view to its superview's margin
    func fitInSuperviewMargins() {
        guard let sv = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: sv.topAnchor, constant: sv.layoutMargins.top).isActive = true
        bottomAnchor.constraint(equalTo: sv.bottomAnchor,constant: -sv.layoutMargins.bottom).isActive = true
        leftAnchor.constraint(equalTo: sv.leftAnchor,constant: sv.layoutMargins.left).isActive = true
        rightAnchor.constraint(equalTo: sv.rightAnchor,constant: -sv.layoutMargins.right).isActive = true
    }

/// Returns a collection of constraints to anchor the bounds of the current view to the given view.
/// https://medium.com/better-programming/auto-layout-in-swift-ffd918d4ec06
/// - Parameter view: The view to anchor to.
/// - Returns: The layout constraints needed for this constraint.
    func pinEdgesEquallyTo(boundsOf view: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
    
/// Constraint a view to another view with equal leading and trailing helper
    func pinLeftAndRightEdgesEquallyTo(constantInset: CGFloat = 0.0, boundsOf view: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constantInset),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constantInset)
        ]
    }
    
/// Top and bottom constraint helper
    func pinTopAndBottomEdgesEquallyTo(constantInset: CGFloat = 0.0, boundsOf view: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor, constant: constantInset),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomAnchor.constraint(equalTo: view.topAnchor, constant: -constantInset),
            trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
    
/// Height constraint helper
    func pinHeightTo(constantInset: CGFloat = 0.0, multiplier: CGFloat = 1.0, boundsOf view: UIView) -> [NSLayoutConstraint] {
        if constantInset != 0.0 && multiplier != 1.0 {
            print("Height cannot apply both constant inset and multiplier at the same time")
            return []
        }
        if constantInset == 0.0 { //apply constant to height
            return [
               heightAnchor.constraint(equalTo: view.heightAnchor, constant: constantInset)
            ]
        } else { //apply multiplier to height
            return [
                heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier)
            ]
        }
    }
    
    func pinWidthTo(constantInset: CGFloat = 0.0, multiplier: CGFloat = 1.0, boundsOf view: UIView) -> [NSLayoutConstraint] {
        if constantInset != 0.0 && multiplier != 1.0 {
            print("Width cannot apply both constant inset and multiplier at the same time")
            return []
        }
        if constantInset == 0.0 { //apply constant to height
            return [
               widthAnchor.constraint(equalTo: view.widthAnchor, constant: constantInset)
            ]
        } else { //apply multiplier to height
            return [
                widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier)
            ]
        }
    }
}

//UIView functions for the game
extension UIView {
    func applyUpAndDownAnimation() {
        UIView.animate(withDuration: 1, animations: {
            //            self.backgroundColor = .brown
            self.frame.size.width += 10
            self.frame.size.height += 10
        }) { _ in
            UIView.animate(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat], animations: { //makes a repeating animation that goes back and forth
                self.frame.origin.y -= 20
            })
        }
    }
    
    func fadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    func applyShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        //        self.layer.shadowOffset = .zero
        self.layer.shadowOffset.height = self.frame.height / 8 //+ will go down, - will go up
        self.layer.shadowOffset.width = self.frame.width / 8 //+ go right, - will go left
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func applyRoundShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        //        self.layer.shadowOffset = .zero
        self.layer.shadowOffset.height = self.frame.height / 10 //+ will put the shadow down, negative will put the shadow up
        self.layer.shadowOffset.width = self.frame.width / 10 //+ will make it more right, negative will put it more left
        self.layer.shadowRadius = self.frame.height / 3
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
