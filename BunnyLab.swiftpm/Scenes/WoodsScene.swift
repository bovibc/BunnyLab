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
    var isFirstPositionUsed = false
    var isSecondPositionUsed = false
    var isThirdPositionUsed = false
    var talkArrowBackIsRemoved = true
    var isTalking = false
    var isHeadRemoved = false
    
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
    var talkHeadBunny: SKSpriteNode!
    var talkLabel: SKLabelNode!
    var talkArrow: SKSpriteNode!
    var talkArrowBack: SKSpriteNode!
    
    // MARK: Inherited Methods
    override func didMove(to view: SKView) {
        self.camera = sceneCamera
        physicsWorld.contactDelegate = self
        self.addChild(sceneCamera)
        
        self.setupPlayer()
        self.setupButtons()
        self.setupTalk()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        let touchLocation = touch?.location(in: self)
        let targetNode = atPoint(touchLocation!) as? SKSpriteNode

        if targetNode?.name == "left" {
            leftIsPressed = true
        } else if targetNode?.name == "right" {
            rightIsPressed = true
        } else if targetNode?.name == Assets.General.talkArrow.rawValue {
            nextTalk()
        } else if targetNode?.name == Assets.General.talkArrowBack.rawValue {
            previousTalk()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        rightIsPressed = false
        leftIsPressed = false
    }

    override func update(_ currentTime: TimeInterval) {
        updatePlayerPosition()
        updateCameraPosition()
        verifyPosition()
    }

    // MARK: Private Methods

    private func setupTalk() {
        self.talkBlur = childNode(withName: Assets.General.talkBlur.rawValue) as? SKSpriteNode
        self.talkBalloon = childNode(withName: Assets.General.talkBalloon.rawValue) as? SKSpriteNode
        self.talkHead = childNode(withName: Assets.General.talkHead.rawValue) as? SKSpriteNode
        self.talkHeadBunny = childNode(withName: Assets.General.talkHeadBunny.rawValue) as? SKSpriteNode
        self.talkLabel = childNode(withName: Assets.General.talkLabel.rawValue) as? SKLabelNode
        self.talkArrow = childNode(withName: Assets.General.talkArrow.rawValue) as? SKSpriteNode
        self.talkArrowBack = childNode(withName: Assets.General.talkArrowBack.rawValue) as? SKSpriteNode
        
        talkBlur.removeFromParent()
        talkBalloon.removeFromParent()
        talkHead.removeFromParent()
        talkHeadBunny.removeFromParent()
        talkLabel.removeFromParent()
        talkArrow.removeFromParent()
        talkArrowBack.removeFromParent()
    }

    private func setupPlayer() {
        self.player = childNode(withName: "player") as? SKSpriteNode
        let texture = SKTexture(imageNamed: stoppedPlayer)
        self.player.physicsBody = SKPhysicsBody(texture: texture, size: player.size)
        self.player.physicsBody?.allowsRotation = false
        self.player.physicsBody?.categoryBitMask = 1
        self.player.physicsBody?.collisionBitMask = 1
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
        if rightIsPressed && !isTalking {
            player.position.x += playerSpeed
            walk()
        } else if leftIsPressed && !isTalking  {
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
        if(playerPosition > minDistance && playerPosition < maxDistance && !isTalking) {
            camera?.position.x = playerPosition
        }
    }

    private func verifyPosition() {
        let position = player.position.x
        let positionRounded = Double(position).round()
        if(positionRounded > -85 && positionRounded < -44){
            if isFirstPositionUsed { return }
            isFirstPositionUsed = true
            isSecondPositionUsed = false
            isThirdPositionUsed = false
            talkInit(flow: .Woods1)
        } else if(positionRounded > 380 && positionRounded < 425) {
            if isSecondPositionUsed { return }
            isSecondPositionUsed = true
            isFirstPositionUsed = false
            isThirdPositionUsed = false
            talkInit(flow: .Woods2)
        } else if(positionRounded > 635 && positionRounded < 680) {
            if isThirdPositionUsed { return }
            isThirdPositionUsed = true
            isFirstPositionUsed = false
            isSecondPositionUsed = false
            turnBunny()
            talkInit(flow: .Woods3)
        }
    }

    private func turnBunny() {
        let whiteBunny = childNode(withName: Assets.Woods.bunny1.rawValue) as? SKSpriteNode
        let wildBunny = childNode(withName: Assets.Woods.bunny2.rawValue) as? SKSpriteNode

        whiteBunny?.texture = SKTexture(imageNamed: Assets.General.bunnyAlbino.rawValue)
        wildBunny?.texture = SKTexture(imageNamed: Assets.General.bunnyWild.rawValue)
    }

    private func nextTalk() {
        guard let text = textFlow.nextText() else {
            finishText()
            return
        }
        if talkArrowBackIsRemoved && textFlow.isFirstIndex() {
            talkArrowBackIsRemoved = false
            camera?.addChild(talkArrowBack)
        }
        
        talkLabel.text = text
        setImage()
    }

    private func previousTalk() {
        guard let text = textFlow.previousText() else {
            removeTalk()
            return
        }

        if textFlow.isZeroIndex() {
            talkArrowBackIsRemoved = true
            talkArrowBack.removeFromParent()
        }

        talkLabel.text = text
        setImage()
    }

    
    private func talkInit(flow: StoryFlow) {
        isTalking = true
        talkLabel.text = textFlow.startText(flow: flow)
        isHeadRemoved = true
        camera?.addChild(talkBlur)
        camera?.addChild(talkBalloon)
        camera?.addChild(talkLabel)
        camera?.addChild(talkArrow)
        setImage()
    }

    private func setImage() {
        if isHeadRemoved {
            camera?.addChild(talkHead)
            camera?.addChild(talkHeadBunny)
            if camera?.contains(talkArrowBack) ?? false {
                talkArrowBack.removeFromParent()
                camera?.addChild(talkArrowBack)
            }
            isHeadRemoved = false
        }

        if let image = textFlow.getHeadImageName() {
            validateImage(image)
        } else {
            isHeadRemoved = true
            talkHead.removeFromParent()
            talkHeadBunny.removeFromParent()
        }
    }

    private func validateImage(_ image: String) {
        if image != Assets.TalkingHeadImages.mainHead.rawValue {
            talkHeadBunny.texture = SKTexture(imageNamed: image)
            talkHeadBunny.isHidden = false
            talkHead.isHidden = true
        } else {
            talkHead.texture = SKTexture(imageNamed: image)
            talkHeadBunny.isHidden = true
            talkHead.isHidden = false
        }
    }

    private func finishText() {
        isTalking = false
        removeTalk()
        if textFlow.flow == .Woods3 { goesToLab() }
    }
    
    private func removeTalk() {
        talkBlur.removeFromParent()
        talkBalloon.removeFromParent()
        talkHead.removeFromParent()
        talkHeadBunny.removeFromParent()
        talkLabel.removeFromParent()
        talkArrow.removeFromParent()
        talkArrowBack.removeFromParent()
        talkArrowBackIsRemoved = true
        isHeadRemoved = true
    }

    private func goesToLab() {
        TransactionsScene.goToLab(view: self.view)
    }
}

extension Double {
    func round() -> Double {
        let divisor = pow(10.0, Double(2))
        return (self * divisor).rounded() / divisor
    }
}
