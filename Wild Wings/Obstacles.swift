//
//  Obstacles.swift
//  Wild Wings
//
//  Created by Martin Meincke on 24/03/15.
//  Copyright (c) 2015 drades. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacles : GameScene {
    var obstacleNodes :[SKSpriteNode] = []
    let obstacle_node = SKNode()
    let gameScene = GameScene()
    let bg_tree_size = SKSpriteNode(imageNamed: "treeElement").size
    let hollowTree1 = SKSpriteNode(imageNamed: "hollowTree1")
    let hollowTree2 = SKSpriteNode(imageNamed: "hollowTree2")
    let hollowBird1 = SKSpriteNode(imageNamed: "hollowBird1")
    
    var sideRandomDis = 0
    func initObstacles(viewSize : CGSize){
        sideRandomDis = 0
        if obstacleNodes.count == 0 {
            for _ in 0..<6 {
                let branch = SKSpriteNode(imageNamed: "branch1")
                branch.position = CGPoint(x: -branch.size.width*5, y:  -branch.size.height*4)
                branch.physicsBody = SKPhysicsBody(rectangleOf: branch.size)
                branch.physicsBody!.isDynamic = false
                branch.physicsBody!.categoryBitMask = ColliderType.obstacle.rawValue
                branch.physicsBody!.contactTestBitMask = ColliderType.playerCol.rawValue
                branch.name = "branch"
                branch.zPosition = 3.0
                obstacleNodes.append(branch)
                obstacle_node.addChild(branch)
            }
           for _ in 0..<6 {
                let branch = SKSpriteNode(imageNamed: "branch2")
                branch.position = CGPoint(x: -branch.size.width*5, y:  -branch.size.height*4)
                branch.physicsBody = SKPhysicsBody(rectangleOf: branch.size)
                branch.physicsBody!.isDynamic = false
                branch.physicsBody!.categoryBitMask = ColliderType.obstacle.rawValue
                branch.physicsBody!.contactTestBitMask = ColliderType.playerCol.rawValue
                branch.name = "branch2"
                branch.zPosition = 3.0
                obstacleNodes.append(branch)
                obstacle_node.addChild(branch)
            }
            
            for _ in 0..<4 {
                let branch = SKSpriteNode(imageNamed: "branch3")
                branch.position = CGPoint(x: -branch.size.width*5, y:  -branch.size.height*4)
                branch.physicsBody = SKPhysicsBody(rectangleOf: branch.size)
                branch.physicsBody!.isDynamic = false
                branch.physicsBody!.categoryBitMask = ColliderType.obstacle.rawValue
                branch.physicsBody!.contactTestBitMask = ColliderType.playerCol.rawValue
                branch.name = "branch3"
                branch.zPosition = 3.0
                obstacleNodes.append(branch)
                obstacle_node.addChild(branch)
            }
            
            
            hollowTree1.position = CGPoint(x: -hollowTree1.size.width*5, y:  -hollowTree1.size.height*2)
            hollowTree1.name = "hollowTree1"
            hollowTree1.zPosition = 3.0
            obstacleNodes.append(hollowTree1)
            obstacle_node.addChild(hollowTree1)
            
            
            hollowTree2.position = CGPoint(x: -hollowTree2.size.width*5, y:  -hollowTree2.size.height*2)
            hollowTree2.name = "hollowTree2"
            hollowTree2.zPosition = 3.0
            obstacleNodes.append(hollowTree2)
            obstacle_node.addChild(hollowTree2)
            
            
            hollowBird1.position = CGPoint(x: -hollowBird1.size.width*5, y:  -hollowBird1.size.height*2)
            hollowBird1.physicsBody = SKPhysicsBody(rectangleOf: hollowBird1.size)
            hollowBird1.physicsBody!.isDynamic = false
            hollowBird1.physicsBody!.categoryBitMask = ColliderType.obstacle.rawValue
            hollowBird1.physicsBody!.contactTestBitMask = ColliderType.playerCol.rawValue
            hollowBird1.name = "hollowBird1"
            hollowBird1.zPosition = 3.0
            
            print("start wirdrg: \(viewSize)")
            let moveHollowBird = SKAction.moveBy(x: viewSize.width-bg_tree_size.width*1.2,  y: 0, duration: 1)
            let moveHollowBirdBack = SKAction.moveBy(x: -viewSize.width+bg_tree_size.width*1.2,  y: 0, duration: 1)
            let moveHollowBirdAction = SKAction.repeatForever(SKAction.sequence([
                moveHollowBird,
                SKAction.fadeAlpha(to: 0, duration: 0.05),
                SKAction.wait(forDuration: 0.3),
                SKAction.scaleX(to: -1, duration: 0.01),
                SKAction.fadeAlpha(to: 1, duration: 0.05),
                moveHollowBirdBack,
                SKAction.fadeAlpha(to: 0, duration: 0.05),
                SKAction.wait(forDuration: 0.3),
                SKAction.scaleX(to: 1, duration: 0.1),
                SKAction.fadeAlpha(to: 1, duration: 0.05)
                ]))
            
            hollowBird1.run(moveHollowBirdAction)
            print("activatin bird animation")
            
            obstacleNodes.append(hollowBird1)
            obstacle_node.addChild(hollowBird1)
        }
    }

    
    func addNewObstacle(viewSize: CGSize){
        let sideRandomtresh = 3
        let randomNumber:Int = Int(arc4random() % 100)
        
        if randomNumber <= 15 {
            for obstacle in obstacleNodes {
                if obstacle.name == "branch" && obstacle_node.position.y+obstacle.position.y < 0{
                    print("should make branch")
                    
                    if arc4random() % 2 == 0 && sideRandomDis > -sideRandomtresh || sideRandomDis > sideRandomtresh{
                        obstacle.xScale = 2
                        obstacle.position = CGPoint(x: bg_tree_size.width + obstacle.size.width/4,y: bg_tree_size.height*7)
                        sideRandomDis -= 1
                    }
                    else {
                        obstacle.xScale = -2
                        obstacle.position = CGPoint(x: viewSize.width - bg_tree_size.width - obstacle.size.width/4, y: bg_tree_size.height*7+(-1)*obstacle_node.position.y)
                        sideRandomDis -= 1
                    }
                    break
                }
            }
        }
        else if randomNumber > 15 && randomNumber <= 30 {
            for obstacle in obstacleNodes {
                
                if obstacle.name == "branch2" && obstacle_node.position.y+obstacle.position.y < 0{
                    if arc4random() % 2 == 0 && sideRandomDis > -sideRandomtresh || sideRandomDis > sideRandomtresh{
                        obstacle.xScale = 2.5
                        obstacle.position = CGPoint(x: bg_tree_size.width + obstacle.size.width/4, y: bg_tree_size.height*7+(-1)*obstacle_node.position.y)
                         sideRandomDis -= 1
                    }
                    else {
                        obstacle.xScale = -2.5
                        obstacle.position = CGPoint(x: viewSize.width - bg_tree_size.width - obstacle.size.width/4, y: bg_tree_size.height*7+(-1)*obstacle_node.position.y)
                        sideRandomDis += 1
                    }
                    
                    break
                }
            }
        }
        else if randomNumber > 30 && randomNumber <= 50 {
            for obstacle in obstacleNodes {
                
                if obstacle.name == "branch3" && obstacle_node.position.y+obstacle.position.y < 0{
                    if arc4random() % 2 == 0 && sideRandomDis > -sideRandomtresh || sideRandomDis > sideRandomtresh{
                        obstacle.xScale = 2
                        obstacle.position = CGPoint(x: bg_tree_size.width*0.8,y: bg_tree_size.height*7+(-1)*obstacle_node.position.y)
                        sideRandomDis -= 1
                    }
                    else {
                        obstacle.xScale = -2
                        obstacle.position = CGPoint(x: viewSize.width - bg_tree_size.width*0.8, y: bg_tree_size.height*7+(-1)*obstacle_node.position.y)
                        sideRandomDis += 1
                    }
                    
                    break
                }
            }
        }
        else if randomNumber > 50 && randomNumber <= 60 {
            let startPos = bg_tree_size.height*7
            
            print("hollow bird position")
            print(obstacle_node.position.y)
            print("hollowTree1: ", terminator: "")
            print(hollowTree1.position.y)
            print("hollowTree2: ", terminator: "")
            print(hollowTree2.position.y)
            print(startPos)
            
            if obstacle_node.position.y+hollowTree1.position.y < 0{
                if arc4random() % 2 == 0 {
                    hollowTree1.xScale = 1
                    hollowTree1.position = CGPoint(x: bg_tree_size.width/2,y: bg_tree_size.height*7+(-1)*obstacle_node.position.y)
                    hollowTree2.xScale = -1
                    hollowTree2.position = CGPoint(x: viewSize.width - bg_tree_size.width/2, y: bg_tree_size.height*7+(-1)*obstacle_node.position.y)
                    
                    
                }
                else {
                    hollowTree1.xScale = -1
                    hollowTree1.position = CGPoint(x: viewSize.width - bg_tree_size.width/2, y: bg_tree_size.height*7+(-1)*obstacle_node.position.y)
                    hollowTree2.xScale = 1
                    hollowTree2.position = CGPoint(x: bg_tree_size.width/2, y: bg_tree_size.height*7+(-1)*obstacle_node.position.y)
                }
                hollowBird1.removeAllActions()
                hollowBird1.xScale = 1
                hollowBird1.position = CGPoint(x: bg_tree_size.width/2, y: bg_tree_size.height*7+(-1)*obstacle_node.position.y)
                
                let moveHollowBird = SKAction.moveBy(x: viewSize.width-(bg_tree_size.width*1.2),  y: 0, duration: 1)
                let moveHollowBirdBack = SKAction.moveBy(x: -viewSize.width+(bg_tree_size.width*1.2),  y: 0, duration: 1)
                let moveHollowBirdAction = SKAction.repeat(SKAction.sequence([
                    moveHollowBird,
                    SKAction.fadeAlpha(to: 0, duration: 0.05),
                    SKAction.wait(forDuration: 0.3),
                    SKAction.scaleX(to: -1, duration: 0.01),
                    SKAction.fadeAlpha(to: 1, duration: 0.05),
                    moveHollowBirdBack,
                    SKAction.fadeAlpha(to: 0, duration: 0.05),
                    SKAction.wait(forDuration: 0.3),
                    SKAction.scaleX(to: 1, duration: 0.1),
                    SKAction.fadeAlpha(to: 1, duration: 0.05)
                    ]), count: 100)
                
                hollowBird1.run(moveHollowBirdAction)
            }
        }
    }

    func startMoveObstacles(viewSize : CGSize){
        let moveSideAction = SKAction.moveBy(x: 0,  y: -gameScene.getSideSpeed(), duration: 0.05)
        let moveSideForeverAction = SKAction.repeatForever(SKAction.sequence([moveSideAction]))
        obstacle_node.run(moveSideForeverAction)

    }
    
    func stopMoveObstacles(){
        obstacle_node.removeAllActions()
        hollowBird1.removeAllActions()
    }
    
    func speedUpObstacles(){
        let moveSideAction = SKAction.moveBy(x: 0,  y: -gameScene.getSideSpeed(), duration: 0.05)
        let moveSideForeverAction = SKAction.repeatForever(SKAction.sequence([moveSideAction]))
        obstacle_node.removeAllActions()
        obstacle_node.run(moveSideForeverAction)
    }
    
    func removeAllObstacles(){
        for obstacle in obstacleNodes{
            obstacle.position = CGPoint(x: bg_tree_size.width * 3,y: -bg_tree_size.height*7)
        }
    }
    
    // getters
    func getObstacles() -> SKNode{
        return obstacle_node
    }
    
}
