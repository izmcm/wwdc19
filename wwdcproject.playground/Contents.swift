
import PlaygroundSupport
import SpriteKit
import AVFoundation

var myAudio: AVAudioPlayer!

/***** MUSIC *****/
let path = Bundle.main.path(forResource: "musicloop", ofType: "mp3")!
let url = URL(fileURLWithPath: path)
do {
    let sound = try AVAudioPlayer(contentsOf: url)
    myAudio = sound
    sound.numberOfLoops = -1
    sound.play()
} catch {
    // error
}

/***** SCENE *****/
let frame = CGRect(x: 0, y: 0, width: 800, height: 600)

var scene = InstructionsScene(size: frame.size)

let view = SKView(frame: frame)
view.presentScene(scene)

PlaygroundPage.current.liveView = view

