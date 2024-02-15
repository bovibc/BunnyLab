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
    
    // MARK: Inherited Methods
    override func didMove(to view: SKView) {
        self.setContainers()
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
    }
}
