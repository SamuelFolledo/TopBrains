//
//  CardColor.swift
//  TopBrains
//
//  Created by Samuel P. Folledo on 5/9/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

enum CardColor {
    case white, black, green, red
    
    var color: UIColor {
        switch self {
        case .white:
            return .white
        case .black:
            return .black
        case .green:
            return .green
        case .red:
            return .red
        }
    }
    
    init() {
        self = CardColor.allCases[Int(arc4random_uniform(UInt32(CardColor.allCases.count)))]
    }
}

extension CardColor: CaseIterable {
    mutating func getRandomColor() { //updates color to a random Color from all Color cases //CaseIterable allows me to use the allCases typeProperty
        self = CardColor.allCases[Int(arc4random_uniform(UInt32(CardColor.allCases.count)))]
    }
}
