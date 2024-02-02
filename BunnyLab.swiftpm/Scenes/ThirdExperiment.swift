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
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        let touchLocation = touch?.location(in: self)
        let targetNode = atPoint(touchLocation!) as! SKSpriteNode
        let name = targetNode.name ?? ""

        if leftAlleles1.contains(targetNode) {
            self.left1ButtonClicked(name)
        } else if rightAlleles1.contains(targetNode) {
            self.right1ButtonClicked(name)
        } else if leftAlleles2.contains(targetNode) {
            self.left2ButtonClicked(name)
        } else if rightAlleles2.contains(targetNode) {
            self.right2ButtonClicked(name)
        } else if(name == Assets.Images.merge.rawValue) {
            self.mergeAction()
        } else if(name == Assets.Images.replay.rawValue) {
            self.replayAction()
        } else if(name == Assets.Images.back.rawValue) {
            self.backAction()
        } else if(name == Assets.Images.info.rawValue) {
            self.infoAction()
        }

        self.updateBunnies()
    }

    // MARK: Private Methods
    private func setupBunnies() {
        guard let bunnyRight = childNode(withName: Assets.Exp2.bunnyRight.rawValue) as? SKSpriteNode,
              let bunnyLeft = childNode(withName: Assets.Exp2.bunnyLeft.rawValue) as? SKSpriteNode,
              let doubtBunny1 = childNode(withName: Assets.Exp2.bunnyDoubt1.rawValue) as? SKSpriteNode,
              let doubtBunny2 = childNode(withName: Assets.Exp2.bunnyDoubt2.rawValue) as? SKSpriteNode,
              let doubtBunny3 = childNode(withName: Assets.Exp2.bunnyDoubt3.rawValue) as? SKSpriteNode,
              let doubtBunny4 = childNode(withName: Assets.Exp2.bunnyDoubt4.rawValue) as? SKSpriteNode else { return }
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
        guard let label1 = childNode(withName: Assets.Exp2.label1.rawValue) as? SKLabelNode,
              let label2 = childNode(withName: Assets.Exp2.label2.rawValue) as? SKLabelNode,
              let label3 = childNode(withName: Assets.Exp2.label3.rawValue) as? SKLabelNode,
              let label4 = childNode(withName: Assets.Exp2.label4.rawValue) as? SKLabelNode else { return }

        labels = [label1, label2, label3, label4]
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
        guard let sButton = childNode(withName: Assets.Exp2.sButtonRight1.rawValue) as? SKSpriteNode,
              let cButton = childNode(withName: Assets.Exp2.cButtonRight1.rawValue) as? SKSpriteNode,
              let hButton =  childNode(withName: Assets.Exp2.hButtonRight1.rawValue) as? SKSpriteNode,
              let aButton =  childNode(withName: Assets.Exp2.aButtonRight1.rawValue) as? SKSpriteNode else { return }

        rightAlleles1 = [sButton, cButton, hButton, aButton]
    }

    private func setupRightButtons2() {
        guard let sButton = childNode(withName: Assets.Exp2.sButtonRight2.rawValue) as? SKSpriteNode,
              let cButton = childNode(withName: Assets.Exp2.cButtonRight2.rawValue) as? SKSpriteNode,
              let hButton =  childNode(withName: Assets.Exp2.hButtonRight2.rawValue) as? SKSpriteNode,
              let aButton =  childNode(withName: Assets.Exp2.aButtonRight2.rawValue) as? SKSpriteNode else { return }

        rightAlleles2 = [sButton, cButton, hButton, aButton]
    }

    private func setupLeftButtons1() {
        guard let sButton = childNode(withName: Assets.Exp2.sButtonLeft1.rawValue) as? SKSpriteNode,
              let cButton = childNode(withName: Assets.Exp2.cButtonLeft1.rawValue) as? SKSpriteNode,
              let hButton =  childNode(withName: Assets.Exp2.hButtonLeft1.rawValue) as? SKSpriteNode,
              let aButton =  childNode(withName: Assets.Exp2.aButtonLeft1.rawValue) as? SKSpriteNode else { return }

        leftAlleles1 = [sButton, cButton, hButton, aButton]
    }

    private func setupLeftButtons2() {
        guard let sButton = childNode(withName: Assets.Exp2.sButtonLeft2.rawValue) as? SKSpriteNode,
              let cButton = childNode(withName: Assets.Exp2.cButtonLeft2.rawValue) as? SKSpriteNode,
              let hButton =  childNode(withName: Assets.Exp2.hButtonLeft2.rawValue) as? SKSpriteNode,
              let aButton =  childNode(withName: Assets.Exp2.aButtonLeft2.rawValue) as? SKSpriteNode else { return }

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
        
    }

    private func replayLeftAlelles() {
        leftAlleles1[0].texture = SKTexture(imageNamed: Assets.Images.sButtonClicked.rawValue)
        leftAlleles1[1].texture = SKTexture(imageNamed: Assets.Images.cButton.rawValue)
        leftAlleles1[2].texture = SKTexture(imageNamed: Assets.Images.hButton.rawValue)
        leftAlleles1[3].texture = SKTexture(imageNamed: Assets.Images.aButton.rawValue)
        leftAlleles2[0].texture = SKTexture(imageNamed: Assets.Images.sButtonClicked.rawValue)
        leftAlleles2[1].texture = SKTexture(imageNamed: Assets.Images.cButton.rawValue)
        leftAlleles2[2].texture = SKTexture(imageNamed: Assets.Images.hButton.rawValue)
        leftAlleles2[3].texture = SKTexture(imageNamed: Assets.Images.aButton.rawValue)
        leftAlleles = [.S, .S]
    }

    private func replayRightAlleles() {
        rightAlleles1[0].texture = SKTexture(imageNamed: Assets.Images.sButtonClicked.rawValue)
        rightAlleles1[1].texture = SKTexture(imageNamed: Assets.Images.cButton.rawValue)
        rightAlleles1[2].texture = SKTexture(imageNamed: Assets.Images.hButton.rawValue)
        rightAlleles1[3].texture = SKTexture(imageNamed: Assets.Images.aButton.rawValue)
        rightAlleles2[0].texture = SKTexture(imageNamed: Assets.Images.sButtonClicked.rawValue)
        rightAlleles2[1].texture = SKTexture(imageNamed: Assets.Images.cButton.rawValue)
        rightAlleles2[2].texture = SKTexture(imageNamed: Assets.Images.hButton.rawValue)
        rightAlleles2[3].texture = SKTexture(imageNamed: Assets.Images.aButton.rawValue)
        rightAlleles = [.S, .S]
    }

    private func replayBunnies() {
        bunnyRight.texture = SKTexture(imageNamed: Assets.Images.bunnyWild.rawValue)
        bunnyLeft.texture = SKTexture(imageNamed: Assets.Images.bunnyWild.rawValue)
        resultBunnies[0].texture = SKTexture(imageNamed: Assets.Images.bunnyDoubt.rawValue)
        resultBunnies[1].texture = SKTexture(imageNamed: Assets.Images.bunnyDoubt.rawValue)
        resultBunnies[2].texture = SKTexture(imageNamed: Assets.Images.bunnyDoubt.rawValue)
        resultBunnies[3].texture = SKTexture(imageNamed: Assets.Images.bunnyDoubt.rawValue)
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
            rightAlleles1[0].texture = SKTexture(imageNamed: Assets.Images.sButtonClicked.rawValue)
        } else if(rightAlleles[0].rawValue == rightAlleles1[1].name?.first?.description) {
            rightAlleles1[1].texture = SKTexture(imageNamed: Assets.Images.cButtonClicked.rawValue)
        } else if(rightAlleles[0].rawValue == rightAlleles1[2].name?.first?.description) {
            rightAlleles1[2].texture = SKTexture(imageNamed: Assets.Images.hButtonClicked.rawValue)
        } else {
            rightAlleles1[3].texture = SKTexture(imageNamed: Assets.Images.aButtonClicked.rawValue)
        }
    }

    private func changeSelectedRight2Button() {
        if(rightAlleles[1].rawValue == rightAlleles2[0].name?.first?.description) {
            rightAlleles2[0].texture = SKTexture(imageNamed: Assets.Images.sButtonClicked.rawValue)
        } else if(rightAlleles[1].rawValue == rightAlleles2[1].name?.first?.description) {
            rightAlleles2[1].texture = SKTexture(imageNamed: Assets.Images.cButtonClicked.rawValue)
        } else if(rightAlleles[1].rawValue == rightAlleles2[2].name?.first?.description) {
            rightAlleles2[2].texture = SKTexture(imageNamed: Assets.Images.hButtonClicked.rawValue)
        } else {
            rightAlleles2[3].texture = SKTexture(imageNamed: Assets.Images.aButtonClicked.rawValue)
        }
    }

    private func changeSelectedLeft1Button() {
        if(leftAlleles[0].rawValue == leftAlleles1[0].name?.first?.description) {
            leftAlleles1[0].texture = SKTexture(imageNamed: Assets.Images.sButtonClicked.rawValue)
        } else if(leftAlleles[0].rawValue == leftAlleles1[1].name?.first?.description) {
            leftAlleles1[1].texture = SKTexture(imageNamed: Assets.Images.cButtonClicked.rawValue)
        } else if(leftAlleles[0].rawValue == leftAlleles1[2].name?.first?.description) {
            leftAlleles1[2].texture = SKTexture(imageNamed: Assets.Images.hButtonClicked.rawValue)
        } else {
            leftAlleles1[3].texture = SKTexture(imageNamed: Assets.Images.aButtonClicked.rawValue)
        }
    }

    private func changeSelectedLeft2Button() {
        if(leftAlleles[1].rawValue == leftAlleles2[0].name?.first?.description) {
            leftAlleles2[0].texture = SKTexture(imageNamed: Assets.Images.sButtonClicked.rawValue)
        } else if(leftAlleles[1].rawValue == leftAlleles2[1].name?.first?.description) {
            leftAlleles2[1].texture = SKTexture(imageNamed: Assets.Images.cButtonClicked.rawValue)
        } else if(leftAlleles[1].rawValue == leftAlleles2[2].name?.first?.description) {
            leftAlleles2[2].texture = SKTexture(imageNamed: Assets.Images.hButtonClicked.rawValue)
        } else {
            leftAlleles2[3].texture = SKTexture(imageNamed: Assets.Images.aButtonClicked.rawValue)
        }
    }

    private func changeUnselectedRight1Button() {
        rightAlleles1[0].texture = SKTexture(imageNamed: Assets.Images.sButton.rawValue)
        rightAlleles1[1].texture = SKTexture(imageNamed: Assets.Images.cButton.rawValue)
        rightAlleles1[2].texture = SKTexture(imageNamed: Assets.Images.hButton.rawValue)
        rightAlleles1[3].texture = SKTexture(imageNamed: Assets.Images.aButton.rawValue)
    }

    private func changeUnselectedRight2Button() {
        rightAlleles2[0].texture = SKTexture(imageNamed: Assets.Images.sButton.rawValue)
        rightAlleles2[1].texture = SKTexture(imageNamed: Assets.Images.cButton.rawValue)
        rightAlleles2[2].texture = SKTexture(imageNamed: Assets.Images.hButton.rawValue)
        rightAlleles2[3].texture = SKTexture(imageNamed: Assets.Images.aButton.rawValue)
    }

    private func changeUnselectedLeft1Button() {
        leftAlleles1[0].texture = SKTexture(imageNamed: Assets.Images.sButton.rawValue)
        leftAlleles1[1].texture = SKTexture(imageNamed: Assets.Images.cButton.rawValue)
        leftAlleles1[2].texture = SKTexture(imageNamed: Assets.Images.hButton.rawValue)
        leftAlleles1[3].texture = SKTexture(imageNamed: Assets.Images.aButton.rawValue)
    }

    private func changeUnselectedLeft2Button() {
        leftAlleles2[0].texture = SKTexture(imageNamed: Assets.Images.sButton.rawValue)
        leftAlleles2[1].texture = SKTexture(imageNamed: Assets.Images.cButton.rawValue)
        leftAlleles2[2].texture = SKTexture(imageNamed: Assets.Images.hButton.rawValue)
        leftAlleles2[3].texture = SKTexture(imageNamed: Assets.Images.aButton.rawValue)
    }
}
