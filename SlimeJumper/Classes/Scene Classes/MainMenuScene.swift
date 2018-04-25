//
//  MainMenuScene.swift
//  SlimeJumper
//
//  Created by scott on 2018-04-24.
//  Copyright © 2018 Kramarczyk Jessica N. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MainMenuScene: SKScene {
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            //getting the location of the touch
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Start"{
                let scene = GameScene(size: (view?.bounds.size)!)
                scene.scaleMode = .aspectFit
                view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(2)))
                
            }
            
        }
    }
}
