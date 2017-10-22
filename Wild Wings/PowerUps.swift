//
//  PowerUps.swift
//  Wild Wings
//
//  Created by Martin Meincke on 26/03/15.
//  Copyright (c) 2015 drades. All rights reserved.
//

import Foundation
import SpriteKit

var apples : [SKSpriteNode] = []
let appleSpeed: TimeInterval = 3.7

class PowerUps: GameScene {
    
    func initApple(viewSize: CGSize) -> SKSpriteNode{
        
        let appleElement = SKSpriteNode(imageNamed: "apple3")
        let appleX = arc4random_uniform(UInt32(viewSize.width-200)) + 100
        appleElement.xScale = 0.5
        appleElement.yScale = 0.5
        appleElement.position = CGPoint(x: CGFloat(appleX), y: viewSize.height + CGFloat(100))
        appleElement.physicsBody = SKPhysicsBody(circleOfRadius: (appleElement.size.width/2) )
        appleElement.physicsBody!.isDynamic = false
        appleElement.physicsBody!.categoryBitMask = ColliderType.foodCol.rawValue
        appleElement.physicsBody!.contactTestBitMask = ColliderType.playerCol.rawValue | ColliderType.edgeCol.rawValue
        appleElement.physicsBody!.collisionBitMask = ColliderType.bottomEdgeCol.rawValue
        appleElement.zPosition = 4.0
        
        return appleElement
    }
    
    func addNewApple(viewSize: CGSize){
        let sideSpeed = TimeInterval(7.5-gameScene.getSideSpeed()/4.0)
        
        let randomAppleVar = arc4random_uniform(UInt32(100))
        if randomAppleVar <= appleChance && gameState == 2 && points > 3 && apples[0].hasActions() == false{
            let dropAppleAction = SKAction.group([ SKAction.moveBy(x: 0, y: -viewSize.height - 500, duration: sideSpeed), SKAction.rotate(byAngle: 2, duration: appleSpeed)])
            
            let appleX = arc4random_uniform(UInt32(viewSize.width-200)) + 100
            apples[0].removeAllActions()
            apples[0].position = CGPoint(x: CGFloat(appleX), y: viewSize.height + CGFloat(100))
            apples[0].run(dropAppleAction)
        }
    }
    
    func resetApples(){
        let resetCoordinate: CGFloat = -150
        
        for apple in apples{
            if apple.position.y <= resetCoordinate {
                apple.removeAllActions()
            }
        }
    }
    
    func stopPowerUps(){
        for apple in apples{
            apple.removeAllActions()
            apple.position = CGPoint(x: 0, y: 3000)
        }
    }
    
}
