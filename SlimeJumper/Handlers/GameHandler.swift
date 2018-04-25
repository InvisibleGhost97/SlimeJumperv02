//
//  GameHandler.swift
//  SlimeJumper
//
//  Created by scott on 2018-04-24.
//  Copyright © 2018 Kramarczyk Jessica N. All rights reserved.
//

import Foundation

class GameHandler{
    var score:Int
    var highscore:Int
    var slime:Int
    
    var levelData:NSDictionary!
    
    //only want to create one instance of the game handler class
    //creating a class variable of the type GameHandler
    class var sharedInstance:GameHandler{
        struct Singleton {
            //static constant instance which is the game handler instance
            static let instance = GameHandler()
            
        }
        return Singleton.instance
    }
    
    init(){
        //assigning values
        score = 0
        highscore = 0
        slime = 0
        
        //restoring and saving the highscore
        let userDefaults = UserDefaults.standard    //user defaults works like a user dictionary where small        amount of data is saved (ex. scores)
        
        //accessing an integer for a key assuming there is such a key
        highscore = userDefaults.integer(forKey: "highscore")
        slime = userDefaults.integer(forKey: "slime")
        
        //loading level data if the file exists
        
        if let path = Bundle.main.path(forResource: "Level01", ofType: "plist"){
            //checking if there is level data
            if let level = NSDictionary(contentsOfFile: path){  //using an NSDictionary b/c we are able to load all of the info stored in the level01.plist
                levelData = level   //using the level path dictionary and assigning it to level
            }
        }
    }
    
    //saving the data
    func saveGameStats(){
        highscore = max (score, highscore)  //checking if the highscore is the current score or the highscore to determine the highscore
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(highscore, forKey: "highscore")
        userDefaults.set(slime, forKey: "slime")
        userDefaults.synchronize()  //saved the game data
    }
    
}
