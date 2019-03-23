
import PlaygroundSupport
import SpriteKit

let frame = CGRect(x: 0, y: 0, width: 800, height: 600)

var scene = FinalScene(size: frame.size)

let view = SKView(frame: frame)
view.presentScene(scene)

PlaygroundPage.current.liveView = view

