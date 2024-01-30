//
//  File.swift
//  
//
//  Created by Clissia Bozzer Bovi on 29/01/24.
//

import SpriteKit
import SwiftUI

class LabScene: SKScene, SKPhysicsContactDelegate {

    var sceneCamera: SKCameraNode = SKCameraNode()
    var rightIsPressed = false
    var leftIsPressed = false
    var isWalking = false

    let playerSpeed: CGFloat = 5
    let stoppedPlayer = "PlayerFrente"
    let walkingPlayer = "WalkingPlayer"
    let minDistance: CGFloat = -78
    let maxDistance: CGFloat = 1904

    var player: SKSpriteNode!

    override func didMove(to view: SKView) {
        self.camera = sceneCamera
        self.addChild(sceneCamera)
        self.setupPlayer()
        self.setupArrows()
        self.setupExperiments()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        let touchLocation = touch?.location(in: self)
        let targetNode = atPoint(touchLocation!) as! SKSpriteNode

        if targetNode.name == "left" {
            leftIsPressed = true
        } else if targetNode.name == "right" {
            rightIsPressed = true
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        rightIsPressed = false
        leftIsPressed = false
    }

    override func update(_ currentTime: TimeInterval) {
        updatePlayerPosition()
        updateCameraPosition()
    }

    private func setupPlayer() {
        self.player = childNode(withName: "player") as? SKSpriteNode
        let texture = SKTexture(imageNamed: stoppedPlayer)
        self.player.physicsBody = SKPhysicsBody(texture: texture, size: player.size)
        self.player.physicsBody?.allowsRotation = false
        self.player.physicsBody?.categoryBitMask = 1
    }

    private func setupArrows() {
        guard let rightArrow = childNode(withName: "right") as? SKSpriteNode,
              let leftArrow = childNode(withName: "left") as? SKSpriteNode else { return }

        rightArrow.removeFromParent()
        leftArrow.removeFromParent()

        camera?.addChild(rightArrow)
        camera?.addChild(leftArrow)
    }

    private func setupExperiments() {
        guard let exp1 = childNode(withName: "exp1") as? SKSpriteNode,
              let exp2 = childNode(withName: "exp2") as? SKSpriteNode,
              let exp3 = childNode(withName: "exp3") as? SKSpriteNode
        else { return }

        setMask(sprite: exp1, categoryMask: 2)
        setMask(sprite: exp2, categoryMask: 3)
        setMask(sprite: exp3, categoryMask: 4)
    }

    private func setMask(sprite: SKSpriteNode, categoryMask: Int) {
        sprite.physicsBody?.categoryBitMask = UInt32(categoryMask)
        sprite.physicsBody?.contactTestBitMask = 1
        sprite.physicsBody?.collisionBitMask = 1
    }

    private func updatePlayerPosition() {
        if rightIsPressed {
            player.position.x += playerSpeed
            walk()
        } else if leftIsPressed {
            player.position.x -= playerSpeed
            walk()
        } else {
            isWalking = false
            stop()
        }
        print(player.position.x)
    }

    private func walk() {
        guard !isWalking else { return }
        self.isWalking = true
        let textures = Textures.getTextures(atlas: "WalkingPlayer")
        let action = SKAction.animate(with: textures,
                                      timePerFrame: 1/TimeInterval(textures.count),
                                      resize: true,
                                      restore: true)
        player.xScale = leftIsPressed ? abs(player.xScale) : -abs(player.xScale)
        player.removeAllActions()
        player.run(SKAction.repeatForever(action))
    }

    func stop() {
        let textures = [SKTexture(imageNamed: stoppedPlayer)]
        let action = SKAction.animate(with: textures,
                                      timePerFrame: 0.001,
                                      resize: true,
                                      restore: true)
        player.removeAllActions()
        player.run(SKAction.repeatForever(action))
    }

    private func updateCameraPosition() {
        let playerPosition = player.position.x
        if(playerPosition > minDistance && playerPosition < maxDistance) {
            camera?.position.x = playerPosition
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.categoryBitMask
        let bodyB = contact.bodyB.categoryBitMask
    }
}
