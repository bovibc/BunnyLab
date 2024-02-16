//
//  File.swift
//  
//
//  Created by Clissia Bozzer Bovi on 16/02/24.
//

import Foundation
import SpriteKit
import AVFoundation

public let audio = AudioPlayer.sharedInstance()
private let audioPlayer = AudioPlayer()

public class AudioPlayer {
    var musicPlayer: AVAudioPlayer!

    static var canShareAudio = false {
        didSet {
            canShareAudio ? try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient) : try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.soloAmbient)
        }
    }

    public class func sharedInstance() -> AudioPlayer {
        return audioPlayer
    }

    public func playBackgroundMusic() {
        if let url = Bundle.main.url(forResource: "acousticbreeze", withExtension: "mp3") {
            musicPlayer = try? AVAudioPlayer(contentsOf: url)
            musicPlayer.numberOfLoops = -1
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        }
    }
}
