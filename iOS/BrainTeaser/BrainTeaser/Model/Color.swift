//
//  Color.swift
//  BrainTeaser
//
//  Created by Samuel P. Folledo on 5/9/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

protocol ColorProtocol {
    var textColor: UIColor { get }
    var text: String { get }
}

enum Color {
    case red, orange, yellow, green, blue, purple
    
    var textColor: UIColor {
        switch self {
        case .red:
            return .red
        case .orange:
            return .orange
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .blue:
            return .blue
        case .purple:
            return .purple
        }
    }
    
    var text: String {
        switch self {
        case .red:
            return "red"
        case .orange:
            return "orange"
        case .yellow:
            return "yellow"
        case .green:
            return "green"
        case .blue:
            return "blue"
        case .purple:
            return "purple"
        }
    }
    
    init() {
        self = Color.allCases[Int(arc4random_uniform(UInt32(Color.allCases.count)))]
    }
}

extension Color: CaseIterable {
    mutating func getRandomColor() { //updates color to a random Color from all Color cases //CaseIterable allows me to use the allCases typeProperty
        self = Color.allCases[Int(arc4random_uniform(UInt32(Color.allCases.count)))]
    }
}
