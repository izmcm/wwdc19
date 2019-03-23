import SpriteKit

public class FirstLevelScene: SKScene {
    
    let FONT_SIZE:CGFloat = 25
    let WALK_ACTION = 1
    let LIMIT_CODE = 1
    let WALK_SIZE = 135
    
    var screenWidth:CGFloat = 600
    var screenHeight:CGFloat = 800
    
    var blu = SKSpriteNode()
    var car = SKSpriteNode()
    var need = SKSpriteNode()
    
    // BUTTONS
    var walkBtn = SKSpriteNode()
    var runBtn = SKSpriteNode()
    var undoBtn = SKSpriteNode()
    
    // POPUP
    var needLessCode = SKSpriteNode()
    
    // ANSWER
    var codeAns:[Int] = []
    var posCodAt = CGPoint(x: 0, y: 0)
    var posCodeInit = CGPoint(x: 0, y: 0)
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.8588235294, blue: 0.8, alpha: 1)
        
        screenWidth = self.view!.frame.size.width
        screenHeight = self.view!.frame.size.height
        
        drawBoard()
    }
    
    // MARK: - DRAW BOARD
    public func drawBoard() {
        self.view!.isUserInteractionEnabled = true
        
        let paragraphCenter = NSMutableParagraphStyle()
        paragraphCenter.alignment = .center
        paragraphCenter.firstLineHeadIndent = 5.0
        
        let background = SKSpriteNode(imageNamed: "backScene01")
        background.size = CGSize(width: screenWidth, height: screenHeight)
        background.position = CGPoint(x: background.frame.size.width/2, y: background.frame.size.height/2)
        self.addChild(background)
        
        blu = SKSpriteNode(imageNamed: "BLU")
        blu.size = CGSize(width: screenWidth/35, height: 1.3*screenWidth/35)
        blu.position = CGPoint(x: screenWidth/4 + blu.frame.size.width/2, y: 2*screenHeight/3 - blu.frame.size.height/2)
        self.addChild(blu)
        
        let trafficLight = SKSpriteNode(imageNamed: "trafficlightRed")
        trafficLight.size = CGSize(width: blu.frame.size.height*0.5, height: blu.frame.size.height*2)
        trafficLight.position = CGPoint(x: blu.position.x - blu.frame.size.width, y: blu.position.y)
        self.addChild(trafficLight)
        
        car = SKSpriteNode(imageNamed: "carRed")
        car.size = CGSize(width: 1.3*blu.frame.size.height, height: blu.frame.size.height)
        car.position = CGPoint(x: trafficLight.position.x - car.frame.size.width, y: screenHeight/2 - trafficLight.frame.size.height/4)
        self.addChild(car)
        
        runBtn = SKSpriteNode(imageNamed: "runBtn")
        runBtn.size = CGSize(width: screenWidth/10, height: 0.4*screenWidth/10)
        runBtn.position = CGPoint(x: screenWidth - screenWidth*0.2, y: screenHeight/2 - 1.1*runBtn.frame.size.height)
        self.addChild(runBtn)
        
        let strComment = NSAttributedString(string:"// code!", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_SIZE, weight: .light),
             NSAttributedString.Key.paragraphStyle: paragraphCenter])
        let commentLbl = SKLabelNode(attributedText: strComment)
        commentLbl.horizontalAlignmentMode = .center
        commentLbl.verticalAlignmentMode = .center
        commentLbl.numberOfLines = 0;
        commentLbl.lineBreakMode = .byWordWrapping
        commentLbl.position = CGPoint(x: runBtn.position.x, y: 0.95*screenHeight)
        self.addChild(commentLbl)
        
        undoBtn = SKSpriteNode(imageNamed: "undoBtn")
        undoBtn.size = CGSize(width: commentLbl.frame.size.height, height: commentLbl.frame.size.height)
        undoBtn.position = CGPoint(x: commentLbl.position.x + commentLbl.frame.size.width, y: commentLbl.position.y)
        self.addChild(undoBtn)
        
        walkBtn = SKSpriteNode(imageNamed: "walkBtn")
        walkBtn.size = CGSize(width: runBtn.frame.size.width, height: runBtn.frame.size.height)
        walkBtn.position = CGPoint(x: commentLbl.position.x, y: screenHeight/5)
        self.addChild(walkBtn)
        
        // first code position
        posCodeInit = CGPoint(x: commentLbl.position.x, y: commentLbl.position.y - walkBtn.frame.size.height/2)
        
        // RED
        need = SKSpriteNode(imageNamed: "need01")
        need.size = CGSize(width: screenWidth/2, height: 0.65*screenWidth/2)
        need.position = CGPoint(x: need.frame.size.width/2, y: need.frame.size.height/2)
        need.zPosition = 99999
        self.addChild(need)
        
        needLessCode = SKSpriteNode(imageNamed: "needLessCode")
        needLessCode.size = CGSize(width: screenWidth/2, height: 0.65*screenWidth/2)
        needLessCode.position = CGPoint(x: needLessCode.frame.size.width/2, y: -needLessCode.frame.size.height/2)
        needLessCode.zPosition = 99999

        self.addChild(needLessCode)
    }
    
    // MARK: - MOVES
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if need.position.y >= need.frame.size.height/2 {
            let action = SKAction.moveBy(x: 0, y: -need.frame.size.height, duration: 1)
            need.run(action)
        }
        
        if needLessCode.position.y >= 0 {
            let action = SKAction.moveBy(x: 0, y: -needLessCode.frame.size.height, duration: 1)
            needLessCode.run(action)
        }
        
        if walkBtn.contains(touchLocation) {
            walkBtnClick()
        }
        else if runBtn.contains(touchLocation) {
            runBtnClick()
        }
        else if undoBtn.contains(touchLocation) {
            if(codeAns.count > 0){
                codeAns.removeLast()
                drawCode()
            }
        }
    }
    
    // MARK: - ACTIONS
    func runBtnClick() {
        if codeAns.count <= LIMIT_CODE {
            self.view!.isUserInteractionEnabled = false

            for i in codeAns {
                if i == WALK_ACTION {
                    let moveAction = SKAction.moveBy(x: 0, y: -CGFloat(WALK_SIZE), duration: 1)
                    blu.run(moveAction)
                    
                    stars += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.goBtnClick()
                    }
                }
            }
        }
        else {
            let action = SKAction.moveBy(x: 0, y: needLessCode.frame.size.height, duration: 1)
            needLessCode.run(action)
        }
    }
    
    func walkBtnClick() {
        if codeAns.count < 8 {
            codeAns.append(WALK_ACTION)
            drawCode()
        }
    }
    
    func goBtnClick() {
        let sceneMoveTo = SecondLevelScene(size: self.size)
        sceneMoveTo.scaleMode = self.scaleMode
        
        let transition = SKTransition.moveIn(with: .right, duration: 0.8)
        self.scene?.view?.presentScene(sceneMoveTo ,transition: transition)
    }
    
    // MARK: - DRAW CODE
    func drawCode() {
        self.enumerateChildNodes(withName: "CODE_SPRITE") { (node: SKNode, nil) in
            node.removeFromParent()
        }
        
        posCodAt = posCodeInit
        
        for i in codeAns {
            if i == WALK_ACTION {
                let ansSprite = SKSpriteNode(imageNamed: "walkBtn")
                ansSprite.size = CGSize(width: walkBtn.frame.size.width, height: walkBtn.frame.size.height)
                ansSprite.position = CGPoint(x: posCodAt.x, y: posCodAt.y - ansSprite.frame.size.height)
                ansSprite.name = "CODE_SPRITE"
                self.addChild(ansSprite)
                
                posCodAt.y -= walkBtn.frame.size.height
            }
        }
    }
}
