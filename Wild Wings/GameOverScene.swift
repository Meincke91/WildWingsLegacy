//
//  GameOverScene.swift
//  Wild Wings
//
//  Created by Martin Meincke on 26/03/15.
//  Copyright (c) 2015 drades. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene, SKPhysicsContactDelegate{
    override func didMove(to view: SKView) {
        self.removeAllActions()
        self.removeAllChildren()
        
        self.backgroundColor = UIColor(rgb: 0x6f9698)
        background.initBackgroundNodes(viewSize: self.size)

        
        let mainBox = SKShapeNode(rect: CGRect(origin: CGPoint(x: 100, y:500), size: CGSize(width: self.size.width-200, height: self.size.height-600)))
        mainBox.fillColor = UIColor(rgb: 0x4d4d4d).withAlphaComponent(0.6)
        mainBox.strokeColor = UIColor(rgb: 0x4d4d4d).withAlphaComponent(0.6)
        self.addChild(mainBox)
        /*
        let gameOverLabel = SKLabelNode()
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 38
        gameOverLabel.fontColor = SKColor.whiteColor()
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(gameOverLabel)
        
        */
        
        let scoreLabel = SKLabelNode()
        scoreLabel.text = "you scored \(points) points"
        scoreLabel.fontSize = 18
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 150)
        scoreLabel.zPosition = 5
        self.addChild(scoreLabel)
        
        
        let bottomBox = SKShapeNode(rect: CGRect(origin: CGPoint(x: -10, y:-10), size: CGSize(width: self.size.width+20, height: 110)))
        bottomBox.fillColor = UIColor(rgb: 0x212121).withAlphaComponent(0.8)
        bottomBox.strokeColor = UIColor(rgb: 0x212121).withAlphaComponent(0.8)
        self.addChild(bottomBox)
        
        let playAgainLabel = SKLabelNode()
        playAgainLabel.text = "Play Again"
        playAgainLabel.fontSize = 22
        playAgainLabel.fontColor = SKColor.white
        playAgainLabel.position = CGPoint(x: self.size.width-80, y: 45)
        playAgainLabel.name = "playAgain"
        playAgainLabel.zPosition = 5
        self.addChild(playAgainLabel)
        
        let mainMenuLabel = SKLabelNode()
        mainMenuLabel.text = "Main Menu"
        mainMenuLabel.fontSize = 22
        mainMenuLabel.fontColor = SKColor.white
        mainMenuLabel.position = CGPoint(x: 80, y: 45)
        mainMenuLabel.name = "mainMenu"
        mainMenuLabel.zPosition = 5
        self.addChild(mainMenuLabel)
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).location(in: self)
            
            if self.atPoint(location).name == "playAgain" {
                self.removeAllChildren()
                self.removeAllActions()
                
                let gameScene = GameScene(size: self.size)
                let transition = SKTransition.fade(withDuration: 0.9)
                self.scene?.view?.presentScene(gameScene, transition: transition)
                print("go back to game scene or home screen")
            }
            else if self.atPoint(location).name == "mainMenu"{
                print("go to main menu")
            }
        }
        
    }
    
}
