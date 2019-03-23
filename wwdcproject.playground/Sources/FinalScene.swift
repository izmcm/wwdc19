import SpriteKit

public class FinalScene: SKScene {
    let FONT_SIZE:CGFloat = 25
    let START_ACTION = 1
    let LIMIT_CODE = 8
    
    var screenWidth:CGFloat = 600
    var screenHeight:CGFloat = 800
    
    var blu = SKSpriteNode()
    var car = SKSpriteNode()
    
    // BUTTONS
    var startBtnCode = SKSpriteNode()
    var startBtn = SKSpriteNode()
    var runBtn = SKSpriteNode()
    var undoBtn = SKSpriteNode()
    
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
        
        let background = SKSpriteNode(imageNamed: "backSceneFinal")
        background.size = CGSize(width: screenWidth, height: screenHeight)
        background.position = CGPoint(x: background.frame.size.width/2, y: background.frame.size.height/2)
        self.addChild(background)
        
        car = SKSpriteNode(imageNamed: "carRed")
        car.size = CGSize(width: screenWidth/20, height: 0.7*screenWidth/20)
        car.position = CGPoint(x: -car.frame.size.width, y: 9*screenHeight/10 + car.frame.size.height)
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
        
        startBtnCode = SKSpriteNode(imageNamed: "playAgainBtn")
        startBtnCode.size = CGSize(width: 1.5*runBtn.frame.size.width, height: runBtn.frame.size.height)
        startBtnCode.position = CGPoint(x: commentLbl.position.x, y: screenHeight/5)
        self.addChild(startBtnCode)
        
        // first code position
        posCodeInit = CGPoint(x: commentLbl.position.x, y: commentLbl.position.y - startBtnCode.frame.size.height/2)
        
        let strFinal = NSAttributedString(string:"YOU FINISHED\n\(stars)/4\nCHALLENGES", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_SIZE+15, weight: .medium),
             NSAttributedString.Key.paragraphStyle: paragraphCenter])
        let finalLbl = SKLabelNode(attributedText: strFinal)
        finalLbl.horizontalAlignmentMode = .center
        finalLbl.verticalAlignmentMode = .center
        finalLbl.numberOfLines = 0;
        finalLbl.lineBreakMode = .byWordWrapping
        finalLbl.position = CGPoint(x: screenWidth/3, y: 2*screenHeight/3)
        self.addChild(finalLbl)
    }
    
    // MARK: - MOVES
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if startBtn.contains(touchLocation) {
            goBtnClick()
        }
        if startBtnCode.contains(touchLocation) {
            startBtnCodeClick()
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
        if codeAns.count == 0 {
            
        }
        if codeAns.count <= LIMIT_CODE {
            self.view!.isUserInteractionEnabled = false
            
            for i in codeAns {
                if i == START_ACTION {
                    self.goBtnClick()
                }
            }
        }
        
    }
    
    func startBtnCodeClick() {
        if codeAns.count < 8 {
            codeAns.append(START_ACTION)
            drawCode()
        }
    }
    
    func goBtnClick() {
        let sceneMoveTo = InstructionsScene(size: self.size)
        sceneMoveTo.scaleMode = self.scaleMode
        
        let transition = SKTransition.moveIn(with: .right, duration: 1)
        self.scene?.view?.presentScene(sceneMoveTo ,transition: transition)
    }
    
    // MARK: - DRAW CODE
    func drawCode() {
        self.enumerateChildNodes(withName: "CODE_SPRITE") { (node: SKNode, nil) in
            node.removeFromParent()
        }
        
        posCodAt = posCodeInit
        
        for i in codeAns {
            if i == START_ACTION {
                let ansSprite = SKSpriteNode(imageNamed: "playAgainBtn")
                ansSprite.size = CGSize(width: startBtnCode.frame.size.width, height: startBtnCode.frame.size.height)
                ansSprite.position = CGPoint(x: posCodAt.x, y: posCodAt.y - ansSprite.frame.size.height)
                ansSprite.name = "CODE_SPRITE"
                self.addChild(ansSprite)
                
                posCodAt.y -= startBtnCode.frame.size.height
            }
        }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        car.position.x += 1
        
        if car.position.x >= 490 {
            car.position.x = -car.frame.size.width
        }
        
    }
}
