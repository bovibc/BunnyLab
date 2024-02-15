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
    case Start = "StartScene"
    case City = "CityScene"
    case Lab = "LabScene"
    case Woods = "WoodsScene"
    case FinishWoods = "FinishWoods"
}

class TransactionsScene: SKScene {

    static func goToCity(view: SKView?){
        guard let view = view else { return }
        let scene = GKScene(fileNamed: Scenes.City.rawValue)
        let transition = SKTransition.fade(with: .black, duration: 3.0)
        
        if let experiment = scene?.rootNode as? SKScene {
            view.presentScene(experiment, transition: transition)
        }
    }

    static func goToWoods(view: SKView?){
        guard let view = view else { return }
        let scene = GKScene(fileNamed: Scenes.Woods.rawValue)
        let transition = SKTransition.fade(with: .black, duration: 3.0)
        
        if let experiment = scene?.rootNode as? SKScene {
            view.presentScene(experiment, transition: transition)
        }
    }

    static func goToLab(view: SKView?){
        guard let view = view else { return }
        let scene = SKScene(fileNamed: Scenes.Lab.rawValue)
        let transition = SKTransition.fade(with: .black, duration: 3.0)
        
        if let experiment = scene {
            let experimentScene = experiment as! LabScene
            view.presentScene(experimentScene, transition: transition)
        }
    }

    static func goToFinishWoods(view: SKView?){
        guard let view = view else { return }
        let scene = GKScene(fileNamed: Scenes.FinishWoods.rawValue)
        let transition = SKTransition.fade(with: .black, duration: 3.0)
        
        if let experiment = scene?.rootNode as? SKScene {
            view.presentScene(experiment, transition: transition)
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
