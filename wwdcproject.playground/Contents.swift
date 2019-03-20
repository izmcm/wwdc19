
import PlaygroundSupport
import SpriteKit

let frame = CGRect(x: 0, y: 0, width: 600, height: 700)

var scene = FirstScene(size: frame.size)

let view = SKView(frame: frame)
view.presentScene(scene)

PlaygroundPage.current.liveView = view

