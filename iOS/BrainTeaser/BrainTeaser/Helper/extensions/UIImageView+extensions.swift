//
//  UIImageView+extensions.swift
//  BrainTeaser
//
//  Created by Macbook Pro 15 on 5/9/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIImageView {
    func enlargeThenShrinkAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (finished) in
            UIView.animate(withDuration: 0.5, animations: {
//                self.transform = CGAffineTransform.identity
                self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }) { (finished) in
                self.isHidden = true
            }
        }
    }
}
