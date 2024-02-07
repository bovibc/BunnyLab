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

enum Experiments: String {
    case One = "FirtExperiment"
    case Two = "SecondExperiment"
    case Three = "ThirdExperiment"
}

enum Scenes: String {
    case Lab = "LabScene"
}

class TrasactionsScenes: SKScene {
    static func goToLab(view: SKView?){
        guard let view = view else { return }
        let scene = GKScene(fileNamed: Scenes.Lab.rawValue)
        
        if let experiment = scene?.rootNode as? SKScene {
            let experimentScene = experiment as! LabScene
            view.presentScene(experimentScene)
        }
    }
    
    static func goToSecondExperiment(view: SKView?, _ parent: SKScene){
        guard let view = view else { return }
        let scene = GKScene(fileNamed: Experiments.Two.rawValue)
        
        if let experiment = scene?.rootNode as? SKScene {
            let experimentScene = experiment as! SecondExperiment
            experimentScene.parentScene = parent
            view.presentScene(experimentScene)
        }
    }
    
    static func goToThirdExperiment(view: SKView?, _ parent: SKScene){
        guard let view = view else { return }
        let scene = GKScene(fileNamed: Experiments.Three.rawValue)
        
        if let experiment = scene?.rootNode as? SKScene {
            let experimentScene = experiment as! ThirdExperiment
            experimentScene.parentScene = parent
            view.presentScene(experimentScene)
        }
    }

}
