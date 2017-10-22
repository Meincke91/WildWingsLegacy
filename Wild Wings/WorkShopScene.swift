//
//  WorkShopScene.swift
//  Wild Wings
//
//  Created by Martin Meincke on 10/04/15.
//  Copyright (c) 2015 drades. All rights reserved.
//

import Foundation
import SpriteKit

class WorkShopScene: SKScene, SKPhysicsContactDelegate{
    let characters = Characters()
    let shopHeaders = ["CHARACTERS","POWER-UPS","SCENES","MERCHANDISE"]
    
    let headerContainer = SKNode()
    
    let contentContainer = SKNode()
    var panningActive = false

    
    

    let backLabel = SKLabelNode()
    
    
    func pannedRight(sender:UIPanGestureRecognizer){
        let sender = sender.velocity(in: self.view)
        
        if(!panningActive && contentContainer.position.x > -(684*2) && sender.x < -300){
            print("pannedRight \(sender.x)")
            panningActive = true
            let moveContentContainer = SKAction.moveBy(x: CGFloat(-684), y: 0, duration: 0.5)
            contentContainer.run(moveContentContainer, completion: {self.panningActive = false})
            
            let moveHeaderContainer = SKAction.moveBy(x: -CGFloat(300), y: 0, duration: 0.5)
           
            headerContainer.run(moveHeaderContainer)
        }
        else if(!panningActive && contentContainer.position.x < 0 && sender.x > 300){
            print("pannedLeft \(sender.x)")
            panningActive = true
            let moveContentContainer = SKAction.moveBy(x: CGFloat(684), y: 0, duration: 0.5)
            contentContainer.run(moveContentContainer, completion: {self.panningActive = false})
            
            let moveHeaderContainer = SKAction.moveBy(x: CGFloat(300), y: 0, duration: 0.5)
            
            headerContainer.run(moveHeaderContainer)
        }
        //let moveContentContainer = SKAction.moveToX(84-CGFloat(600)-CGFloat(84), duration: 0.5)

    }

    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(rgb: 0x323232)
        
        let panRight:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector(("pannedRight:")))
        view.addGestureRecognizer(panRight)
        for i in 0..<shopHeaders.count {
            let headerLabel = SKLabelNode()
            headerLabel.text = shopHeaders[i]
            headerLabel.fontSize = 30
            headerLabel.fontName = "HelveticaNeue-Bold"
            headerLabel.fontColor = SKColor.white
            headerLabel.name = shopHeaders[i]
            headerLabel.zPosition = 1.1
            headerLabel.position = CGPoint(x: CGFloat(300*i), y: 0)
            headerContainer.addChild(headerLabel)
            
            let content = SKShapeNode(rect: CGRect(x: CGFloat(684*i), y: 0, width: 600, height: 700))
            content.zPosition = 1.1
            content.name = shopHeaders[i]+"container"
            contentContainer.addChild(content)
            
            if (shopHeaders[i] == "CHARACTERS"){
                for i in 0..<characters.characters.count {
                    let characterContainer = SKNode()
                    characterContainer.name = "characterContainer"+String(i)
                    

                    let characterThumb = SKSpriteNode(imageNamed: characters.characters[i])
                    characterThumb.position = CGPoint(x: 15+characterThumb.size.width/2, y: 15+characterThumb.size.height/2)
                    characterThumb.zPosition = 1.2
                    characterContainer.addChild(characterThumb)
                    
                    let background = SKShapeNode(rect: CGRect(x: 0, y: 0, width: content.frame.width, height: characterThumb.size.height+30))
                    background.fillColor = SKColor.gray
                    background.zPosition = 1.1
                    characterContainer.addChild(background)
                    
                    let characterHeader = SKLabelNode()
                    characterHeader.text = characters.characters[i]
                    characterHeader.fontSize = 25
                    characterHeader.fontName = "HelveticaNeue-Bold"
                    characterHeader.fontColor = SKColor.black
                    characterHeader.position = CGPoint(x: 40+characterThumb.size.width+characterHeader.frame.width/2, y: background.frame.height-characterHeader.frame.height/2-25)
                    characterHeader.zPosition = 1.2
                    characterContainer.addChild(characterHeader)
                    
                    let characterText = SKLabelNode()
                    characterText.text = characters.descriptions[i]
                    characterText.fontSize = 15
                    characterText.fontName = "HelveticaNeue-Bold"
                    characterText.fontColor = SKColor.black
                    characterText.position = CGPoint(x: 40+characterThumb.size.width+characterText.frame.width/2, y: background.frame.height-characterHeader.frame.height/2-characterText.frame.height/2-35)
                    characterText.zPosition = 1.2
                    characterContainer.addChild(characterText)
                    
                    let characterPrice = SKLabelNode()
                    characterPrice.text = String(characters.prices[i])
                    characterPrice.fontSize = 25
                    characterPrice.fontName = "HelveticaNeue-Bold"
                    characterPrice.fontColor = SKColor.black
                    characterPrice.position = CGPoint(x: background.frame.width-characterPrice.frame.width/2-50, y: background.frame.height/2-characterPrice.frame.height/2)
                    characterPrice.zPosition = 1.2
                    characterContainer.addChild(characterPrice)
                    
                    let foodIcon = SKSpriteNode(imageNamed: "apple3")
                    foodIcon.xScale = 0.5
                    foodIcon.yScale = 0.5
                    foodIcon.zPosition = 1.2
                    foodIcon.position = CGPoint(x: background.frame.width-characterPrice.frame.width/2, y: background.frame.height/2-15+foodIcon.frame.height/2)
                    characterContainer.addChild(foodIcon)
                    
                    characterContainer.position = CGPoint(x: 0, y: content.frame.height-(background.frame.height)*(CGFloat(i)+1)-(CGFloat(i)*20))
                    
                    content.addChild(characterContainer)
                    
                    
                }
            }
        }
        headerContainer.position = CGPoint(x: self.size.width/2, y: self.size.height-80)
        
        contentContainer.position = CGPoint(x: 84, y: 150)
        
        
        backLabel.text = "Back"
        backLabel.fontSize = 22
        backLabel.fontColor = SKColor.white
        backLabel.position = CGPoint(x: 80, y: 45)
        backLabel.name = "back"
        backLabel.zPosition = 5
        
        self.addChild(backLabel)
        self.addChild(headerContainer)
        self.addChild(contentContainer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            for i in 0..<shopHeaders.count {
                if(self.atPoint(location).name == shopHeaders[i]){
                    let moveHeaderContainer = SKAction.moveTo(x: self.size.width/2-CGFloat(300*i), duration: 0.5)
                    headerContainer.run(moveHeaderContainer)
                    
                    let moveContentContainer = SKAction.moveTo(x: 84-CGFloat(600*i)-CGFloat(84*i), duration: 0.5)
                    contentContainer.run(moveContentContainer)
                }
            }
            
            if(self.atPoint(location) == backLabel){
                self.removeAllChildren()
                self.removeAllActions()
                
                let gameScene = GameScene(size: self.size)
                let transition = SKTransition.fade(withDuration: 0.9)
                self.scene?.view?.presentScene(gameScene, transition: transition)
                print("go back to game scene or home screen")
            }
            for i in 0..<characters.characters.count {
                if(self.atPoint(location).parent?.name == "characterContainer"+String(i)){
                    print("character "+String(i)+" pushed")
                    gameData.setActiveCharacter(character: i)
                }
            }
        }
    }
    
    
}
