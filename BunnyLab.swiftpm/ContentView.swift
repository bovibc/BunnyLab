import SwiftUI
import SpriteKit

struct ContentView: View {
    let gameScene = SKScene(fileNamed: "WoodsScene")

    var body: some View {
        if let gameScene {
            SpriteView(scene: gameScene)
                .ignoresSafeArea()
        }
    }
}
