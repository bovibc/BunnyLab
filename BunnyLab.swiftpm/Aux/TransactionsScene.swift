//
//  TrasactionsScenes.swift
//  Capivarias
//
//  Created by Renan Tavares on 27/10/23.
//

import Foundation
import SpriteKit
import GameplayKit
import GameController

class TrasactionsScenes: SKScene {
    static func goToExperiment(view: SKView?, experimentName: String){
        guard let view = view else { return }
        let scene = GKScene(fileNamed: experimentName)
        
        if let experiment = scene?.rootNode as? SKScene {
//            experiment.scaleMode = .fill
            view.presentScene(experiment)
        }
    }
}
