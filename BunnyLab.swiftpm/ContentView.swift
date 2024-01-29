import SwiftUI
import SpriteKit

struct ContentView: View {
    @State var currentScene: SKScene = LabScene(size:
            CGSize(width: 1024, height: 768))

    var body: some View {
        SpriteView(scene: currentScene)
    }
}
