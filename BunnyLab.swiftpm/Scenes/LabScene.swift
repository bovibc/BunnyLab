//
//  File.swift
//  
//
//  Created by Clissia Bozzer Bovi on 29/01/24.
//

import SpriteKit
import SwiftUI

class LabScene: SKScene, SKPhysicsContactDelegate {
    // MARK: Variables
    var sceneCamera: SKCameraNode = SKCameraNode()
    var rightIsPressed = false
    var leftIsPressed = false
    var isWalking = false
    var sceneStarted = false
    
    var contact: SKPhysicsContact?

    let playerSpeed: CGFloat = 5
    let stoppedPlayer = "PlayerFrente"
    let walkingPlayer = "WalkingPlayer"
    let minDistance: CGFloat = -78
    let maxDistance: CGFloat = 1904
    let textFlow: TextFlow  = TextFlow()

    var player: SKSpriteNode!
    var playButton: SKSpriteNode!
    var talkBlur: SKSpriteNode!
    var talkBalloon: SKSpriteNode!
    var talkHead: SKSpriteNode!
    var talkLabel: SKLabelNode!
    var talkArrow: SKSpriteNode!
    var talkArrowBack: SKSpriteNode!
    
    // MARK: Inherited Methods
    override func didMove(to view: SKView) {
        guard !sceneStarted else { return }
        sceneStarted = true
        self.camera = sceneCamera
        physicsWorld.contactDelegate = self
        view.showsPhysics = true
        self.addChild(sceneCamera)

        self.setupPlayer()
        self.setupButtons()
        self.setupExperiments()
        self.setupLabels(isHidden: true)
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
        } else if targetNode.name == "play" {
            playButtonAction()
        } else if targetNode.name == Assets.General.talkArrow.rawValue {
            nextTalk()
        } else if targetNode.name == Assets.General.talkArrowBack.rawValue {
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
    }

    func didBegin(_ contact: SKPhysicsContact) {
        self.setupLabels(isHidden: false)
        playButton.isHidden = false
        self.contact = contact
    }

    func didEnd(_ contact: SKPhysicsContact) {
        setupLabels(isHidden: true)
        playButton.isHidden = true
    }

    // MARK: Private Methods
    private func setupLabels(isHidden: Bool) {
        if let labelExp1 = childNode(withName: "labelExp1") as? SKLabelNode {
            labelExp1.isHidden = isHidden
        }

        if let labelExp2 = childNode(withName: "labelExp2") as? SKLabelNode {
            labelExp2.isHidden = isHidden
        }

        if let labelExp3 = childNode(withName: "labelExp3") as? SKLabelNode {
            labelExp3.isHidden = isHidden
        }
    }

    private func setupTalk() {
        self.talkBlur = childNode(withName: Assets.General.talkBlur.rawValue) as? SKSpriteNode
        self.talkBalloon = childNode(withName: Assets.General.talkBalloon.rawValue) as? SKSpriteNode
        self.talkHead = childNode(withName: Assets.General.talkHead.rawValue) as? SKSpriteNode
        self.talkLabel = childNode(withName: Assets.General.talkLabel.rawValue) as? SKLabelNode
        self.talkArrow = childNode(withName: Assets.General.talkArrow.rawValue) as? SKSpriteNode
        self.talkArrowBack = childNode(withName: Assets.General.talkArrowBack.rawValue) as? SKSpriteNode
        
        talkBlur.removeFromParent()
        talkBalloon.removeFromParent()
        talkHead.removeFromParent()
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
        self.player.physicsBody?.collisionBitMask = 0
        self.player.physicsBody?.affectedByGravity = false
    }

    private func setupButtons() {
        guard let rightArrow = childNode(withName: "right") as? SKSpriteNode,
              let leftArrow = childNode(withName: "left") as? SKSpriteNode,
              let playButton =  childNode(withName: "play") as? SKSpriteNode else { return }

        self.playButton = playButton
        self.playButton.isHidden = true
        
        rightArrow.removeFromParent()
        leftArrow.removeFromParent()
        playButton.removeFromParent()

        camera?.addChild(rightArrow)
        camera?.addChild(leftArrow)
        camera?.addChild(self.playButton)
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
        sprite.physicsBody?.collisionBitMask = 0
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

    private func playButtonAction() {
        if(isContactWithPlayer(contact, experimentMask: 2)) {
            self.talkInit(flow: .FirstExperiment)
        } else if(isContactWithPlayer(contact, experimentMask: 3)) {
            self.talkInit(flow: .SecondExperiment)
        } else if(isContactWithPlayer(contact, experimentMask: 4)) {
            self.talkInit(flow: .ThirdExperiment)
        }
    }

    private func isContactWithPlayer(_ contact : SKPhysicsContact?, experimentMask: UInt32) -> Bool {
        let bodyA = contact?.bodyA.categoryBitMask
        let bodyB = contact?.bodyB.categoryBitMask

        if(bodyA == 1 && bodyB == experimentMask) {
            return true
        } else if(bodyA == experimentMask && bodyB == 1) {
            return true
        } else {
            return false
        }
    }

    private func talkInit(flow: StoryFlow) {
        talkLabel.text = textFlow.startText(flow: flow)
        camera?.addChild(talkBlur)
        camera?.addChild(talkBalloon)
        camera?.addChild(talkHead)
        camera?.addChild(talkLabel)
        camera?.addChild(talkArrow)
        camera?.addChild(talkArrowBack)
    }

    private func nextTalk() {
        guard let text = textFlow.nextText() else {
            finishText()
            return
        }
        talkLabel.text = text
    }

    private func previousTalk() {
        guard let text = textFlow.previousText() else {
            removeTalk()
            return
        }
        talkLabel.text = text
    }

    private func finishText() {
        removeTalk()
        switch textFlow.flow {
        case .FirstExperiment:
            goesToFirstExperiment()
        case .SecondExperiment:
            goesToSecondExperiment()
        case .ThirdExperiment:
            goesToThirdExperiment()
        case .End:
            goesToEnd()
        default:
            goesToFirstExperiment()
        }
    }
    
    private func removeTalk() {
        talkBlur.removeFromParent()
        talkBalloon.removeFromParent()
        talkHead.removeFromParent()
        talkLabel.removeFromParent()
        talkArrow.removeFromParent()
        talkArrowBack.removeFromParent()
    }

    private func goesToFirstExperiment() {
        TrasactionsScenes.goToThirdExperiment(view: self.view, self)
    }

    private func goesToSecondExperiment() {
        TrasactionsScenes.goToSecondExperiment(view: self.view, self)
    }

    private func goesToThirdExperiment() {
        TrasactionsScenes.goToThirdExperiment(view: self.view, self)
    }

    private func goesToEnd() {
        
    }
}
