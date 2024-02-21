//
//  FirstExperiment.swift
//  
//
//  Created by Clissia Bozzer Bovi on 15/02/24.
//

import UIKit
import SpriteKit

class FirstExperiment: SKScene {
    // MARK: Variable
    var parentScene: SKScene?
    var containers: [SKSpriteNode] = []
    var clickedContainers: [SKSpriteNode] = []
    var correctContainers: [SKSpriteNode] = []
    
    var info: SKSpriteNode!
    var infoLabel: SKLabelNode!
    var infoBlur: SKSpriteNode!
    var infoClose: SKSpriteNode!
    
    var finishLabel: SKLabelNode!
    var finishLabel2: SKLabelNode!
    var finishLabel3: SKLabelNode!
    
    var previousArrow: SKSpriteNode!
    var nextArrow: SKSpriteNode!
    
    var index: Int = 0
    var infoIsAppearing: Bool = false
    
    // MARK: Inherited Methods
    override func didMove(to view: SKView) {
        self.setContainers()
        self.setupInfo()
        self.setupFinish()
        self.setupArrows()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        let touchLocation = touch?.location(in: self)
        let targetNode = atPoint(touchLocation!) as! SKSpriteNode
        let name = targetNode.name
        if let name = Assets.Exp1(rawValue: name ?? "") {
            containerPressed(name)
        } else if name == Assets.General.doneButton.rawValue {
            pressedDoneButton()
        } else if(name == Assets.General.back.rawValue) {
            self.backAction()
        } else if(name == Assets.General.info.rawValue) {
            self.infoAction()
        } else if(name == Assets.General.infoClose.rawValue) {
            self.infoCloseAction()
        } else if(name == Assets.General.nextArrow.rawValue) {
            self.treatNextArrow()
        } else if(name == Assets.General.previousArrow.rawValue) {
            self.treatPreviousArrow()
        }
    }
    
    // MARK: Private Methods
    private func setContainers() {
        guard let one = childNode(withName: Assets.Exp1.one.rawValue) as? SKSpriteNode,
              let two = childNode(withName: Assets.Exp1.two.rawValue) as? SKSpriteNode,
              let three =  childNode(withName: Assets.Exp1.three.rawValue) as? SKSpriteNode,
              let four =  childNode(withName: Assets.Exp1.four.rawValue) as? SKSpriteNode,
              let five = childNode(withName: Assets.Exp1.five.rawValue) as? SKSpriteNode,
              let six = childNode(withName: Assets.Exp1.six.rawValue) as? SKSpriteNode,
              let seven =  childNode(withName: Assets.Exp1.seven.rawValue) as? SKSpriteNode,
              let eight =  childNode(withName: Assets.Exp1.eight.rawValue) as? SKSpriteNode,
              let nine = childNode(withName: Assets.Exp1.nine.rawValue) as? SKSpriteNode,
              let ten = childNode(withName: Assets.Exp1.ten.rawValue) as? SKSpriteNode,
              let eleven =  childNode(withName: Assets.Exp1.eleven.rawValue) as? SKSpriteNode,
              let twelve =  childNode(withName: Assets.Exp1.twelve.rawValue) as? SKSpriteNode else { return }
        
        self.containers = [one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve]
        self.correctContainers = [three, four, six, eleven]
    }
    
    private func setupInfo() {
        info = childNode(withName: Assets.General.infoBoard.rawValue) as? SKSpriteNode
        infoLabel = childNode(withName: Assets.General.infoLabel.rawValue) as? SKLabelNode
        infoBlur = childNode(withName: Assets.General.infoBlur.rawValue) as? SKSpriteNode
        infoClose = childNode(withName: Assets.General.infoClose.rawValue) as? SKSpriteNode
    }
    
    private func setupFinish() {
        finishLabel = childNode(withName: Assets.General.finishLabel.rawValue) as? SKLabelNode
        finishLabel2 = childNode(withName: Assets.General.finishLabel2.rawValue) as? SKLabelNode
        finishLabel3 = childNode(withName: Assets.General.finishLabel3.rawValue) as? SKLabelNode
        
        finishLabel.isHidden = true
        finishLabel2.isHidden = true
        finishLabel3.isHidden = true
    }
    
    private func setupArrows() {
        previousArrow = childNode(withName: Assets.General.previousArrow.rawValue) as? SKSpriteNode
        nextArrow = childNode(withName: Assets.General.nextArrow.rawValue) as? SKSpriteNode
        
        removeArrows()
    }
    
    private func containerPressed(_ name: Assets.Exp1) {
        let indexC = (Int(name.rawValue) ?? 1) - 1
        let container = containers[indexC]
        if clickedContainers.contains(container) {
            let deleteIndex = clickedContainers.firstIndex(of: container) ?? 0
            clickedContainers.remove(at: deleteIndex)
            container.texture = SKTexture(imageNamed: name.rawValue)
        } else {
            clickedContainers.append(container)
            container.texture = SKTexture(imageNamed: "\(name.rawValue)r")
        }
    }
    
    private func pressedDoneButton() {
        if isGameFinished() {
            hideInfo()
            finishGame1()
        }
        tryAgain()
    }
    
    private func isGameFinished() -> Bool {
        guard clickedContainers.count == correctContainers.count else { return false }
        for i in clickedContainers {
            if !correctContainers.contains(i) {
                return false
            }
        }
        return true
    }
    
    private func backAction() {
        if let previousScene = self.parentScene {
            self.view?.presentScene(previousScene)
        }
    }
    
    private func infoAction() {
        if !infoIsAppearing { addInfoOrFinish() }
        infoIsAppearing = true
        infoLabel.isHidden = false
        finishLabel.isHidden = true
        finishLabel2.isHidden = true
        finishLabel3.isHidden = true
    }
    
    private func infoCloseAction() {
        info.removeFromParent()
        infoLabel.removeFromParent()
        infoClose.removeFromParent()
        infoBlur.removeFromParent()
        finishLabel.removeFromParent()
        finishLabel2.removeFromParent()
        finishLabel3.removeFromParent()
        removeArrows()
        infoIsAppearing = false
    }
    
    private func tryAgain() {
        for i in clickedContainers {
            i.texture = SKTexture(imageNamed: i.name ?? "")
        }
        clickedContainers = []
    }
    
    private func finishGame1() {
        if !infoIsAppearing { addInfoOrFinish() }
        removeArrows()
        index = 0
        finishLabel.isHidden = false
        finishLabel2.isHidden = true
        finishLabel3.isHidden = true
        
        addChild(nextArrow)
        previousArrow.removeFromParent()
    }
    
    private func finishGame2() {
        removeArrows()
        finishLabel.isHidden = true
        finishLabel2.isHidden = false
        finishLabel3.isHidden = true
        
        addChild(nextArrow)
        addChild(previousArrow)
    }
    
    private func finishGame3() {
        removeArrows()
        finishLabel.isHidden = true
        finishLabel2.isHidden = true
        finishLabel3.isHidden = false
        infoClose.isHidden = false
        
        nextArrow.removeFromParent()
        addChild(previousArrow)
    }
    
    private func treatNextArrow() {
        if index == 1 {
            index+=1
            finishGame3()
        } else if index == 0 {
            index+=1
            finishGame2()
        }
    }
    
    private func treatPreviousArrow() {
        if index == 1 {
            index-=1
            finishGame1()
        } else if index == 2 {
            index-=1
            finishGame2()
        }
    }
    
    private func hideInfo() {
        infoLabel.isHidden = true
        infoClose.isHidden = true
    }
    
    private func addInfoOrFinish() {
        addChild(infoBlur)
        addChild(info)
        addChild(infoClose)
        addChild(infoLabel)
        addChild(finishLabel)
        addChild(finishLabel2)
        addChild(finishLabel3)
        infoIsAppearing = true
    }

    private func removeArrows() {
        nextArrow.removeFromParent()
        previousArrow.removeFromParent()
    }
}
