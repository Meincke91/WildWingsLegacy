//
//  GameOver.swift
//  Wild Wings
//
//  Created by Martin Meincke on 25/03/15.
//  Copyright (c) 2015 drades. All rights reserved.
//

import Foundation
import SpriteKit

var gameOverOverlay : SKShapeNode!

class GameOver : GameScene {
    
    func initGameOverOverlay(viewSize: CGSize){
        
        gameOverOverlay = SKShapeNode(rect: CGRect(origin: CGPoint(x: -100, y: -100), size: CGSize(width: viewSize.width+200, height: viewSize.height+200)))
        
        
        gameOverOverlay.fillColor = SKColor.gray.withAlphaComponent(0.5)
        gameOverOverlay.position = CGPoint(x: 0, y: 0)
        gameOverOverlay.zPosition = 5
        gameOverOverlay.name = "gameOverOverlay"
        
        initGOOLabels(viewSize: viewSize)
    }
    
    func initGOOLabels(viewSize: CGSize){
        // initialize labels for gameOverOverlay
        let gameOverLabel = SKLabelNode()
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 38
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        gameOverLabel.zPosition = 5.5
        gameOverOverlay.addChild(gameOverLabel)
        
        let playAgainLabel = SKLabelNode()
        playAgainLabel.text = "Keep climing!"
        playAgainLabel.fontSize = 22
        playAgainLabel.fontColor = SKColor.white
        playAgainLabel.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2 - 100)
        playAgainLabel.zPosition = 5.5
        gameOverOverlay.addChild(playAgainLabel)
        
        let continueButton = SKShapeNode(rect: CGRect(origin: CGPoint(x: viewSize.width/2-100, y: viewSize.height/2 - 150), size: CGSize(width:200, height:100)))
        continueButton.zPosition = 5.5
        continueButton.fillColor = SKColor.green.withAlphaComponent(0.8)
        gameOverOverlay.addChild(continueButton)
    }
}
