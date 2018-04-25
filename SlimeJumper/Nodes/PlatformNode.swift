//
//  PlatformNode.swift
//  SlimeJumper
//
//  Created by Kramarczyk Jessica N. on 4/9/18.
//  Copyright © 2018 Kramarczyk Jessica N. All rights reserved.
//


import SpriteKit

class PlatformNode: GenericNode {
    var platformType:PlatformType!
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        //we only want to react if the player falls
        if (player.physicsBody?.velocity.dy)! < CGFloat(0) {
        
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 250)    //aplying new venlocity with 250
            
            //checking if the platform type is brakable
            if platformType == PlatformType.breakableRock{
                self.removeFromParent()
            }
        }
        
        return false
    }
    
}
