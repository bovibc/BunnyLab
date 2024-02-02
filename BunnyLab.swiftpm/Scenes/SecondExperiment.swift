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
    var bunnyName: SKLabelNode!

    var leftAllele: Alleles = .S
    var rightAllele: Alleles = .S
    var rightAlleles: [SKSpriteNode] = []
    var leftAlleles: [SKSpriteNode] = []
    
    var parentScene: SKScene?

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
        } else if(name == Assets.Images.merge.rawValue) {
            self.mergeAction()
        } else if(name == Assets.Images.replay.rawValue) {
            self.replayAction()
        } else if(name == Assets.Images.back.rawValue) {
            self.backAction()
        }
    }

    // MARK: Private Methods
    private func setupBunny() {
        self.bunny = childNode(withName: Assets.Exp1.bunny.rawValue) as? SKSpriteNode
        self.bunnyName = childNode(withName: Assets.Exp1.bunnyName.rawValue) as? SKLabelNode
    }

    private func setupButtons() {
        self.setupLeftButtons()
        self.setupRightButtons()
        self.replayAction()
    }

    private func setupLeftButtons() {
        guard let sButton = childNode(withName: Assets.Exp1.sButtonLeft.rawValue) as? SKSpriteNode,
              let cButton = childNode(withName: Assets.Exp1.cButtonLeft.rawValue) as? SKSpriteNode,
              let hButton =  childNode(withName: Assets.Exp1.hButtonLeft.rawValue) as? SKSpriteNode,
              let aButton =  childNode(withName: Assets.Exp1.aButtonLeft.rawValue) as? SKSpriteNode else { return }

        leftAlleles = [sButton, cButton, hButton, aButton]
    }

    private func setupRightButtons() {
        guard let sButton = childNode(withName: Assets.Exp1.sButtonRight.rawValue) as? SKSpriteNode,
              let cButton = childNode(withName: Assets.Exp1.cButtonRight.rawValue) as? SKSpriteNode,
              let hButton =  childNode(withName: Assets.Exp1.hButtonRight.rawValue) as? SKSpriteNode,
              let aButton =  childNode(withName: Assets.Exp1.aButtonRight.rawValue) as? SKSpriteNode else { return }
    
        rightAlleles = [sButton, cButton, hButton, aButton]
    }

    private func rightButtonClicked(_ targetNode: String) {
        let buttonFirstLetter = targetNode.first?.description ?? ""
        rightAllele = Alleles(rawValue: buttonFirstLetter) ?? .S

        changeUnselectedRightButton()
        changeSelectedRightButton()
    }

    private func changeSelectedRightButton() {
        if(rightAllele.rawValue == rightAlleles[0].name?.first?.description) {
            rightAlleles[0].texture = SKTexture(imageNamed: Assets.Images.sButtonClicked.rawValue)
        } else if(rightAllele.rawValue == rightAlleles[1].name?.first?.description) {
            rightAlleles[1].texture = SKTexture(imageNamed: Assets.Images.cButtonClicked.rawValue)
        } else if(rightAllele.rawValue == rightAlleles[2].name?.first?.description) {
            rightAlleles[2].texture = SKTexture(imageNamed: Assets.Images.hButtonClicked.rawValue)
        } else {
            rightAlleles[3].texture = SKTexture(imageNamed: Assets.Images.aButtonClicked.rawValue)
        }
    }

    private func changeUnselectedRightButton() {
        rightAlleles[0].texture = SKTexture(imageNamed: Assets.Images.sButton.rawValue)
        rightAlleles[1].texture = SKTexture(imageNamed: Assets.Images.cButton.rawValue)
        rightAlleles[2].texture = SKTexture(imageNamed: Assets.Images.hButton.rawValue)
        rightAlleles[3].texture = SKTexture(imageNamed: Assets.Images.aButton.rawValue)
    }

    private func leftButtonClicked(_ targetNode: String) {
        let buttonFirstLetter = targetNode.first?.description ?? ""
        leftAllele = Alleles(rawValue: buttonFirstLetter) ?? .S

        changeUnselectedLeftButton()
        changeSelectedLeftButton()
    }

    private func changeSelectedLeftButton() {
        if(leftAllele.rawValue == leftAlleles[0].name?.first?.description) {
            leftAlleles[0].texture = SKTexture(imageNamed: Assets.Images.sButtonClicked.rawValue)
        } else if(leftAllele.rawValue == leftAlleles[1].name?.first?.description) {
            leftAlleles[1].texture = SKTexture(imageNamed: Assets.Images.cButtonClicked.rawValue)
        } else if(leftAllele.rawValue == leftAlleles[2].name?.first?.description) {
            leftAlleles[2].texture = SKTexture(imageNamed: Assets.Images.hButtonClicked.rawValue)
        } else {
            leftAlleles[3].texture = SKTexture(imageNamed: Assets.Images.aButtonClicked.rawValue)
        }
    }

    private func changeUnselectedLeftButton() {
        leftAlleles[0].texture = SKTexture(imageNamed: Assets.Images.sButton.rawValue)
        leftAlleles[1].texture = SKTexture(imageNamed: Assets.Images.cButton.rawValue)
        leftAlleles[2].texture = SKTexture(imageNamed: Assets.Images.hButton.rawValue)
        leftAlleles[3].texture = SKTexture(imageNamed: Assets.Images.aButton.rawValue)
    }

    private func replayAction() {
        leftAlleles[0].texture = SKTexture(imageNamed: Assets.Images.sButtonClicked.rawValue)
        leftAlleles[1].texture = SKTexture(imageNamed: Assets.Images.cButton.rawValue)
        leftAlleles[2].texture = SKTexture(imageNamed: Assets.Images.hButton.rawValue)
        leftAlleles[3].texture = SKTexture(imageNamed: Assets.Images.aButton.rawValue)
        rightAlleles[0].texture = SKTexture(imageNamed: Assets.Images.sButtonClicked.rawValue)
        rightAlleles[1].texture = SKTexture(imageNamed: Assets.Images.cButton.rawValue)
        rightAlleles[2].texture = SKTexture(imageNamed: Assets.Images.hButton.rawValue)
        rightAlleles[3].texture = SKTexture(imageNamed: Assets.Images.aButton.rawValue)
        bunny.texture = SKTexture(imageNamed: Assets.Images.bunnyDoubt.rawValue)
        bunnyName.isHidden = true
        leftAllele = .S
        rightAllele = .S
    }

    private func mergeAction() {
        let result = Combinations.getCombinationResult(rightAllele, leftAllele)
        let name = Combinations.getCombinationResultName(rightAllele, leftAllele )
        bunny.texture = SKTexture(imageNamed: result)
        bunnyName.isHidden = false
        bunnyName.text = name
    }

    private func backAction() {
        if let previousScene = self.parentScene {
            self.view?.presentScene(previousScene)
        }
    }
}
