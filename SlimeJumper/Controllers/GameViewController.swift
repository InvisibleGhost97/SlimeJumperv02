//
//  GameViewController.swift
//  SlimeJumper
//
//  Created by Kramarczyk Jessica N. on 4/9/18.
//  Copyright © 2018 Kramarczyk Jessica N. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds

class GameViewController: UIViewController{
    
    override func viewDidLoad(){
    super.viewDidLoad()
    let skView = self.view as! SKView
        
        
        var adBanner: GADBannerView!
        
        adBanner = GADBannerView(adSize:kGADAdSizeBanner)
        
        
        
        
        //banner id
        adBanner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adBanner.rootViewController = self
        addBannerViewToView(adBanner)
        
        
        let request: GADRequest = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adBanner.load(request)
        
        
    
    let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFit
    skView.presentScene(scene)
 
        
        
        /*
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = SKScene.init(fileNamed: "MainMenuScene")
            
            // Set the scale mode to scale to fit the window
            scene!.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            
        }*/
        
        
        
        
        
    }
    
    
    /*var adBanner: GADBannerView!
    
    //override func viewDidLoad(){
    
    @IBAction func PlayGame(){
        
        
        adBanner = GADBannerView(adSize:kGADAdSizeBanner)
        
        
    //super.viewDidLoad()
        if let view = self.view as! SKView? {
    
            //banner id
        adBanner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adBanner.rootViewController = self
            addBannerViewToView(adBanner)
            
            if let scene = SKScene (fileNamed: "Game Scene"){
                let request: GADRequest = GADRequest()
                request.testDevices = [kGADSimulatorID]
                adBanner.load(request)
                //set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                //presen  the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
 
        
        
    //let scene = GameScene(size: skView.bounds.size)
        
        
        
        
        
   // scene.scaleMode = .aspectFit
   // skView.presentScene(scene)
    
    }
*/
    func addBannerViewToView(_ bannerView: GADBannerView){
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints([NSLayoutConstraint(item: bannerView,
                                                attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: bottomLayoutGuide,
                                                attribute: .top,
                                                multiplier: 1,
                                                constant: 0),
                             NSLayoutConstraint(item: bannerView,
                                                attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .centerX,
                                                multiplier: 1,
                                                constant: 0)])
    }
    
   /* override func viewDidLoad() {
       var adBanner: GADBannerView!
        
        adBanner = GADBannerView(adSize:kGADAdSizeBanner)
        
        
       
            
            //banner id
            adBanner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            adBanner.rootViewController = self
            addBannerViewToView(adBanner)
            
        
                let request: GADRequest = GADRequest()
                request.testDevices = [kGADSimulatorID]
                adBanner.load(request)
    }*/
    
    
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
