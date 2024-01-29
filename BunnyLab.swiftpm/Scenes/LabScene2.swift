//
//  File.swift
//  
//
//  Created by Clissia Bozzer Bovi on 29/01/24.
//

import SpriteKit
import SwiftUI
 
class LabScene2: SKScene {
    
    var sceneCamera: SKCameraNode = SKCameraNode()
    var player: SKNode!
    
    override func didMove(to view: SKView) {
        self.camera = sceneCamera
        self.player = childNode(withName: "player")
        //camera?.position.x = player.position.x
        
    }
}
