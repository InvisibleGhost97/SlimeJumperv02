//
//  EndGame.swift
//  SlimeJumper
//
//  Created by scott on 2018-04-24.
//  Copyright © 2018 Kramarczyk Jessica N. All rights reserved.
//

import SpriteKit

class EndGame: SKScene {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        let slime = SKSpriteNode(imageNamed: "slime")
        slime.position = CGPoint(x: 25, y: self.size.height-30)
        addChild(slime)
        
        let slimeLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        slimeLabel.fontSize = 30
        slimeLabel.fontColor = SKColor.white
        slimeLabel.position = CGPoint(x: 50, y: self.size.height-40)
        slimeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        slimeLabel.text = "\(GameHandler.sharedInstance.slime)"
        addChild(slimeLabel)
        
        
        let scoreLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: 300)
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        scoreLabel.text = "\(GameHandler.sharedInstance.score)"
        addChild(scoreLabel)
        
        
        let highScoreLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        highScoreLabel.fontSize = 30
        highScoreLabel.fontColor = SKColor.red
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: 450)
        highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        highScoreLabel.text = "\(GameHandler.sharedInstance.highscore)"
        addChild(highScoreLabel)
        
        let tryAgainLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        tryAgainLabel.fontSize = 30
        tryAgainLabel.fontColor = SKColor.white
        tryAgainLabel.position = CGPoint(x: self.size.width/2, y: 50)
        tryAgainLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        tryAgainLabel.text = "Tap to Play Again"
        addChild(tryAgainLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameScene = GameScene(size: self.size)
        self.view?.presentScene(gameScene, transition: transition)
    }
    
    
}
