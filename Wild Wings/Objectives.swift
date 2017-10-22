//
//  Objectives.swift
//  Wild Wings
//
//  Created by Martin Meincke on 06/04/15.
//  Copyright (c) 2015 drades. All rights reserved.
//

import Foundation
import SpriteKit

class Objectives : GameScene{
    func objectiveLabels(viewSize: CGSize) -> [SKLabelNode]{
        var objetiveLabelNodes : [SKLabelNode] = []
        
        let objective1 = SKLabelNode()
        objective1.text = "Scare 5 birds in one game"
        objective1.fontName = "HelveticaNeue-Bold"
        objective1.fontColor = SKColor.black
        objective1.fontSize = 25
        objective1.zPosition = 2.9
        objective1.position = CGPoint(x: viewSize.width/2, y: viewSize.height*1.1)
        objetiveLabelNodes.append(objective1)
        
        let objective2 = SKLabelNode()
        objective2.text = "Get 30 points"
        objective2.fontName = "HelveticaNeue-Bold"
        objective2.fontColor = SKColor.black
        objective2.fontSize = 25
        objective2.zPosition = 2.9
        objective2.position = CGPoint(x: viewSize.width/2, y: viewSize.height*1.15)
        objetiveLabelNodes.append(objective2)
        
        let objective3 = SKLabelNode()
        objective3.text = "Collect 10 apples in one game"
        objective3.fontName = "HelveticaNeue-Bold"
        objective3.fontColor = SKColor.black
        objective3.fontSize = 25
        objective3.zPosition = 2.9
        objective3.position = CGPoint(x: viewSize.width/2, y: viewSize.height*1.2)
        objetiveLabelNodes.append(objective3)
        
        return objetiveLabelNodes
    }
    
    func startLabelMove(label: SKLabelNode){
        let moveAction = SKAction.moveBy( x: 0,  y: -getSideSpeed(), duration: 0.05)
        let moveForeverAction = SKAction.repeatForever(SKAction.sequence([moveAction]))
        
        label.run(moveForeverAction)
    }
}
