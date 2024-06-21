//
//  Gendut.swift
//  LevelOneMini2
//
//  Created by tandyys on 18/06/24.
//

import Foundation
import SpriteKit

class Gendut: SKSpriteNode {
    enum PlayerAnimationType:String {
        case walk
    }
    
    private var gendutWalkTexture: [SKTexture]?
    
    init() {
        let texture = SKTexture(imageNamed: "GendutWalk_0")
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.gendutWalkTexture = self.loadAnimation(atlas: "Gendut", prefix: "GendutWalk_", startAt: 0, stopAt: 5)
        
        self.name = "gendut"
        self.setScale(1.0)
//        self.size = CGSize(width: 320, height: 360)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = SKSpriteNode.Layer.character.rawValue
        
        //physics
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height/3), center: CGPoint(x: 0, y: self.size.height/3))
        self.physicsBody?.categoryBitMask = SKSpriteNode.PhysicsCategory.gendut
        self.physicsBody?.contactTestBitMask = SKSpriteNode.PhysicsCategory.kecil | SKSpriteNode.PhysicsCategory.monster | SKSpriteNode.PhysicsCategory.tower
        self.physicsBody?.collisionBitMask = SKSpriteNode.PhysicsCategory.kecil | SKSpriteNode.PhysicsCategory.monster | SKSpriteNode.PhysicsCategory.tower
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func walk() {
        //Check the texture
        guard let walkTexture = gendutWalkTexture else {
            preconditionFailure("Cant find gendut texture")
        }
        
        //Run animation
        startAnimation(textures: walkTexture, speed: 0.135, name: PlayerAnimationType.walk.rawValue, count: 0, resize: true, restore: true)
    }
    
    func stop() {
        removeAction(forKey: PlayerAnimationType.walk.rawValue)
//        removeAllActions()
    }
}
