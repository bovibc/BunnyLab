//
//  ThirdExperiment.swift
//  
//
//  Created by Clissia Bozzer Bovi on 01/02/24.
//

import UIKit
import SpriteKit

class ThirdExperiment: SKScene {
    // MARK: Variables
    var bunnyRight: SKSpriteNode!
    var bunnyLeft: SKSpriteNode!
    var resultBunnies: [SKSpriteNode]!
    var info: SKSpriteNode!
    var infoLabel: SKLabelNode!
    var infoBlur: SKSpriteNode!
    var infoClose: SKSpriteNode!

    var leftAlleles: [Alleles] = [.S, .S]
    var rightAlleles: [Alleles] = [.S, .S]
    var rightAlleles1: [SKSpriteNode] = []
    var rightAlleles2: [SKSpriteNode] = []
    var leftAlleles1: [SKSpriteNode] = []
    var leftAlleles2: [SKSpriteNode] = []
    var labels: [SKLabelNode] = []

    var parentScene: SKScene?

    // MARK: Inherited Methods
    override func didMove(to view: SKView) {
        self.setupBunnies()
        self.setupLabels()
        self.setupButtons()
        self.setupInfo()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        let touchLocation = touch?.location(in: self)
        guard let targetNode = atPoint(touchLocation!) as? SKSpriteNode else { return }
        let name = targetNode.name ?? ""

        if leftAlleles1.contains(targetNode) {
            self.left1ButtonClicked(name)
        } else if rightAlleles1.contains(targetNode) {
            self.right1ButtonClicked(name)
        } else if leftAlleles2.contains(targetNode) {
            self.left2ButtonClicked(name)
        } else if rightAlleles2.contains(targetNode) {
            self.right2ButtonClicked(name)
        } else if(name == Assets.General.merge.rawValue) {
            self.mergeAction()
        } else if(name == Assets.General.replay.rawValue) {
            self.replayAction()
        } else if(name == Assets.General.back.rawValue) {
            self.backAction()
        } else if(name == Assets.General.info.rawValue) {
            self.infoAction()
        } else if(name == Assets.General.infoClose.rawValue) {
            self.infoCloseAction()
        }

        self.updateBunnies()
    }

    // MARK: Private Methods
    private func setupBunnies() {
        guard let bunnyRight = childNode(withName: Assets.Exp3.bunnyRight.rawValue) as? SKSpriteNode,
              let bunnyLeft = childNode(withName: Assets.Exp3.bunnyLeft.rawValue) as? SKSpriteNode,
              let doubtBunny1 = childNode(withName: Assets.Exp3.bunnyDoubt1.rawValue) as? SKSpriteNode,
              let doubtBunny2 = childNode(withName: Assets.Exp3.bunnyDoubt2.rawValue) as? SKSpriteNode,
              let doubtBunny3 = childNode(withName: Assets.Exp3.bunnyDoubt3.rawValue) as? SKSpriteNode,
              let doubtBunny4 = childNode(withName: Assets.Exp3.bunnyDoubt4.rawValue) as? SKSpriteNode else { return }
        self.bunnyRight = bunnyRight
        self.bunnyLeft = bunnyLeft
        self.resultBunnies = [doubtBunny1, doubtBunny2, doubtBunny3, doubtBunny4]
    }

    private func setupButtons() {
        self.setupRightButtons1()
        self.setupRightButtons2()
        self.setupLeftButtons1()
        self.setupLeftButtons2()
        self.replayAction()
    }

    private func setupLabels() {
        guard let label1 = childNode(withName: Assets.Exp3.label1.rawValue) as? SKLabelNode,
              let label2 = childNode(withName: Assets.Exp3.label2.rawValue) as? SKLabelNode,
              let label3 = childNode(withName: Assets.Exp3.label3.rawValue) as? SKLabelNode,
              let label4 = childNode(withName: Assets.Exp3.label4.rawValue) as? SKLabelNode else { return }

        labels = [label1, label2, label3, label4]
    }

    private func setupInfo() {
        info = childNode(withName: Assets.General.infoBoard.rawValue) as? SKSpriteNode
        infoLabel = childNode(withName: Assets.General.infoLabel.rawValue) as? SKLabelNode
        infoBlur = childNode(withName: Assets.General.infoBlur.rawValue) as? SKSpriteNode
        infoClose = childNode(withName: Assets.General.infoClose.rawValue) as? SKSpriteNode
    }
    
    private func updateBunnies() {
        let resultRight = Combinations.getCombinationResult(rightAlleles[0], rightAlleles[1])
        let resultLeft = Combinations.getCombinationResult(leftAlleles[0], leftAlleles[1])
        bunnyRight.texture = SKTexture(imageNamed: resultRight)
        bunnyLeft.texture = SKTexture(imageNamed: resultLeft)
    }

    private func mergeAction() {
        let result = Combinations.getCrossesResult(leftAlleles, rightAlleles)
        self.mergeLabelResult()
        resultBunnies[0].texture = SKTexture(imageNamed: result[0])
        resultBunnies[1].texture = SKTexture(imageNamed: result[1])
        resultBunnies[2].texture = SKTexture(imageNamed: result[2])
        resultBunnies[3].texture = SKTexture(imageNamed: result[3])
    }

    private func mergeLabelResult() {
        let label = Combinations.getCrossesResultString(leftAlleles, rightAlleles)
        labels[0].text = label[0]
        labels[1].text = label[1]
        labels[2].text = label[2]
        labels[3].text = label[3]
    }

    // MARK: Private Methods (need refactor)
    private func setupRightButtons1() {
        guard let sButton = childNode(withName: Assets.Exp3.sButtonRight1.rawValue) as? SKSpriteNode,
              let cButton = childNode(withName: Assets.Exp3.cButtonRight1.rawValue) as? SKSpriteNode,
              let hButton =  childNode(withName: Assets.Exp3.hButtonRight1.rawValue) as? SKSpriteNode,
              let aButton =  childNode(withName: Assets.Exp3.aButtonRight1.rawValue) as? SKSpriteNode else { return }

        rightAlleles1 = [sButton, cButton, hButton, aButton]
    }

    private func setupRightButtons2() {
        guard let sButton = childNode(withName: Assets.Exp3.sButtonRight2.rawValue) as? SKSpriteNode,
              let cButton = childNode(withName: Assets.Exp3.cButtonRight2.rawValue) as? SKSpriteNode,
              let hButton =  childNode(withName: Assets.Exp3.hButtonRight2.rawValue) as? SKSpriteNode,
              let aButton =  childNode(withName: Assets.Exp3.aButtonRight2.rawValue) as? SKSpriteNode else { return }

        rightAlleles2 = [sButton, cButton, hButton, aButton]
    }

    private func setupLeftButtons1() {
        guard let sButton = childNode(withName: Assets.Exp3.sButtonLeft1.rawValue) as? SKSpriteNode,
              let cButton = childNode(withName: Assets.Exp3.cButtonLeft1.rawValue) as? SKSpriteNode,
              let hButton =  childNode(withName: Assets.Exp3.hButtonLeft1.rawValue) as? SKSpriteNode,
              let aButton =  childNode(withName: Assets.Exp3.aButtonLeft1.rawValue) as? SKSpriteNode else { return }

        leftAlleles1 = [sButton, cButton, hButton, aButton]
    }

    private func setupLeftButtons2() {
        guard let sButton = childNode(withName: Assets.Exp3.sButtonLeft2.rawValue) as? SKSpriteNode,
              let cButton = childNode(withName: Assets.Exp3.cButtonLeft2.rawValue) as? SKSpriteNode,
              let hButton =  childNode(withName: Assets.Exp3.hButtonLeft2.rawValue) as? SKSpriteNode,
              let aButton =  childNode(withName: Assets.Exp3.aButtonLeft2.rawValue) as? SKSpriteNode else { return }

        leftAlleles2 = [sButton, cButton, hButton, aButton]
    }

    private func replayAction() {
        self.replayLeftAlelles()
        self.replayRightAlleles()
        self.replayBunnies()
        self.replayLabels()
    }

    private func backAction() {
        if let previousScene = self.parentScene {
            self.view?.presentScene(previousScene)
        }
    }

    private func infoAction() {
        addChild(infoBlur)
        addChild(info)
        addChild(infoClose)
        addChild(infoLabel)
    }
    
    private func infoCloseAction() {
        info.removeFromParent()
        infoLabel.removeFromParent()
        infoClose.removeFromParent()
        infoBlur.removeFromParent()
    }

    private func replayLeftAlelles() {
        leftAlleles1[0].texture = SKTexture(imageNamed: Assets.General.sButtonClicked.rawValue)
        leftAlleles1[1].texture = SKTexture(imageNamed: Assets.General.cButton.rawValue)
        leftAlleles1[2].texture = SKTexture(imageNamed: Assets.General.hButton.rawValue)
        leftAlleles1[3].texture = SKTexture(imageNamed: Assets.General.aButton.rawValue)
        leftAlleles2[0].texture = SKTexture(imageNamed: Assets.General.sButtonClicked.rawValue)
        leftAlleles2[1].texture = SKTexture(imageNamed: Assets.General.cButton.rawValue)
        leftAlleles2[2].texture = SKTexture(imageNamed: Assets.General.hButton.rawValue)
        leftAlleles2[3].texture = SKTexture(imageNamed: Assets.General.aButton.rawValue)
        leftAlleles = [.S, .S]
    }

    private func replayRightAlleles() {
        rightAlleles1[0].texture = SKTexture(imageNamed: Assets.General.sButtonClicked.rawValue)
        rightAlleles1[1].texture = SKTexture(imageNamed: Assets.General.cButton.rawValue)
        rightAlleles1[2].texture = SKTexture(imageNamed: Assets.General.hButton.rawValue)
        rightAlleles1[3].texture = SKTexture(imageNamed: Assets.General.aButton.rawValue)
        rightAlleles2[0].texture = SKTexture(imageNamed: Assets.General.sButtonClicked.rawValue)
        rightAlleles2[1].texture = SKTexture(imageNamed: Assets.General.cButton.rawValue)
        rightAlleles2[2].texture = SKTexture(imageNamed: Assets.General.hButton.rawValue)
        rightAlleles2[3].texture = SKTexture(imageNamed: Assets.General.aButton.rawValue)
        rightAlleles = [.S, .S]
    }

    private func replayBunnies() {
        bunnyRight.texture = SKTexture(imageNamed: Assets.General.bunnyWild.rawValue)
        bunnyLeft.texture = SKTexture(imageNamed: Assets.General.bunnyWild.rawValue)
        resultBunnies[0].texture = SKTexture(imageNamed: Assets.General.bunnyDoubt.rawValue)
        resultBunnies[1].texture = SKTexture(imageNamed: Assets.General.bunnyDoubt.rawValue)
        resultBunnies[2].texture = SKTexture(imageNamed: Assets.General.bunnyDoubt.rawValue)
        resultBunnies[3].texture = SKTexture(imageNamed: Assets.General.bunnyDoubt.rawValue)
    }
    
    private func replayLabels() {
        labels[0].text = "?"
        labels[1].text = "?"
        labels[2].text = "?"
        labels[3].text = "?"
    }

    private func left1ButtonClicked(_ targetNode: String) {
        let buttonFirstLetter = targetNode.first?.description ?? ""
        leftAlleles[0] = Alleles(rawValue: buttonFirstLetter) ?? .S

        changeUnselectedLeft1Button()
        changeSelectedLeft1Button()
    }

    private func left2ButtonClicked(_ targetNode: String) {
        let buttonFirstLetter = targetNode.first?.description ?? ""
        leftAlleles[1] = Alleles(rawValue: buttonFirstLetter) ?? .S

        changeUnselectedLeft2Button()
        changeSelectedLeft2Button()
    }

    private func right1ButtonClicked(_ targetNode: String) {
        let buttonFirstLetter = targetNode.first?.description ?? ""
        rightAlleles[0] = Alleles(rawValue: buttonFirstLetter) ?? .S

        changeUnselectedRight1Button()
        changeSelectedRight1Button()
    }

    private func right2ButtonClicked(_ targetNode: String) {
        let buttonFirstLetter = targetNode.first?.description ?? ""
        rightAlleles[1] = Alleles(rawValue: buttonFirstLetter) ?? .S

        changeUnselectedRight2Button()
        changeSelectedRight2Button()
    }

    private func changeSelectedRight1Button() {
        if(rightAlleles[0].rawValue == rightAlleles1[0].name?.first?.description) {
            rightAlleles1[0].texture = SKTexture(imageNamed: Assets.General.sButtonClicked.rawValue)
        } else if(rightAlleles[0].rawValue == rightAlleles1[1].name?.first?.description) {
            rightAlleles1[1].texture = SKTexture(imageNamed: Assets.General.cButtonClicked.rawValue)
        } else if(rightAlleles[0].rawValue == rightAlleles1[2].name?.first?.description) {
            rightAlleles1[2].texture = SKTexture(imageNamed: Assets.General.hButtonClicked.rawValue)
        } else {
            rightAlleles1[3].texture = SKTexture(imageNamed: Assets.General.aButtonClicked.rawValue)
        }
    }

    private func changeSelectedRight2Button() {
        if(rightAlleles[1].rawValue == rightAlleles2[0].name?.first?.description) {
            rightAlleles2[0].texture = SKTexture(imageNamed: Assets.General.sButtonClicked.rawValue)
        } else if(rightAlleles[1].rawValue == rightAlleles2[1].name?.first?.description) {
            rightAlleles2[1].texture = SKTexture(imageNamed: Assets.General.cButtonClicked.rawValue)
        } else if(rightAlleles[1].rawValue == rightAlleles2[2].name?.first?.description) {
            rightAlleles2[2].texture = SKTexture(imageNamed: Assets.General.hButtonClicked.rawValue)
        } else {
            rightAlleles2[3].texture = SKTexture(imageNamed: Assets.General.aButtonClicked.rawValue)
        }
    }

    private func changeSelectedLeft1Button() {
        if(leftAlleles[0].rawValue == leftAlleles1[0].name?.first?.description) {
            leftAlleles1[0].texture = SKTexture(imageNamed: Assets.General.sButtonClicked.rawValue)
        } else if(leftAlleles[0].rawValue == leftAlleles1[1].name?.first?.description) {
            leftAlleles1[1].texture = SKTexture(imageNamed: Assets.General.cButtonClicked.rawValue)
        } else if(leftAlleles[0].rawValue == leftAlleles1[2].name?.first?.description) {
            leftAlleles1[2].texture = SKTexture(imageNamed: Assets.General.hButtonClicked.rawValue)
        } else {
            leftAlleles1[3].texture = SKTexture(imageNamed: Assets.General.aButtonClicked.rawValue)
        }
    }

    private func changeSelectedLeft2Button() {
        if(leftAlleles[1].rawValue == leftAlleles2[0].name?.first?.description) {
            leftAlleles2[0].texture = SKTexture(imageNamed: Assets.General.sButtonClicked.rawValue)
        } else if(leftAlleles[1].rawValue == leftAlleles2[1].name?.first?.description) {
            leftAlleles2[1].texture = SKTexture(imageNamed: Assets.General.cButtonClicked.rawValue)
        } else if(leftAlleles[1].rawValue == leftAlleles2[2].name?.first?.description) {
            leftAlleles2[2].texture = SKTexture(imageNamed: Assets.General.hButtonClicked.rawValue)
        } else {
            leftAlleles2[3].texture = SKTexture(imageNamed: Assets.General.aButtonClicked.rawValue)
        }
    }

    private func changeUnselectedRight1Button() {
        rightAlleles1[0].texture = SKTexture(imageNamed: Assets.General.sButton.rawValue)
        rightAlleles1[1].texture = SKTexture(imageNamed: Assets.General.cButton.rawValue)
        rightAlleles1[2].texture = SKTexture(imageNamed: Assets.General.hButton.rawValue)
        rightAlleles1[3].texture = SKTexture(imageNamed: Assets.General.aButton.rawValue)
    }

    private func changeUnselectedRight2Button() {
        rightAlleles2[0].texture = SKTexture(imageNamed: Assets.General.sButton.rawValue)
        rightAlleles2[1].texture = SKTexture(imageNamed: Assets.General.cButton.rawValue)
        rightAlleles2[2].texture = SKTexture(imageNamed: Assets.General.hButton.rawValue)
        rightAlleles2[3].texture = SKTexture(imageNamed: Assets.General.aButton.rawValue)
    }

    private func changeUnselectedLeft1Button() {
        leftAlleles1[0].texture = SKTexture(imageNamed: Assets.General.sButton.rawValue)
        leftAlleles1[1].texture = SKTexture(imageNamed: Assets.General.cButton.rawValue)
        leftAlleles1[2].texture = SKTexture(imageNamed: Assets.General.hButton.rawValue)
        leftAlleles1[3].texture = SKTexture(imageNamed: Assets.General.aButton.rawValue)
    }

    private func changeUnselectedLeft2Button() {
        leftAlleles2[0].texture = SKTexture(imageNamed: Assets.General.sButton.rawValue)
        leftAlleles2[1].texture = SKTexture(imageNamed: Assets.General.cButton.rawValue)
        leftAlleles2[2].texture = SKTexture(imageNamed: Assets.General.hButton.rawValue)
        leftAlleles2[3].texture = SKTexture(imageNamed: Assets.General.aButton.rawValue)
    }
}
