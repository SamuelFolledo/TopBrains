//
//  String+extensions.swift
//  BrainTeaser
//
//  Created by Macbook Pro 15 on 5/9/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
