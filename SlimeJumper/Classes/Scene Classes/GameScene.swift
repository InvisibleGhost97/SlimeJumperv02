//
//  GameScene.swift
//  SlimeJumper
//
//  Created by Kramarczyk Jessica N. on 4/9/18.
//  Copyright © 2018 Kramarczyk Jessica N. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    var background:SKNode!
    var midground:SKNode!
    var foreground:SKNode!
    
    var hud:SKNode!
    
    var player:SKNode!
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    
    var scaleFactor:CGFloat!
    
    var startButton = SKSpriteNode(imageNamed: "TapToStart")
    
    var endOfGamePosition = 0
    
    let motionManager = CMMotionManager()
    
    var xAcceleration:CGFloat = 0.0
    
    var scoreLabel:SKLabelNode!
    var slimeLabel:SKLabelNode!
    
    var playerMaxY:Int!
    var gameOver = false

    var currentMaxY:Int!
    
    var lava:SKEmitterNode!
    var slimeParticle:SKEmitterNode!
    
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(size:CGSize){
        super.init(size: size)
        
        backgroundColor = SKColor.white //setting the background color
        
         let levelData = GameHandler.sharedInstance.levelData
        
        currentMaxY = 80    //the initial position
        GameHandler.sharedInstance.score = 0    //setting score to 0
        gameOver = false
        
        //defining end of the game position
        endOfGamePosition = (levelData!["EndY"]! as AnyObject).integerValue
        
        scaleFactor = self.size.width / 320
        
        background = createBackground()
        addChild(background)
        
        midground = createMidground()
        addChild(midground)
        
        foreground = SKNode()
        addChild(foreground)
        
        
        hud = SKNode()
        addChild(hud)
        
        startButton.position = CGPoint(x: self.size.width/2, y: 180)
        hud.addChild(startButton)
        
        
        
        //------------
        
        //creating a slime to show how many slimes are collected
        let slime = SKSpriteNode(imageNamed: "slime")
        slime.position = CGPoint (x: 25, y: self.size.height-30)
        hud.addChild(slime)
        
        slimeLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        slimeLabel.fontSize = 30
        slimeLabel.fontColor = SKColor.white
        slimeLabel.position = CGPoint(x: 50, y: self.size.height-40)
        slimeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        slimeLabel.text = " \(GameHandler.sharedInstance.slime)"    //get the amount of slimes collected from the shared instnce
        hud.addChild(slimeLabel)
        
        scoreLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width-20, y: self.size.height-40)
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        scoreLabel.text = "0"
        hud.addChild(scoreLabel)
        
        
        //------------
        
        lava = SKEmitterNode(fileNamed: "Lava")
        lava.position = CGPoint(x: 50, y: 0)
        lava.advanceSimulationTime(10)
        self.addChild(lava)
        lava.zPosition = 1
        
        
        player = createPlayer()
        foreground.addChild(player)
        
        //let platform = createPlatformAtPosition(postion: CGPoint(x: 160, y: 320), ofType: PlatformType.normalRock)
        //foreground.addChild(platform)
        
        //using a dictionary structure to get the platforms
        let platforms = levelData?["Platforms"] as! NSDictionary     //use the leveldata and access the platformsand cast them to NSDictionary again
        let platformPatterns = platforms["Patterns"] as! NSDictionary   //use the platfrom patterns and access the patterns and cast them to NSDictionary
        let platformPositions = platforms["Positions"] as! [NSDictionary]    //this is the same as above but now there are an array of NSDictionaries
        
        
        for platformPosition in platformPositions {
            let x = (platformPosition["x"] as AnyObject).floatValue   //getting the x value
            let y = (platformPosition["y"] as AnyObject).floatValue   //getting the y value
            let pattern = platformPosition["pattern"] as! NSString  //use pattern getting the platform position values and casting them to strings
            
            let platformPattern = platformPatterns[pattern] as! [NSDictionary]      //look up the patterns
            //iterating through the platform patterns
            for platformPoint in platformPattern{
                //the x and y value of the platform
                let xValue = (platformPoint["x"] as AnyObject).floatValue
                let yValue = (platformPoint["y"] as AnyObject).floatValue
                //whether the platform is breakable or not
                let type = PlatformType(rawValue: (platformPoint["type"]! as AnyObject).integerValue)
                //the position of the platform
                let xPosition = CGFloat(xValue! + x!)
                let yPosition = CGFloat(yValue! + y!)
                
                //
                let platformNode = createPlatformAtPosition(postion: CGPoint(x: xPosition, y: yPosition), ofType: type!)
                foreground.addChild(platformNode)
            }
        }
        
        //let slime = createSlimeAtPosition(postion: CGPoint(x: 160, y: 220), ofType: SlimeType.SpecialSlime)
        //foreground.addChild(slime)
        
        //using a dictionary structure to get the platforms
        let slimes = levelData!["Slimes"] as! NSDictionary     //use the leveldata and access the platformsand cast them to NSDictionary again
        let slimePatterns = slimes["Patterns"] as! NSDictionary   //use the platfrom patterns and access the patterns and cast them to NSDictionary
        let slimePositions = slimes["Positions"] as! [NSDictionary]    //this is the same as above but now there are an array of NSDictionaries
        
        
        for slimePosition in slimePositions {
            let x = (slimePosition["x"] as AnyObject).floatValue   //getting the x value
            let y = (slimePosition["y"] as AnyObject).floatValue   //getting the y value
            let pattern = slimePosition["pattern"] as! NSString  //use pattern getting the platform position values and casting them to strings
            
            let slimePattern = slimePatterns[pattern] as! [NSDictionary]      //look up the patterns
            //iterating through the platform patterns
            for slimePoint in slimePattern{
                //the x and y value of the platform
                let xValue = (slimePoint["x"] as AnyObject).floatValue
                let yValue = (slimePoint["y"] as AnyObject).floatValue
                //whether the platform is breakable or not
                let type = SlimeType(rawValue: (slimePoint["type"]! as AnyObject).integerValue)
                //the position of the platform
                let xPosition = CGFloat(xValue! + x!)
                let yPosition = CGFloat(yValue! + y!)
                
                //
                let slimeNode = createSlimeAtPosition(postion: CGPoint(x: xPosition, y: yPosition), ofType: type!)
                foreground.addChild(slimeNode)
            }
        }
        
        
        
        
        
        
        //adding gravity to the world
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        physicsWorld.contactDelegate = self
        
    
    }
    
    public func didBegin(_ contact: SKPhysicsContact){
        var otherNode:SKNode!
        var updateHUD = false
        
        if contact.bodyA.node != player{
            otherNode = contact.bodyA.node
        }
            //if the body a is the player
        else{
            otherNode = contact.bodyB.node
        }
        
        updateHUD = (otherNode as! GenericNode).collisionWithPlayer(player: player)
        
        //if it is necessary to update the hud
        //updating the score
        if updateHUD{
            slimeLabel.text =  "  \(GameHandler.sharedInstance.slime)"
            scoreLabel.text =  "\(GameHandler.sharedInstance.score)"

        }
        
        //casting the otherNode to a generic Node
       /* if let genericNode = otherNode as? GenericNode {
            let didHit = genericNode.collisionWithPlayer(player: player)
            
            if didHit {
                // do this
                player.physicsBody?.applyImpulse(CGVector(dx: 0 , dy: 0))
                
            }
        }*/
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        
        
        //check if players physcis body is dynmaic and therefoe we are already playing the game
        if player.physicsBody!.isDynamic{
            return
        }
        startButton.removeFromParent()//getting rid of the start button
        
        player.physicsBody?.isDynamic = true
        player.physicsBody?.applyImpulse(CGVector(dx: 0 , dy: 20))
    }
    
    override func update(_ currentTime: CFTimeInterval){
        
        if gameOver{
            return
        }
        
        //hanlding and removing the unused elements that don't matter anymore
        foreground.enumerateChildNodes(withName: "PLATFORMNODE") {(node, stop) -> Void in
            let platform = node as! PlatformNode
            platform.shouldRemoveNode(playerY: self.player.position.y)
        }
        
        foreground.enumerateChildNodes(withName: "SLIMENODE") {(node, stop) -> Void in
            let slime = node as! SlimeNode
            slime.shouldRemoveNode(playerY: self.player.position.y)
        }
        
        //changing the position of all three bacjground elements
        if player.position.y > 200 {
            background.position = CGPoint(x: 0, y: -((player.position.y - 200)/10)) // moving the background by its CGPoint //dividing the BG by 10 to get a parallaxing view for different speeds for different elements in the game
            midground.position = CGPoint(x: 0, y: -((player.position.y - 200)/4))// moving the midground by its CGPoint //dividing the BG by 4 to get a parallaxing view for different speeds for different elements in the game
            foreground.position = CGPoint(x: 0, y: -((player.position.y - 200)))// moving the foreground by its CGPoint

        }
        
        //awarding points depending on the height
        if Int(player.position.y) > currentMaxY {
            GameHandler.sharedInstance.score += Int(player.position.y) - currentMaxY //add the diff. between the current position and the current maxY
            currentMaxY = Int(player.position.y)
            scoreLabel.text = "\(GameHandler.sharedInstance.score)"
            
        }
        //if the player reached the top of the world or if they fell too far down
        if Int(player.position.y) > endOfGamePosition || Int(player.position.y) < currentMaxY - 800{
            endGame()
        }
        
    }
    
    func endGame(){
        gameOver = true
        GameHandler.sharedInstance.saveGameStats()
        
        
        let transition = SKTransition.fade(withDuration: 0.5)
        let endGameScene = EndGame(size: self.size)
        self.view?.presentScene(endGameScene, transition: transition)
        
        
        
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch : AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            player.position.x += amountDragged
        }
    }


}
