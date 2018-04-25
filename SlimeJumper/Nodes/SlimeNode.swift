//
//  SlimeNode.swift
//  SlimeJumper
//
//  Created by Kramarczyk Jessica N. on 4/9/18.
//  Copyright © 2018 Kramarczyk Jessica N. All rights reserved.
//

import SpriteKit

enum SlimeType:Int {
    case NormalSlime = 0
    case SpecialSlime = 1
}

class SlimeNode: GenericNode {
    var slimeType:SlimeType!
    
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 400)
        
        GameHandler.sharedInstance.score += (slimeType == SlimeType.NormalSlime ? 20 : 100)//if collision equals to a normal slime then give 20 point else give them 100 points
        GameHandler.sharedInstance.slime += (slimeType == SlimeType.NormalSlime ? 1 : 5)

        self.removeFromParent()
        
        return true
    
    }
}
