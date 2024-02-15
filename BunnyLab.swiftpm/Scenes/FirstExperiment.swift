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
    
    // MARK: Inherited Methods
    override func didMove(to view: SKView) {
        self.setContainers()
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

    private func containerPressed(_ name: Assets.Exp1) {
        let index = (Int(name.rawValue) ?? 1) - 1
        let container = containers[index]
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
        print(isGameFinished())
        if isGameFinished() {
            
        } else {
            
        }
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
}
