
import PlaygroundSupport
import SpriteKit

let frame = CGRect(x: 0, y: 0, width: 600, height: 800)

var scene = FirstLevelScene(size: frame.size)

let view = SKView(frame: frame)
view.presentScene(scene)

PlaygroundPage.current.liveView = view

