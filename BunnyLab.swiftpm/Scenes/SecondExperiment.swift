//
//  SecondExperiment.swift
//  
//
//  Created by Clissia Bozzer Bovi on 31/01/24.
//

import UIKit
import SpriteKit

class SecondExperiment: SKScene {
    // MARK: Variables
    var bunny: SKSpriteNode!

    var leftAllele: Alleles = .S
    var rightAllele: Alleles = .S
    var rightAlleles: [SKSpriteNode] = []
    var leftAlleles: [SKSpriteNode] = []
    var assets: Assets = Assets()

    // MARK: Inherited Methods
    override func didMove(to view: SKView) {
        self.setupBunny()
        self.setupButtons()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        let touchLocation = touch?.location(in: self)
        let targetNode = atPoint(touchLocation!) as! SKSpriteNode
        let name = targetNode.name ?? ""

        if leftAlleles.contains(targetNode) {
            self.leftButtonClicked(name)
        } else if rightAlleles.contains(targetNode) {
            self.rightButtonClicked(name)
        } else if(name == assets.merge) {
            self.mergeAction()
        } else if(name == assets.replay) {
            self.replayAction()
        }
    }

    // MARK: Private Methods
    private func setupBunny() {
        self.bunny = childNode(withName: "bunny") as? SKSpriteNode
    }

    private func setupButtons() {
        self.setupLeftButtons()
        self.setupRightButtons()
    }

    private func setupLeftButtons() {
        guard let sButton = childNode(withName: assets.sButtonLeft) as? SKSpriteNode,
              let cButton = childNode(withName: assets.cButtonLeft) as? SKSpriteNode,
              let hButton =  childNode(withName: assets.hButtonLeft) as? SKSpriteNode,
              let aButton =  childNode(withName: assets.aButtonLeft) as? SKSpriteNode else { return }

        leftAlleles = [sButton, cButton, hButton, aButton]
        leftAlleles[0].texture = SKTexture(imageNamed: assets.sButtonClicked)
    }

    private func setupRightButtons() {
        guard let sButton = childNode(withName: assets.sButtonRight) as? SKSpriteNode,
              let cButton = childNode(withName: assets.cButtonRight) as? SKSpriteNode,
              let hButton =  childNode(withName: assets.hButtonRight) as? SKSpriteNode,
              let aButton =  childNode(withName: assets.aButtonRight) as? SKSpriteNode else { return }
    
        rightAlleles = [sButton, cButton, hButton, aButton]
        rightAlleles[0].texture = SKTexture(imageNamed: assets.sButtonClicked)
    }

    private func rightButtonClicked(_ targetNode: String) {
        let buttonFirstLetter = targetNode.first?.description ?? ""
        rightAllele = Alleles(rawValue: buttonFirstLetter) ?? .S

        changeUnselectedRightButton()
        changeSelectedRightButton()
    }

    private func changeSelectedRightButton() {
        if(rightAllele.rawValue == rightAlleles[0].name?.first?.description) {
            rightAlleles[0].texture = SKTexture(imageNamed: assets.sButtonClicked)
        } else if(rightAllele.rawValue == rightAlleles[1].name?.first?.description) {
            rightAlleles[1].texture = SKTexture(imageNamed: assets.cButtonClicked)
        } else if(rightAllele.rawValue == rightAlleles[2].name?.first?.description) {
            rightAlleles[2].texture = SKTexture(imageNamed: assets.hButtonClicked)
        } else {
            rightAlleles[3].texture = SKTexture(imageNamed: assets.aButtonClicked)
        }
    }

    private func changeUnselectedRightButton() {
        rightAlleles[0].texture = SKTexture(imageNamed: assets.sButton)
        rightAlleles[1].texture = SKTexture(imageNamed: assets.cButton)
        rightAlleles[2].texture = SKTexture(imageNamed: assets.hButton)
        rightAlleles[3].texture = SKTexture(imageNamed: assets.aButton)
    }

    private func leftButtonClicked(_ targetNode: String) {
        let buttonFirstLetter = targetNode.first?.description ?? ""
        leftAllele = Alleles(rawValue: buttonFirstLetter) ?? .S

        changeUnselectedLeftButton()
        changeSelectedLeftButton()
    }

    private func changeSelectedLeftButton() {
        if(leftAllele.rawValue == leftAlleles[0].name?.first?.description) {
            leftAlleles[0].texture = SKTexture(imageNamed: assets.sButtonClicked)
        } else if(leftAllele.rawValue == leftAlleles[1].name?.first?.description) {
            leftAlleles[1].texture = SKTexture(imageNamed: assets.cButtonClicked)
        } else if(leftAllele.rawValue == leftAlleles[2].name?.first?.description) {
            leftAlleles[2].texture = SKTexture(imageNamed: assets.hButtonClicked)
        } else {
            leftAlleles[3].texture = SKTexture(imageNamed: assets.aButtonClicked)
        }
    }

    private func changeUnselectedLeftButton() {
        leftAlleles[0].texture = SKTexture(imageNamed: assets.sButton)
        leftAlleles[1].texture = SKTexture(imageNamed: assets.cButton)
        leftAlleles[2].texture = SKTexture(imageNamed: assets.hButton)
        leftAlleles[3].texture = SKTexture(imageNamed: assets.aButton)
    }

    private func replayAction() {
        
    }

    private func mergeAction() {
        
    }
}
