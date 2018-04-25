//
//  GameElements.swift
//  SlimeJumper
//
//  Created by Kramarczyk Jessica N. on 4/9/18.
//  Copyright © 2018 Kramarczyk Jessica N. All rights reserved.
//

import SpriteKit

extension GameScene{
    
    
    func createBackground () -> SKNode{
        
        let backgroundNode = SKNode()
        let spacing = 64 * scaleFactor
        
        for index in 0 ... 19 {
            let node = SKSpriteNode(imageNamed: String(format: "Background%02d", index + 1))
            node.setScale(scaleFactor)
            node.anchorPoint = CGPoint(x: 0.5, y: 0)
            node.position = CGPoint(x: self.size.width / 2, y: spacing * CGFloat(index))
            
            backgroundNode.addChild(node)
        }
        return backgroundNode
    }
    func createMidground () -> SKNode{
        let midgroundNode = SKNode()
        var anchor:CGPoint!
        var xPos:CGFloat!
        
        
        for index in 0 ... 9 {
            var name:String
            let randomNumber = arc4random() % 2
            
            if randomNumber > 0 {
                name = "cloudLeft"
                anchor = CGPoint(x: 0, y: 0.5)
                xPos = 0
            }
            else{
                name = "cloudRight"
                anchor = CGPoint(x: 1, y: 0.5)
                xPos = self.size.width
            }
            
            
            let cloudNode = SKSpriteNode(imageNamed: name)
            cloudNode.anchorPoint = anchor
            cloudNode.position = CGPoint(x: xPos, y: 500 * CGFloat(index))
            
            midgroundNode.addChild(cloudNode)
        }
        return midgroundNode
    }

    func createPlayer() -> SKNode{
        let playerNode = SKNode()
        playerNode.position = CGPoint(x: self.size.width / 2, y: 80)
        
        //let sprite = SKSpriteNode(imageNamed: "Player")

        var sprite = SKSpriteNode()
        TextureAtlas = SKTextureAtlas(named: "Slime")
        
        for i in 0...9{
            let Name = "slime_0\(i).png"
            TextureArray.append(SKTexture(imageNamed: Name))
            
            
        }
        
        sprite = SKSpriteNode (imageNamed: TextureAtlas.textureNames[0] as! String)
        sprite.run(SKAction.repeatForever(SKAction.animate(with: TextureArray, timePerFrame: 0.1)))
        sprite.size = CGSize(width: 45, height: 45)
        
        playerNode.addChild(sprite)
        
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
    
        playerNode.physicsBody?.isDynamic = false
        playerNode.physicsBody?.allowsRotation = false
        
        playerNode.physicsBody?.restitution = 1
        playerNode.physicsBody?.friction = 0
        playerNode.physicsBody?.angularDamping = 0
        playerNode.physicsBody?.linearDamping = 0
        
        playerNode.physicsBody?.usesPreciseCollisionDetection = true
        
//        playerNode.physicsBody?.categoryBitMask = CollisionBitMask.Player
        
        playerNode.physicsBody?.collisionBitMask = CollisionBitMask.Player
        playerNode.physicsBody?.contactTestBitMask = CollisionBitMask.Slime | CollisionBitMask.Rock
        
        
        
        
        return playerNode
    }
    

   
    
    func createPlatformAtPosition (postion:CGPoint, ofType type:PlatformType) -> PlatformNode {
        
        let node = PlatformNode()
        let position = CGPoint(x: postion.x * scaleFactor, y: postion.y)
        node.position = position
        node.name = "PLATFORMNODE"
        node.platformType = type
        
        var sprite:SKSpriteNode
        
        if type == PlatformType.normalRock {
            sprite = SKSpriteNode(imageNamed: "Platform")
        }
        else{
            sprite = SKSpriteNode(imageNamed: "PlatformBreak")
        }
        
        node.addChild(sprite)
        
        node.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionBitMask.Rock
        node.physicsBody?.collisionBitMask = 0
        
        return node
    }
    
    
    func createSlimeAtPosition (postion:CGPoint, ofType type:SlimeType) -> SlimeNode {
        
        let node = SlimeNode()
        
        let position = CGPoint(x: postion.x * scaleFactor, y: postion.y)
        node.position = position
        node.name = "SLIMENODE"
        node.slimeType = type
        
        var sprite:SKSpriteNode
        
        if type == SlimeType.NormalSlime {
            sprite = SKSpriteNode(imageNamed: "slime")
        }
        else{
            sprite = SKSpriteNode(imageNamed: "slimeSpecial")
        }
        
        node.addChild(sprite)
        
        node.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        node.physicsBody?.isDynamic = false
        //node.physicsBody?.categoryBitMask = CollisionBitMask.Slime
        node.physicsBody?.collisionBitMask = CollisionBitMask.Slime
        
        return node
    }
    
}
