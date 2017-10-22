//
//  Background.swift
//  Wild Wings
//
//  Created by Martin Meincke on 23/03/15.
//  Copyright (c) 2015 drades. All rights reserved.
//

import Foundation
import SpriteKit

class Background : GameScene{
    
    var bg_node = SKNode()
    let pregame_node = SKNode()
    let ingame_node = SKNode()
    let moveWithSideNode = SKNode()
    
    // bg_node
    let bg_sunshine = SKSpriteNode(imageNamed: "sunshine")
    let bg_mountain1 = SKSpriteNode(imageNamed: "mountain1")
    let bg_mountain2 = SKSpriteNode(imageNamed: "mountain2")
    let bg_mountain3 = SKSpriteNode(imageNamed: "mountain3")
    let bg_water1 = SKSpriteNode(imageNamed: "water1")
    let bg_water2 = SKSpriteNode(imageNamed: "water2")
    
    private let highScoreLabel = SKLabelNode()
    private let totalFoodLabel = SKLabelNode()
    private let dradesCoinLabel = SKLabelNode()
    
    // ingame_node
    let igScoreLabel = SKLabelNode()
    let igFoodLabel = SKLabelNode()
    let igDradesCoinLabelNode = SKLabelNode()
    let igFoodIcon = SKSpriteNode(imageNamed: "apple3")
    let igDradesCoinIcon = SKSpriteNode(imageNamed: "dradesCoin1")
    
    // pregame_node
    let pgScoreLabel = SKLabelNode()
    let pgFoodLabel = SKLabelNode()
    let pgDradesCoinLabelNode = SKLabelNode()
    let pgFoodIcon = SKSpriteNode(imageNamed: "apple3")
    let pgDradesCoinIcon = SKSpriteNode(imageNamed: "dradesCoin1")
    let pgGround = SKSpriteNode(imageNamed: "preGameGround")
    
    // moveWithSideNode
    var rightSideNodes : [SKSpriteNode] = []
    var leftSideNodes : [SKSpriteNode] = []
    
    var rightTreeNodes : [SKSpriteNode] = []
    var leftTreeNodes : [SKSpriteNode] = []

    func initBackgroundNodes(viewSize: CGSize){
        bg_sunshine.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        bg_mountain1.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        bg_mountain2.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        bg_mountain3.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        bg_water1.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2-140)
        bg_water2.position = CGPoint(x: viewSize.width/2-30, y: viewSize.height/2-155)
        
        
        if bg_node.children.count == 0{
            bg_node.position = CGPoint(x: 0, y: 0)
            
            bg_sunshine.zPosition = 1.0
            bg_sunshine.name = "sunshine"
            bg_node.addChild(bg_sunshine)
            
            bg_mountain1.zPosition = 2.0
            bg_mountain1.name = "mountain1"
            bg_node.addChild(bg_mountain1)
            
            bg_mountain2.zPosition = 2.1
            bg_mountain2.name = "mountain2"
            bg_node.addChild(bg_mountain2)
            
            bg_mountain3.zPosition = 2.2
            bg_mountain3.name = "mountain3"
            bg_node.addChild(bg_mountain3)
            
            bg_water1.zPosition = 3.1
            bg_water1.name = "water1"
            bg_node.addChild(bg_water1)
            let moveWater1Left = SKAction.moveBy(x: 0, y: 20, duration: 1.5)
            let moveWater1Right = SKAction.moveBy(x: 0, y: -20, duration: 1.5)
            let moveWater1Sequence = SKAction.repeatForever(SKAction.sequence([moveWater1Left, moveWater1Right]))
            bg_water1.run(moveWater1Sequence)
            
            bg_water2.zPosition = 3.2
            bg_water2.name = "water2"
            bg_node.addChild(bg_water2)
            let moveWater2Left = SKAction.moveBy(x: 0, y: 20, duration: 1.5)
            let moveWater2Right = SKAction.moveBy(x: 0, y: -20, duration: 1.5)
            let moveWater2Sequence = SKAction.repeatForever(SKAction.sequence([moveWater2Left, moveWater2Right]))
            bg_water2.run(moveWater2Sequence)
            
            
            //add the labels
            //bg_node.addChild(ingame_node)
            
        }
    }
    
    func initInGameLabels(viewSize: CGSize){
        //highscore label
        igScoreLabel.text = String("Score: \(points) ")
        igScoreLabel.fontSize = 25
        igScoreLabel.fontName = "HelveticaNeue-Bold"
        igScoreLabel.fontColor = SKColor(rgb: 0xbcbcbc).withAlphaComponent(0.8)
        igScoreLabel.position = CGPoint(x: viewSize.width/2, y: viewSize.height / 8)
        igScoreLabel.name = "highScoreLabel"
        igScoreLabel.zPosition = 5.1
        ingame_node.addChild(igScoreLabel)
        
        igFoodLabel.text = String(food)
        igFoodLabel.fontSize = 25
        igFoodLabel.fontName = "HelveticaNeue-Bold"
        igFoodLabel.fontColor = SKColor.black.withAlphaComponent(0.8)
        igFoodLabel.position = CGPoint(x: viewSize.width*0.14 + igFoodLabel.frame.width/2, y: viewSize.height*0.94)
        igFoodLabel.name = "totalCandyLabel"
        igFoodLabel.zPosition = 5.1
        ingame_node.addChild(igFoodLabel)
        
        igDradesCoinLabelNode.text = "0"
        igDradesCoinLabelNode.fontSize = 25
        igDradesCoinLabelNode.fontName = "HelveticaNeue-Bold"
        igDradesCoinLabelNode.fontColor = SKColor.black.withAlphaComponent(0.8)
        igDradesCoinLabelNode.position = CGPoint(x: viewSize.width*0.14 + igDradesCoinLabelNode.frame.width/2, y: viewSize.height*0.89)
        igDradesCoinLabelNode.name = "inGameDradesCoinLabelNode"
        igDradesCoinLabelNode.zPosition = 5.1
        ingame_node.addChild(igDradesCoinLabelNode)
        
        igFoodIcon.xScale = 0.5
        igFoodIcon.yScale = 0.5
        igFoodIcon.zPosition = 5.1
        igFoodIcon.position = CGPoint(x: viewSize.width*0.10, y: viewSize.height - viewSize.height*0.05)
        ingame_node.addChild(igFoodIcon)
        
        
        igDradesCoinIcon.xScale = 0.7
        igDradesCoinIcon.yScale = 0.7
        igDradesCoinIcon.zPosition = 5.1
        igDradesCoinIcon.position = CGPoint(x: viewSize.width*0.10, y: viewSize.height - viewSize.height*0.1)
        ingame_node.addChild(igDradesCoinIcon)
    }
    
    func initPreGameLabels(viewSize: CGSize){
        let totalFood = gameData.getTotalFood()
        let highScore = gameData.getHighscore()
        
        totalFoodLabel.text = String(totalFood)
        highScoreLabel.text = String("Highest Score: \(highScore) ")
        
        if pregame_node.children.isEmpty{
            print("did init pregame")
            //shop label
            let shopLabelContainer = SKShapeNode(rect: CGRect(x: viewSize.width*0.7, y: viewSize.height*0.9, width: viewSize.width * 0.25, height: viewSize.height * 0.08))
            shopLabelContainer.name = "shopLabelContainer"
            shopLabelContainer.lineWidth = 0.0
            shopLabelContainer.zPosition = 5.1
            
            let shopLabel = SKLabelNode()
            shopLabel.text = "Workshop"
            shopLabel.fontSize = 25
            shopLabel.fontName = "HelveticaNeue-Bold"
            shopLabel.fontColor = SKColor.black.withAlphaComponent(0.8)
            shopLabel.position = CGPoint(x: viewSize.width*0.7 + shopLabelContainer.frame.width/2, y: viewSize.height*0.9 + shopLabelContainer.frame.height/2)
            shopLabel.name = "shopLabel"
            shopLabel.zPosition = 5.1
            
            shopLabelContainer.addChild(shopLabel)
            pregame_node.addChild(shopLabelContainer)
            
            //highscore label
            highScoreLabel.fontSize = 25
            highScoreLabel.fontName = "HelveticaNeue-Bold"
            highScoreLabel.fontColor = SKColor(rgb: 0xbcbcbc).withAlphaComponent(0.8)
            highScoreLabel.position = CGPoint(x: viewSize.width/2, y: viewSize.height / 3)
            highScoreLabel.name = "highScoreLabel"
            highScoreLabel.zPosition = 5.1
            pregame_node.addChild(highScoreLabel)
            
            //food label
            totalFoodLabel.fontSize = 25
            totalFoodLabel.fontName = "HelveticaNeue-Bold"
            totalFoodLabel.fontColor = SKColor.black.withAlphaComponent(0.8)
            totalFoodLabel.position = CGPoint(x: viewSize.width*0.14 + totalFoodLabel.frame.width/2, y: viewSize.height*0.94)
            totalFoodLabel.name = "totalCandyLabel"
            totalFoodLabel.zPosition = 5.1
            pregame_node.addChild(totalFoodLabel)
            
            
            // DradesCoin label
            dradesCoinLabel.text = "10000"
            dradesCoinLabel.fontSize = 25
            dradesCoinLabel.fontName = "HelveticaNeue-Bold"
            dradesCoinLabel.fontColor = SKColor.black.withAlphaComponent(0.8)
            dradesCoinLabel.position = CGPoint(x: viewSize.width*0.14 + dradesCoinLabel.frame.width/2, y: viewSize.height*0.89)
            dradesCoinLabel.name = "dradesCoinLabel"
            dradesCoinLabel.zPosition = 5.1
            pregame_node.addChild(dradesCoinLabel)
            
            
            pgFoodIcon.xScale = 0.5
            pgFoodIcon.yScale = 0.5
            pgFoodIcon.zPosition = 5.1
            pgFoodIcon.position = CGPoint(x: viewSize.width*0.10, y: viewSize.height - viewSize.height*0.05)
            pregame_node.addChild(pgFoodIcon)
            
            
            pgDradesCoinIcon.xScale = 0.7
            pgDradesCoinIcon.yScale = 0.7
            pgDradesCoinIcon.zPosition = 5.1
            pgDradesCoinIcon.position = CGPoint(x: viewSize.width*0.10, y: viewSize.height - viewSize.height*0.1)
            pregame_node.addChild(pgDradesCoinIcon)
            
            // ground sprite
            pgGround.xScale = 1
            pgGround.yScale = 1
            pgGround.zPosition = 3.0
            pgGround.position = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
            moveWithSideNode.addChild(pgGround)
        }
    }
    
    
    //label updaters
    func updateScoreLabel(){
        igScoreLabel.text = String("Score: \(points) ")
    }
    
    func updateFoodLabel(){
        igFoodLabel.text = String(food)
    }
    
    func updatePreGameLabels(){
        totalFoodLabel.text = String(gameData.getTotalFood())
        highScoreLabel.text = String("Highest Score: \(gameData.getHighscore()) ")
    }
    
    
    func initMoveWithSideNodes(viewSize : CGSize){
        initTreeNodes(nodes: 10, viewWidth: viewSize.width)
    }
    
    func initTreeNodes(nodes: Int, viewWidth: CGFloat){
        for i in 0..<nodes {
            let bg_tree = SKSpriteNode(imageNamed: "treeElement")
            bg_tree.zPosition = 2.9
            bg_tree.position = CGPoint(x: bg_tree.size.width/3, y: bg_tree.size.height * CGFloat(i))
            
            leftSideNodes.append(bg_tree)
            moveWithSideNode.addChild(bg_tree)
        }
        
        for i in 0..<nodes {
            let bg_tree = SKSpriteNode(imageNamed: "treeElement")
            bg_tree.zPosition = 2.9
            bg_tree.position = CGPoint(x: viewWidth-bg_tree.size.width/3, y: bg_tree.size.height * CGFloat(i))
            
            rightSideNodes.append(bg_tree)
            moveWithSideNode.addChild(bg_tree)
        }
    }
    
    func initMainCollisionBoxes(viewSize: CGSize) -> [SKNode]{
        var mainCollisionBoxes: [SKNode] = []
        //right side collision box
        let rightSide = SKNode()
        rightSide.physicsBody = SKPhysicsBody.init(edgeFrom: CGPoint(x: viewSize.width-25, y: 0), to: CGPoint(x: viewSize.width-25, y: viewSize.height))
        
        rightSide.physicsBody!.categoryBitMask = ColliderType.edgeCol.rawValue
        rightSide.physicsBody!.contactTestBitMask = ColliderType.playerCol.rawValue
        rightSide.name = "rightCol"
        
        mainCollisionBoxes.append(rightSide)
        
        //left side collision box
        let leftSide = SKNode()
        
        leftSide.physicsBody = SKPhysicsBody.init(edgeFrom: CGPoint(x: 25, y: 0), to: CGPoint(x: 25, y:viewSize.height))
        leftSide.physicsBody!.categoryBitMask = ColliderType.edgeCol.rawValue
        leftSide.physicsBody!.contactTestBitMask = ColliderType.playerCol.rawValue
        leftSide.name = "leftCol"
        
        mainCollisionBoxes.append(leftSide)
        
        //bottom collision box
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody.init(edgeFrom: CGPoint(x: 0, y: 15), to: CGPoint(x: viewSize.width, y: 15))
        bottom.physicsBody!.categoryBitMask = ColliderType.bottomEdgeCol.rawValue
        bottom.physicsBody!.contactTestBitMask = ColliderType.playerCol.rawValue | ColliderType.foodCol.rawValue
        mainCollisionBoxes.append(bottom)
        
        return mainCollisionBoxes
    }
    
    func startMoveSides(){
        let moveSideAction = SKAction.moveBy( x: 0,  y: -gameScene.getSideSpeed(), duration: 0.05)
        let moveSideForeverAction = SKAction.repeatForever(SKAction.sequence([moveSideAction]))
        moveWithSideNode.run(moveSideForeverAction)
    }
    
    func speedUpSides(){
        let moveSideAction = SKAction.moveBy( x: 0,  y: -gameScene.getSideSpeed(), duration: 0.05)
        let moveSideForeverAction = SKAction.repeatForever(SKAction.sequence([moveSideAction]))
        moveWithSideNode.removeAllActions()
        moveWithSideNode.run(moveSideForeverAction)
        
    }
    
    func stopMoveSides(){
        moveWithSideNode.removeAllActions()
    }
    
    func reArrangeMoveWithSides(viewSize: CGSize){
        moveWithSideNode.position.y = 0.0
        
        for i in 0..<leftSideNodes.count {
            leftSideNodes[i].position.y = leftSideNodes[i].size.height * CGFloat(i)
        }
        
        for i in 0..<rightSideNodes.count {
            rightSideNodes[i].position.y = rightSideNodes[i].size.height * CGFloat(i)
        }
    }
    
    func sideNodeReset(viewSize: CGSize){
        let sideResetCoordinate : CGFloat = -80
        var addNewObstacle = false
        
        //move left side elements up to the top of the stack if they get below sideResetCoordinate variable
        for i in 0..<leftSideNodes.count {
            if leftSideNodes[i].position.y+moveWithSideNode.position.y <= sideResetCoordinate{
                addNewObstacle = true
                if i != 0{
                    leftSideNodes[i].position.y = leftSideNodes[i-1].position.y + leftSideNodes[i].size.height
                }
                else{
                    leftSideNodes[i].position.y = leftSideNodes[leftSideNodes.count-1].position.y + leftSideNodes[i].size.height
                }
            }
        }

        //move right side elements up to the top of the stack if they get below sideResetCoordinate variable
        for i in 0..<rightSideNodes.count {
            if rightSideNodes[i].position.y+moveWithSideNode.position.y <= sideResetCoordinate{
                addNewObstacle = true
                if i != 0{
                    rightSideNodes[i].position.y = rightSideNodes[i-1].position.y + rightSideNodes[i].size.height
                }
                else{
                    rightSideNodes[i].position.y = rightSideNodes[rightSideNodes.count-1].position.y + rightSideNodes[i].size.height
                }
            }
        }

    }
    
    
    // Getters
    
    func getBgNode() -> SKNode{
        return bg_node
    }
    
    func getPregameNode() -> SKNode{
        return pregame_node
    }
    
    func getInGameNode() -> SKNode{
        return ingame_node
    }
    
    func getMoveWithSide() -> SKNode{
        return moveWithSideNode
    }

    func getRightNodes() -> [SKSpriteNode]{
        return self.rightSideNodes
    }
    
    func getLeftNodes() -> [SKSpriteNode]{
        return self.leftSideNodes
    }
    
    func getIgScoreLabel() -> SKLabelNode{
        return self.igScoreLabel
    }
    
    func getIgFoodLabel() -> SKLabelNode{
        return self.igFoodLabel
    }
    
    func getIgDradesCoinLabelNode() -> SKLabelNode{
        return self.igDradesCoinLabelNode
    }


}









