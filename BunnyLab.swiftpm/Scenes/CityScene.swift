//
//  CityScene.swift
//  
//
//  Created by Clissia Bozzer Bovi on 08/02/24.
//

import UIKit
import SpriteKit

class CityScene: SKScene {
    // MARK: Variable
    var talkBlur: SKSpriteNode!
    var talkBalloon: SKSpriteNode!
    var talkLabel: SKLabelNode!
    var talkArrow: SKSpriteNode!
    var talkArrowBack: SKSpriteNode!
    
    var talkArrowBackIsRemoved = true
    let textFlow: TextFlow = TextFlow()

    // MARK: Inherited Methods
    override func didMove(to view: SKView) {
        self.setupTalk()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.talkInit()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        let touchLocation = touch?.location(in: self)
        let targetNode = atPoint(touchLocation!) as! SKSpriteNode
        
        if targetNode.name == Assets.General.talkArrow.rawValue {
            nextTalk()
        } else if targetNode.name == Assets.General.talkArrowBack.rawValue {
            previousTalk()
        }
    }

    // MARK: Private Methods
    private func setupTalk() {
        self.talkBlur = childNode(withName: Assets.General.talkBlur.rawValue) as? SKSpriteNode
        self.talkBalloon = childNode(withName: Assets.General.talkBalloon.rawValue) as? SKSpriteNode
        self.talkLabel = childNode(withName: Assets.General.talkLabel.rawValue) as? SKLabelNode
        self.talkArrow = childNode(withName: Assets.General.talkArrow.rawValue) as? SKSpriteNode
        self.talkArrowBack = childNode(withName: Assets.General.talkArrowBack.rawValue) as? SKSpriteNode
        
        talkBlur.removeFromParent()
        talkBalloon.removeFromParent()
        talkLabel.removeFromParent()
        talkArrow.removeFromParent()
        talkArrowBack.removeFromParent()
    }

    private func talkInit() {
        talkLabel.text = textFlow.startText(flow: .City)
        self.addChild(talkBlur)
        self.addChild(talkBalloon)
        self.addChild(talkLabel)
        self.addChild(talkArrow)
    }

    private func nextTalk() {
        guard let text = textFlow.nextText() else {
            finishText()
            goesToWoods()
            return
        }

        if talkArrowBackIsRemoved && textFlow.isFirstIndex() {
            talkArrowBackIsRemoved = false
            addChild(talkArrowBack)
        }

        talkLabel.text = text
    }

    private func previousTalk() {
        guard let text = textFlow.previousText() else {
            finishText()
            return
        }
        
        if textFlow.isZeroIndex() {
            talkArrowBackIsRemoved = true
            talkArrowBack.removeFromParent()
        }

        talkLabel.text = text
    }

    private func finishText() {
        talkBlur.removeFromParent()
        talkBalloon.removeFromParent()
        talkLabel.removeFromParent()
        talkArrow.removeFromParent()
        talkArrowBack.removeFromParent()
        talkArrowBackIsRemoved = true
    }
    
    private func goesToWoods() {
        TransactionsScene.goToWoods(view: self.view)
    }
}
