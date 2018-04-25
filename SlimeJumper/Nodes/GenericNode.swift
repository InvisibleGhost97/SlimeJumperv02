//
//  GenericNode.swift
//  SlimeJumper
//
//  Created by Kramarczyk Jessica N. on 4/9/18.
//  Copyright © 2018 Kramarczyk Jessica N. All rights reserved.
//

import SpriteKit

//struct requirement
struct CollisionBitMask {
    static let Player:UInt32 = 0x00
    static let Slime:UInt32 = 0x01
    static let Rock:UInt32 = 0x02
}

//enum requirement
enum PlatformType:Int {
    case normalRock = 0
    case breakableRock = 1
}



class GenericNode: SKNode {
    func collisionWithPlayer (player: SKNode) -> Bool {
        return false
    }
    
    func shouldRemoveNode (playerY:CGFloat){
        if playerY > self.position.y + 300 {
                self.removeFromParent()
        }
    }
}
