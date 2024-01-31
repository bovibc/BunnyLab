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
    var selectedButtonRight: SKSpriteNode?
    var selectedButtonLeft: SKSpriteNode?
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
        selectedButtonLeft = sButton
        sButton.texture = SKTexture(imageNamed: assets.sButtonClicked)
    }
    
    private func setupRightButtons() {
        guard let sButton = childNode(withName: assets.sButtonRight) as? SKSpriteNode,
              let cButton = childNode(withName: assets.cButtonRight) as? SKSpriteNode,
              let hButton =  childNode(withName: assets.hButtonRight) as? SKSpriteNode,
              let aButton =  childNode(withName: assets.aButtonRight) as? SKSpriteNode else { return }
    
        rightAlleles = [sButton, cButton, hButton, aButton]
        selectedButtonRight = sButton
        sButton.texture = SKTexture(imageNamed: assets.sButtonClicked)
    }

    private func rightButtonClicked(_ targetNode: String) {
        let button = rightAlleles.filter {$0.name == targetNode}
        let buttonFirstLetter = targetNode.first?.description ?? ""
        rightAllele = Alleles(rawValue: buttonFirstLetter) ?? .S
        
        button[0].texture = SKTexture(imageNamed: assets.sButtonClicked)
        
    }

    private func leftButtonClicked(_ targetNode: String) {
        
    }
    
    private func changeRightButton() {
        
    }
}
