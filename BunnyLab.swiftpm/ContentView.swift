import SwiftUI
import SpriteKit

struct ContentView: View {
    let gameScene = SKScene(fileNamed: "LabScene2")

    var body: some View {
        if let gameScene {
            SpriteView(scene: gameScene)
                .ignoresSafeArea()
        }
    }
}
