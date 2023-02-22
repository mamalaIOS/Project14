//
//  GameScene.swift
//  Project14
//
//  Created by Amel Sbaihi on 2/15/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameScore : SKLabelNode!
    var score : Int = 0 {
        
        didSet {
            gameScore.text = "score: \(score)"
            
        }
        
    }
    
    var popupTime = 0.85
    
    var slots = [WhackSlot]()
    override func didMove(to view: SKView) {
        
        
        
        
       let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "chalkDuster")
        gameScore.text = "score : 0 "
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        for i in 0 ..< 5 {createSlot(at: CGPoint(x: 100 + (i * 170), y: 410))}
        for i in 0 ..< 4 {createSlot(at: CGPoint(x: 180 + (i * 170), y: 320))}
        for i in 0 ..< 5 {createSlot(at: CGPoint(x: 100 + (i * 170), y: 230))}
        for i in 0 ..< 4 {createSlot(at: CGPoint(x: 180 + (i * 170), y: 140))}
        
        // so every time this create methode is called what happend is that the configure methode (that cretes the holes , crop node (inside they have a charnode penguin ))  is also called
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) { [weak self] in
            self?.createEnemy ()
            
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    
    func createSlot (at position : CGPoint) {
        
        
        let slot = WhackSlot()
       
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
    
    
   
    
    func createEnemy() {
        popupTime *= 0.991
        
        slots.shuffle()
        
        slots[0].show(hideTime: popupTime)
        
        if Int.random(in: 0...12) > 4 {slots[1].show(hideTime: popupTime)}
        if Int.random(in: 0...12) > 8 {slots[2].show(hideTime: popupTime)}
        if Int.random(in: 0...12) > 10 {slots[3].show(hideTime: popupTime)}
        if Int.random(in: 0...12) > 11 {slots[4].show(hideTime: popupTime)}
        
        let minDelay = popupTime / 2
        let maxDelay = popupTime * 2
        
        let delay = Double.random(in: minDelay ... maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
               self?.createEnemy()
           }
        
        }
        
        
    }
    
    
    
    
    
    

