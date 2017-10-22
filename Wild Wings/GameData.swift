//
//  GameData.swift
//  Wild Wings
//
//  Created by Martin Meincke on 02/10/15.
//  Copyright © 2015 drades. All rights reserved.
//

import Foundation
import SpriteKit


class GameData : GameScene{
    
    // getters
    func getHighscore() -> Int{
        return UserDefaults.standard.integer(forKey: "highscore")
    }
    
    func getTotalFood() -> Int{
        return UserDefaults.standard.integer(forKey: "totalFood")
    }
    
    func getActiveCharacter() -> Int{
        return UserDefaults.standard.integer(forKey: "activeCharacter")
    }
    
    // Setters
    internal func setHighscore(points : Int){
        UserDefaults.standard.set(points, forKey: "highscore")
        UserDefaults.standard.synchronize()
    }
    
    internal func setFood(food : Int) {
        let currentSavedFood = getTotalFood()
        UserDefaults.standard.set( (currentSavedFood + food), forKey: "totalFood")
    }
    
    internal func setActiveCharacter(character : Int){
        UserDefaults.standard.set(character, forKey: "activeCharacter")
    }
    
    internal func setAvailableCharacters(availableCharacters : Int){
        
        
        
    }

}
