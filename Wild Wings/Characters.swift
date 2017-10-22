//
//  Characters.swift
//  Wild Wings
//
//  Created by Martin Meincke on 23/03/15.
//  Copyright (c) 2015 drades. All rights reserved.
//

import Foundation
import SpriteKit


class Characters : GameScene{
    let characters = ["sheep1","sheep2"]
    let descriptions = ["What do you call a sheep with a machine gun?","A baaaaad situation."]
    let prices = [1000, 2500]
    let birdSpeeds : [CGFloat] = [450,480]
    let birdJumpForce : [CGFloat] = [2050, 2100]
    let maxBirdSpeeds : [CGFloat] = [600, 700]
    var characterNode : SKSpriteNode!
    
    func mainCharacter(characterIndex: Int, startPos: CGPoint) -> SKSpriteNode{
        characterNode = SKSpriteNode(imageNamed: characters[characterIndex])
        characterNode.position = startPos
        characterNode.zPosition = 3.1
        
        let collisionPath: CGMutablePath = CGMutablePath()
        let nodeSize = characterNode.size
        let offsetX: CGFloat = nodeSize.width * characterNode.anchorPoint.x
        let offsetY: CGFloat = nodeSize.height * characterNode.anchorPoint.y
        
        collisionPath.move(to: CGPoint(x: 0 - offsetX, y: nodeSize.height - offsetY))
        collisionPath.addLine(to: CGPoint(x: nodeSize.width*0.7 - offsetX, y: nodeSize.height - offsetY))
        collisionPath.addLine(to: CGPoint(x: nodeSize.width*0.7 - offsetX, y: nodeSize.height*0.9 - offsetY))
        collisionPath.addLine(to: CGPoint(x: nodeSize.width*0.8 - offsetX, y: nodeSize.height*0.9 - offsetY))
        collisionPath.addLine(to: CGPoint(x: nodeSize.width - offsetX, y: nodeSize.height*0.65 - offsetY))
        collisionPath.addLine(to: CGPoint(x: nodeSize.width*0.8 - offsetX, y: nodeSize.height*0.3 - offsetY))
        collisionPath.addLine(to: CGPoint(x: nodeSize.width*0.8 - offsetX, y: nodeSize.height*0.1 - offsetY))
        collisionPath.addLine(to: CGPoint(x: 0 - offsetX, y: nodeSize.height*0.1 - offsetY))
        
        collisionPath.closeSubpath()
        
        
        characterNode.physicsBody = SKPhysicsBody(polygonFrom: collisionPath)
        characterNode.physicsBody!.isDynamic = true
        characterNode.physicsBody!.categoryBitMask = ColliderType.playerCol.rawValue
        characterNode.physicsBody!.contactTestBitMask = ColliderType.edgeCol.rawValue | ColliderType.bottomEdgeCol.rawValue
        characterNode.physicsBody!.collisionBitMask = ColliderType.bottomEdgeCol.rawValue 
        return characterNode
    }

    
    func bird(){
        //add code for bird
    }
    
    func getCharacterNode() -> SKSpriteNode{
        return self.characterNode
    }
    
    func getMaxBirdSpeed() -> CGFloat{
        return self.maxBirdSpeeds[0]
    }
    
    func getBirdSpeed() -> CGFloat{
        return self.birdSpeeds[0]
    }
    
    func getBirdJumpForce() -> CGFloat{
        return self.birdJumpForce[0]
    }
    
    func turnCharacter(viewSize : CGSize){
        if self.characterNode.position.x > viewSize.width/2 {
            self.characterNode.physicsBody?.velocity = CGVector(dx: -getBirdSpeed(), dy: 0.0)
            self.characterNode.xScale = -1
        }
        else{
            self.characterNode.physicsBody?.velocity = CGVector(dx: getBirdSpeed(), dy: 0.0)
            self.characterNode.xScale = 1
        }
    }
    
    func turnCharacterRight(){
        self.characterNode.physicsBody?.velocity = CGVector(dx: getBirdSpeed(), dy: 0.0)
        self.characterNode.xScale = 1
    }
    
    func turnCharacterLeft(){
        self.characterNode.physicsBody?.velocity = CGVector(dx: -getBirdSpeed(), dy: 0.0)
        self.characterNode.xScale = -1
    }
    
    func stopCharacter(){
        self.characterNode.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
    }
    
    func startCharacter(){
        self.characterNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 10.0))
        self.characterNode.physicsBody?.velocity = CGVector(dx: getBirdSpeed(), dy: 0.0)
    }
}
