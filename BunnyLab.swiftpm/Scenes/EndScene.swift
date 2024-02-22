//
//  EndScene.swift
//  
//
//  Created by Clissia Bozzer Bovi on 15/02/24.
//

import UIKit
import SpriteKit

class EndScene: SKScene {
    // MARK: Variable
    var replayButton: SKSpriteNode!

    // MARK: Inherited Methods
    override func didMove(to view: SKView) {
        self.setupReplay()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        let touchLocation = touch?.location(in: self)
        let targetNode = atPoint(touchLocation!) as? SKSpriteNode
        
        if targetNode?.name == Assets.General.replayButton.rawValue {
         goesToNewGame()
        }
    }

    // MARK: Private Methods
    private func setupReplay() {
        self.replayButton = childNode(withName: Assets.General.replayButton.rawValue) as? SKSpriteNode
    }

    private func goesToNewGame() {
        TransactionsScene.goToStart(view: self.view)
    }
}
