//
//  GameDifficulty.swift
//  BrainTeaser
//
//  Created by Samuel P. Folledo on 5/9/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

enum GameDifficulty: String {
    case easy, medium, hard
    
    var highScore: Int {
        switch self {
        case .easy:
            return UserDefaults.standard.integer(forKey: kEASYHIGHSCORE)
        case .medium:
            return UserDefaults.standard.integer(forKey: kMEDIUMHIGHSCORE)
        case .hard:
            return UserDefaults.standard.integer(forKey: kHARDHIGHSCORE)
        }
    }
    
    var initialMaxTime: Double {
        switch self {
        case .easy:
            return 5
        case .medium:
            return 4
        case .hard:
            return 3
        }
    }
    
    func setHighScore(score: Int) {
        switch self {
        case .easy:
            UserDefaults.standard.set(score, forKey: kEASYHIGHSCORE)
        case .medium:
            UserDefaults.standard.set(score, forKey: kMEDIUMHIGHSCORE)
        case .hard:
            UserDefaults.standard.set(score, forKey: kHARDHIGHSCORE)
        }
        UserDefaults.standard.synchronize() //refresh UserDefaults
    }
}
