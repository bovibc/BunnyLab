import SwiftUI
import SpriteKit

struct ContentView: View {
    let gameScene = SKScene(fileNamed: Scenes.Lab.rawValue)

    var body: some View {
        if let gameScene {
            SpriteView(scene: gameScene)
                .ignoresSafeArea()
        }
    }
}
