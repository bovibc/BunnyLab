//
//  WoodsScene.swift
//  
//
//  Created by Clissia Bozzer Bovi on 05/02/24.
//

import UIKit
import SpriteKit

class WoodsScene: SKScene, SKPhysicsContactDelegate {
    // MARK: Variables
    var sceneCamera: SKCameraNode = SKCameraNode()
    var rightIsPressed = false
    var leftIsPressed = false
    var isWalking = false
    
    var contact: SKPhysicsContact?

    let playerSpeed: CGFloat = 5
    let stoppedPlayer = "PlayerFrente"
    let walkingPlayer = "WalkingPlayer"
    let minDistance: CGFloat = -14.99
    let maxDistance: CGFloat = 600
    let textFlow: TextFlow  = TextFlow()

    var player: SKSpriteNode!
    var talkBlur: SKSpriteNode!
    var talkBalloon: SKSpriteNode!
    var talkHead: SKSpriteNode!
    var talkLabel: SKLabelNode!
    var talkArrow: SKSpriteNode!
    
    // MARK: Inherited Methods
    override func didMove(to view: SKView) {
        self.camera = sceneCamera
        physicsWorld.contactDelegate = self
        view.showsPhysics = true
        self.addChild(sceneCamera)

        self.setupPlayer()
        self.setupButtons()
        self.setupTalk()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        let touchLocation = touch?.location(in: self)
        let targetNode = atPoint(touchLocation!) as! SKSpriteNode

        if targetNode.name == "left" {
            leftIsPressed = true
        } else if targetNode.name == "right" {
            rightIsPressed = true
        } else if targetNode.name == Assets.General.talkArrow.rawValue {
            nextTalk()
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

    // MARK: Private Methods

    private func setupTalk() {
        self.talkBlur = childNode(withName: Assets.General.talkBlur.rawValue) as? SKSpriteNode
        self.talkBalloon = childNode(withName: Assets.General.talkBalloon.rawValue) as? SKSpriteNode
        self.talkHead = childNode(withName: Assets.General.talkHead.rawValue) as? SKSpriteNode
        self.talkLabel = childNode(withName: Assets.General.talkLabel.rawValue) as? SKLabelNode
        self.talkArrow = childNode(withName: Assets.General.talkArrow.rawValue) as? SKSpriteNode
        
        talkBlur.removeFromParent()
        talkBalloon.removeFromParent()
        talkHead.removeFromParent()
        talkLabel.removeFromParent()
        talkArrow.removeFromParent()
    }

    private func setupPlayer() {
        self.player = childNode(withName: "player") as? SKSpriteNode
        let texture = SKTexture(imageNamed: stoppedPlayer)
        self.player.physicsBody = SKPhysicsBody(texture: texture, size: player.size)
        self.player.physicsBody?.allowsRotation = false
        self.player.physicsBody?.categoryBitMask = 1
        self.player.physicsBody?.collisionBitMask = 0
        self.player.physicsBody?.affectedByGravity = false
    }

    private func setupButtons() {
        guard let rightArrow = childNode(withName: "right") as? SKSpriteNode,
              let leftArrow = childNode(withName: "left") as? SKSpriteNode else { return }
        
        rightArrow.removeFromParent()
        leftArrow.removeFromParent()

        camera?.addChild(rightArrow)
        camera?.addChild(leftArrow)
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

    private func talkInit() {
        talkLabel.text = textFlow.startText(flow: .Woods)
        camera?.addChild(talkBlur)
        camera?.addChild(talkBalloon)
        camera?.addChild(talkHead)
        camera?.addChild(talkLabel)
        camera?.addChild(talkArrow)
    }

    private func nextTalk() {
        guard let text = textFlow.nextText() else {
            finishText()
            return
        }
        talkLabel.text = text
    }

    private func finishText() {
        removeTalk()
        goesToLab()
    }
    
    private func removeTalk() {
        talkBlur.removeFromParent()
        talkBalloon.removeFromParent()
        talkHead.removeFromParent()
        talkLabel.removeFromParent()
        talkArrow.removeFromParent()
    }

    private func goesToLab() {
        
    }
}
