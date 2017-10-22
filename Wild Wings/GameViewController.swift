//
//  GameViewController.swift
//  Wild Wings
//
//  Created by Martin Meincke on 23/03/15.
//  Copyright (c) 2015 drades. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var scene: GameScene!
    override func viewDidLoad() {
        super.viewDidLoad()
            // Configure the view.
            let skView = view as! SKView
            
            skView.showsFPS = false
            skView.showsNodeCount = false
            //skView.showsPhysics = true;
            // Create and configure the scene.
            scene = GameScene(size: skView.bounds.size)
            skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
            // #1
            
            // Present the scene.
            skView.presentScene(scene)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
