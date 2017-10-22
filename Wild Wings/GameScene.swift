//
//  GameScene.swift
//  Wild Wings
//
//  Created by Martin Meincke on 23/03/15.
//  Copyright (c) 2015 drades. All rights reserved.
//
import Foundation
import SpriteKit

let background = Background()
let characters = Characters()
let obstacles = Obstacles()
let gameOver = GameOver()
let powerUps = PowerUps()
let objectives = Objectives()
let gameData = GameData()
let gameScene = GameScene()


var isInit = false
//currently active game 
var points = 0
var food = 0
var level = 1
var sideSpeed : CGFloat = 0

// gameState 0 - game is loading
// gameState 1 - pregame state
// gameState 2 - game running
// gameState 3 - game over
// gameState 4 - init game animation
// gameState 5 - tutorial

var gameState = 0

//Bitmask categories
enum ColliderType: UInt32 {
    case playerCol = 1
    case edgeCol = 2
    case bottomEdgeCol = 4
    case foodCol = 8
    case obstacle = 16
}

class GameScene:  SKScene, SKPhysicsContactDelegate {
    var appleHit = false
    var sideHit = false
    var lastUpdateTime : CFTimeInterval = 0
    
    //game variables
    
    
    var activeBird = 0 // bird that is flying the character
    // how fast the sides are moving
    var appleChance : UInt32 = 80 // % chance an apple will spawn
    var mainGravity: CGFloat = 15
    
    override func didMove(to view: SKView) {
        //active character
        let activeCharacterIndex = gameData.getActiveCharacter() // character is currently in use
        
        self.removeAllActions()
        self.removeAllChildren()

        // set gameState to loading
        gameState = 0
        points = 0
        food = 0
        level = 1
        sideSpeed = 10.5
        physicsWorld.contactDelegate = self
        view.showsPhysics = true
        //set the background color
        self.backgroundColor = UIColor(rgb: 0x6f9698)
        
        if !isInit{
            print("running init")
            
            background.initPreGameLabels(viewSize: self.size)
            background.initInGameLabels(viewSize: self.size)
            background.initBackgroundNodes(viewSize: self.size)
            background.initMoveWithSideNodes(viewSize: self.size)
            obstacles.initObstacles(viewSize: self.size)
            if apples.count == 0 {
                apples.append(powerUps.initApple(viewSize: self.size))
            }
            isInit = true
        }
        
        self.addChild(background.getBgNode())
        
        // change gameState to pregame
        gameState = 1
        background.reArrangeMoveWithSides(viewSize: self.size)
        self.addChild(background.getPregameNode())
        
        self.addChild(background.getMoveWithSide())
        self.addChild(obstacles.getObstacles())
        // initialize apples

        for apple in apples{
            self.addChild(apple)
        }
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody!.categoryBitMask = ColliderType.edgeCol.rawValue
        self.physicsBody!.contactTestBitMask = ColliderType.edgeCol.rawValue
        
        self.addChild(characters.mainCharacter(characterIndex: activeCharacterIndex,startPos: CGPoint(x: self.size.width/2,y: self.size.height/6)))
        
        // add main collision boxes
        for element in background.initMainCollisionBoxes(viewSize: self.size) {
            self.addChild(element)
        }
        
        background.updatePreGameLabels()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).location(in: self)
            
            // if shopLabel is clicked
            if self.atPoint(location).name == "shopLabel" || self.atPoint(location).name == "shopLabelContainer"{
                workShopSwitch()
            }
                
            // check if game state is in pregame state
            else if gameState == 1{
                 gameState = 4
                //gameStart()
                background.getPregameNode().removeFromParent()
                self.addChild(background.getInGameNode())
                background.startMoveSides()
                background.updateFoodLabel()
                background.updateScoreLabel()
                
                let moveToStartPosition = SKAction.move(to: CGPoint(x: self.frame.width/2,y: self.frame.height/2), duration: 2.0)
                
                let moveWater1ToStartPosition = SKAction.move(to: CGPoint(x: self.frame.width/2,y: self.frame.height/2-40), duration: 0.4)
                
                let moveWater2ToStartPosition = SKAction.move(to: CGPoint(x: self.frame.width/2-30,y: self.frame.height/2-55), duration: 0.4)
                
                background.bg_water1.run(moveWater1ToStartPosition)
                background.bg_water2.run(moveWater2ToStartPosition)
                characters.getCharacterNode().run(moveToStartPosition, completion: {self.gameStart()})
            }
            else if gameState == 2{
                    let characterNode = characters.getCharacterNode()
                    let maxBirdSpeed = characters.getMaxBirdSpeed()
                    
                    if location.x > self.size.width/2{
                        characters.turnCharacterRight()
                    }
                    else{
                        characters.turnCharacterLeft();
                    }
                    
                    if characterNode.physicsBody!.velocity.dy < maxBirdSpeed{
                        characterNode.physicsBody!.applyImpulse(CGVector(dx: 0.0, dy: characters.getBirdJumpForce()))
                        if characterNode.physicsBody!.velocity.dy > maxBirdSpeed{
                            characterNode.physicsBody?.velocity.dy = maxBirdSpeed
                        }
                    }
                    else{
                        return
                    }
            }
            else if gameState == 3 && self.atPoint(location).name == "gameOverOverlay"{
                gameOverSwitch()
            }
        }
    }
   
    override func update(_ currentTime: CFTimeInterval) {
        let timeSinceLastUpdate = currentTime - lastUpdateTime
        if timeSinceLastUpdate > 0.5 && gameState == 2 {
            lastUpdateTime = currentTime
            
            points = points + 1
            background.updateScoreLabel()
            background.sideNodeReset(viewSize: self.size)
            obstacles.addNewObstacle(viewSize: self.size)
            powerUps.resetApples()
            powerUps.addNewApple(viewSize: self.size)
            
            if Int(points/5) > level && level <= 30{
                
                updateSideSpeed()
                print(level)
                background.speedUpSides()
                obstacles.speedUpObstacles()
                level = level + 1
            }
            sideHit = false
        }
        
        if appleHit{
            apples[0].position = CGPoint(x: 0, y: self.size.height+100)
            apples[0].removeAllActions()
            appleHit = false
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("did begin contact")
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch(contactMask) {
        case ColliderType.playerCol.rawValue | ColliderType.edgeCol.rawValue:
            if contact.bodyA.categoryBitMask == ColliderType.edgeCol.rawValue && !sideHit{
                print("hit side")
                gameStop()
                //background.updateScoreLabel()
                //characters.turnCharacter(self.size)
                sideHit = true
            }
        case ColliderType.playerCol.rawValue | ColliderType.bottomEdgeCol.rawValue:
            gameStop()
        case ColliderType.playerCol.rawValue | ColliderType.obstacle.rawValue:
            print("You loose")
            let branchSplinter = SKEmitterNode(fileNamed: "particleBranch.sks")
            branchSplinter!.zPosition = 3
            
            if contact.bodyA.node?.name == "branch" {
                branchSplinter!.position = contact.bodyA.node!.position
                self.addChild(branchSplinter!)
            }
            else if contact.bodyB.node?.name == "branch" {
                branchSplinter!.position = contact.bodyB.node!.position
                self.addChild(branchSplinter!)
            }
            else if contact.bodyA.node?.name == "branch2" {
                branchSplinter!.xScale = 0.5
                branchSplinter!.position = contact.bodyA.node!.position
                self.addChild(branchSplinter!)
            }
            else if contact.bodyB.node?.name == "branch2" {
                branchSplinter!.xScale = 0.5
                branchSplinter!.position = contact.bodyB.node!.position
                self.addChild(branchSplinter!)
            }
            gameStop()
        case ColliderType.foodCol.rawValue | ColliderType.bottomEdgeCol.rawValue:
            if contact.bodyA.categoryBitMask == ColliderType.foodCol.rawValue {
                contact.bodyA.node!.removeFromParent()
                contact.bodyA.node!.removeAllActions()
            }
            else {
                contact.bodyB.node!.removeFromParent()
                contact.bodyB.node!.removeAllActions()
            }
        case ColliderType.playerCol.rawValue | ColliderType.foodCol.rawValue:
            if !appleHit{
                var pointOfBurst = contact.bodyB.node!.position
                if contact.bodyA.categoryBitMask == ColliderType.foodCol.rawValue {
                    pointOfBurst = contact.bodyA.node!.position
                }
                let appleSparkEmitter = SKEmitterNode(fileNamed: "particleApple.sks")
                appleSparkEmitter!.position = pointOfBurst
                appleSparkEmitter!.zPosition = 2.9
                self.addChild(appleSparkEmitter!)
                food += 1
                points = points + 5
                appleHit = true
                background.updateFoodLabel() //update Food label
                background.updateScoreLabel()
            }
        default:
            return
        }
    }
    

    func gameStart(){
        print("game started")
        for label in objectives.objectiveLabels(viewSize: self.size){
            self.addChild(label)
            objectives.startLabelMove(label: label)
        }
        gameState = 2
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -mainGravity)
        
        
        obstacles.startMoveObstacles(viewSize: self.size)

        characters.startCharacter() 
        
    }
    
    func gameStop(){
        gameState = 3
        print("game stopped")
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        characters.stopCharacter()
        background.stopMoveSides()
        obstacles.stopMoveObstacles()
        powerUps.stopPowerUps()
        
        gameOver.initGameOverOverlay(viewSize: self.size)
        self.addChild(gameOverOverlay)
    }
    
    func gameOverSwitch(){
        updateScoreAndFood()
        obstacles.removeAllObstacles()
        self.removeAllChildren()
        self.removeAllActions()
        apples[0].position = CGPoint(x: 0, y: self.size.height+100)
        apples[0].removeAllActions()
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: self.size)
        self.scene?.view?.presentScene(gameOverScene, transition: transition)
        print("go to gameOverScene")
    }
    
    func workShopSwitch(){
        self.removeAllChildren()
        self.removeAllActions()
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let workShopScene = WorkShopScene(size: self.size)
        self.scene?.view?.presentScene(workShopScene, transition: transition)
        print("go to WorkShopScene")
    }
    
    func gamePause(){
        
    }
    
    func updateScoreAndFood(){
        if points > gameData.getHighscore() {
            gameData.setHighscore(points: points)
        }
    
        gameData.setFood(food: food)
    }
    
    func randomCGDouble() -> Double {
        return Double(arc4random()) /  Double(UInt32.max)
    }
    
    func updateSideSpeed(){
        sideSpeed = sideSpeed+0.3
    }
    
    func getSideSpeed() -> CGFloat{
        print(sideSpeed)
        return sideSpeed
    }
}











