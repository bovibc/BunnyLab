//
//  StartScene.swift
//  
//
//  Created by Clissia Bozzer Bovi on 09/02/24.
//

import UIKit
import SpriteKit

class StartScene: SKScene {
    // MARK: Variables
    var playButton: SKSpriteNode!

    // MARK: Inherited Methods
    override func didMove(to view: SKView) {
        self.playButton = childNode(withName: Assets.General.play.rawValue) as? SKSpriteNode
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        let touchLocation = touch?.location(in: self)
        let targetNode = atPoint(touchLocation!) as! SKSpriteNode
        let name = targetNode.name ?? ""

        if(name == Assets.General.play.rawValue) {
            self.playButtonPressed()
        }
    }

    // MARK: Private Methods
    private func playButtonPressed() {
        TransactionsScene.goToCity(view: self.view)
    }
}
