//
//  UIButton+extensions.swift
//  BrainTeaser
//
//  Created by Macbook Pro 15 on 5/9/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIButton {
    func isMenuButton() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.height / 5
        self.clipsToBounds = true
    }
}
