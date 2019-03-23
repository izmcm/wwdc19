import SpriteKit

public class ThirdLevelScene: SKScene {
    
    let FONT_SIZE:CGFloat = 25
    let UP_ACTION = 1
    let RIGHT_ACTION = 2
    let DOWN_ACTION = 3
    let LEFT_ACTION = 4
    let IF_ACTION = 5
    
    let WALK_SIZE:CGFloat = 120
    let LIMIT_CODE = 4
    
    var screenWidth:CGFloat = 600
    var screenHeight:CGFloat = 550
    
    var blu = SKSpriteNode()
    var carRed = SKSpriteNode()
    var carYellow = SKSpriteNode()
    var need = SKSpriteNode()
    var trafficLightRed = SKSpriteNode()
    var trafficLightGreen = SKSpriteNode()
    
    // BUTTONS
    var runBtn = SKSpriteNode()
    var undoBtn = SKSpriteNode()
    
    // POSITIONS
    var upBtn = SKSpriteNode()
    var rightBtn = SKSpriteNode()
    var downBtn = SKSpriteNode()
    var leftBtn = SKSpriteNode()
    var ifBtn = SKSpriteNode()
    
    // POPUP
    var needLessCode = SKSpriteNode()
    var needWrong = SKSpriteNode()
    var needOutside = SKSpriteNode()
    var needGreen = SKSpriteNode()
    
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
        codeAns.removeAll()
        self.view!.isUserInteractionEnabled = true
        
        let paragraphCenter = NSMutableParagraphStyle()
        paragraphCenter.alignment = .center
        paragraphCenter.firstLineHeadIndent = 5.0
        
        let background = SKSpriteNode(imageNamed: "backScene03")
        background.size = CGSize(width: screenWidth, height: screenHeight)
        background.position = CGPoint(x: background.frame.size.width/2, y: background.frame.size.height/2)
        self.addChild(background)
        
        blu = SKSpriteNode(imageNamed: "BLU")
        blu.size = CGSize(width: screenWidth/35, height: 1.3*screenWidth/35)
        blu.position = CGPoint(x: screenWidth/4, y: 3*screenHeight/4 + blu.frame.size.height/2)
        blu.zPosition = 1000
        self.addChild(blu)
        
        trafficLightRed = SKSpriteNode(imageNamed: "trafficlightRed")
        trafficLightRed.size = CGSize(width: blu.frame.size.height*0.5, height: blu.frame.size.height*2)
        trafficLightRed.position = CGPoint(x: blu.position.x - blu.frame.size.width*2, y: blu.position.y)
        trafficLightRed.zPosition = 10
        self.addChild(trafficLightRed)
        
        trafficLightGreen = SKSpriteNode(imageNamed: "trafficlightGreen")
        trafficLightGreen.size = trafficLightRed.size
        trafficLightGreen.position = trafficLightRed.position
        trafficLightGreen.zPosition = 10
        self.addChild(trafficLightGreen)
        
        carRed = SKSpriteNode(imageNamed: "carRed")
        carRed.size = CGSize(width: 1.3*blu.frame.size.height, height: blu.frame.size.height)
        carRed.position = CGPoint(x: -carRed.frame.size.width, y: 2*screenHeight/3 + carRed.frame.size.height)
        self.addChild(carRed)
        
        carYellow = SKSpriteNode(imageNamed: "carYellow")
        carYellow.size = CGSize(width: 1.3*blu.frame.size.height, height: blu.frame.size.height)
        carYellow.position = CGPoint(x: -carYellow.frame.size.width*2, y: 2*screenHeight/3)
        self.addChild(carYellow)
        
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
        
        // ACTIONS
        upBtn = SKSpriteNode(imageNamed: "upBtn")
        upBtn.size = CGSize(width: runBtn.frame.size.width, height: runBtn.frame.size.height)
        upBtn.position = CGPoint(x: commentLbl.position.x, y: screenHeight/5 + upBtn.frame.size.height/2)
        self.addChild(upBtn)
        
        downBtn = SKSpriteNode(imageNamed: "downBtn")
        downBtn.size = CGSize(width: runBtn.frame.size.width, height: runBtn.frame.size.height)
        downBtn.position = CGPoint(x: commentLbl.position.x, y: screenHeight/6 - downBtn.frame.size.height*2)
        self.addChild(downBtn)
        
        leftBtn = SKSpriteNode(imageNamed: "leftBtn")
        leftBtn.size = CGSize(width: runBtn.frame.size.width, height: runBtn.frame.size.height)
        leftBtn.position = CGPoint(x: commentLbl.position.x - leftBtn.frame.size.width, y: downBtn.position.y + leftBtn.frame.size.height*1.5)
        self.addChild(leftBtn)
        
        rightBtn = SKSpriteNode(imageNamed: "rightBtn")
        rightBtn.size = CGSize(width: runBtn.frame.size.width, height: runBtn.frame.size.height)
        rightBtn.position = CGPoint(x: commentLbl.position.x + rightBtn.frame.size.width, y: leftBtn.position.y)
        self.addChild(rightBtn)
        
        ifBtn = SKSpriteNode(imageNamed: "ifCarsBtn")
        ifBtn.size = CGSize(width: runBtn.frame.size.width*1.5, height: runBtn.frame.size.height)
        ifBtn.position = CGPoint(x: upBtn.position.x, y: upBtn.position.y + ifBtn.frame.size.height*1.5)
        self.addChild(ifBtn)
        
        // first code position
        posCodeInit = CGPoint(x: commentLbl.position.x, y: commentLbl.position.y - runBtn.frame.size.height/2)
        
        // RED
        needLessCode = SKSpriteNode(imageNamed: "needLessCode")
        needLessCode.size = CGSize(width: screenWidth/2, height: 0.65*screenWidth/2)
        needLessCode.position = CGPoint(x: needLessCode.frame.size.width/2, y: -needLessCode.frame.size.height/2)
        needLessCode.zPosition = 99999
        self.addChild(needLessCode)
        
        need = SKSpriteNode(imageNamed: "need03")
        need.size = CGSize(width: screenWidth/2, height: 0.65*screenWidth/2)
        need.position = CGPoint(x: need.frame.size.width/2, y: need.frame.size.height/2)
        need.zPosition = 99999
        self.addChild(need)
        
        needWrong = SKSpriteNode(imageNamed: "needWrong")
        needWrong.size = CGSize(width: screenWidth/2, height: 0.65*screenWidth/2)
        needWrong.position = CGPoint(x: needWrong.frame.size.width/2, y: -needWrong.frame.size.height/2)
        needWrong.zPosition = 99999
        self.addChild(needWrong)
        
        needOutside = SKSpriteNode(imageNamed: "needOutsideCrosswalk")
        needOutside.size = CGSize(width: screenWidth/2, height: 0.65*screenWidth/2)
        needOutside.position = CGPoint(x: needOutside.frame.size.width/2, y: -needOutside.frame.size.height/2)
        needOutside.zPosition = 99999
        self.addChild(needOutside)
        
        needGreen = SKSpriteNode(imageNamed: "needTrafficLightGreen")
        needGreen.size = CGSize(width: screenWidth/2, height: 0.65*screenWidth/2)
        needGreen.position = CGPoint(x: needGreen.frame.size.width/2, y: -needGreen.frame.size.height/2)
        needGreen.zPosition = 99999
        self.addChild(needGreen)
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
        
        if needLessCode.position.y >= 0 {
            let action = SKAction.moveBy(x: 0, y: -needWrong.frame.size.height, duration: 1)
            needWrong.run(action)
        }
        
        if upBtn.contains(touchLocation) {
            upBtnClick()
        }
        else if rightBtn.contains(touchLocation) {
            rightBtnClick()
        }
        else if downBtn.contains(touchLocation) {
            downBtnClick()
        }
        else if leftBtn.contains(touchLocation) {
            leftBtnClick()
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
        else if ifBtn.contains(touchLocation) {
            ifBtnClick()
        }
    }
    
    // MARK: - ACTIONS
    func runBtnClick() {
        if codeAns.count <= LIMIT_CODE {
            self.view!.isUserInteractionEnabled = false

            var moves = [SKAction()]
            var hideAction = SKAction()
            
            for i in codeAns {
                if i == RIGHT_ACTION {
                    moves.append(SKAction.moveBy(x: WALK_SIZE, y: 0, duration: 1))
                }
                else if i == UP_ACTION {
                    moves.append(SKAction.moveBy(x: 0, y: WALK_SIZE, duration: 1))
                }
                else if i == DOWN_ACTION {
                    moves.append(SKAction.moveBy(x: 0, y: -WALK_SIZE, duration: 1))
                }
                else if i == LEFT_ACTION {
                    moves.append(SKAction.moveBy(x: -WALK_SIZE, y: 0, duration: 1))
                }
                else if i == IF_ACTION {
                    hideAction = SKAction.hide()
                }
            }
            
            if !codeAns.contains(IF_ACTION) && codeAns.contains(DOWN_ACTION){
                let action = SKAction.moveBy(x: 0, y: self.needGreen.frame.size.height, duration: 1)
                self.needGreen.run(action)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    self.removeAllChildren()
                    self.drawBoard()
                }
            }
            else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.trafficLightGreen.run(hideAction)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let sequence = SKAction.sequence(moves)
                        self.blu.run(sequence)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                            if self.codeAns == [self.IF_ACTION, self.DOWN_ACTION, self.RIGHT_ACTION, self.RIGHT_ACTION] {
                                stars += 1
                                self.goBtnClick()
                            }
                            else {
                                let action = SKAction.moveBy(x: 0, y: self.needWrong.frame.size.height, duration: 1)
                                self.needWrong.run(action)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    self.removeAllChildren()
                                    self.drawBoard()
                                }
                            }
                        }
                    }
                }
            }
        }
        else {
            let action = SKAction.moveBy(x: 0, y: needLessCode.frame.size.height, duration: 1)
            needLessCode.run(action)
        }
    }
    
    func upBtnClick() {
        if codeAns.count < 8 {
            codeAns.append(UP_ACTION)
            drawCode()
        }
    }
    
    func rightBtnClick() {
        if codeAns.count < 8 {
            codeAns.append(RIGHT_ACTION)
            drawCode()
        }
    }
    
    func downBtnClick() {
        if codeAns.count < 8 {
            codeAns.append(DOWN_ACTION)
            drawCode()
        }
    }
    
    func leftBtnClick() {
        if codeAns.count < 8 {
            codeAns.append(LEFT_ACTION)
            drawCode()
        }
    }
    
    func ifBtnClick() {
        if codeAns.count < 8 {
            codeAns.append(IF_ACTION)
            drawCode()
        }
    }
    
    func goBtnClick() {
        let sceneMoveTo = FinalScene(size: self.size)
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
            if i == UP_ACTION {
                let ansSprite = SKSpriteNode(imageNamed: "upBtn")
                ansSprite.size = CGSize(width: leftBtn.frame.size.width, height: leftBtn.frame.size.height)
                ansSprite.position = CGPoint(x: posCodAt.x, y: posCodAt.y - ansSprite.frame.size.height)
                ansSprite.name = "CODE_SPRITE"
                self.addChild(ansSprite)
                
                posCodAt.y -= leftBtn.frame.size.height
            }
            else if i == RIGHT_ACTION {
                let ansSprite = SKSpriteNode(imageNamed: "rightBtn")
                ansSprite.size = CGSize(width: leftBtn.frame.size.width, height: leftBtn.frame.size.height)
                ansSprite.position = CGPoint(x: posCodAt.x, y: posCodAt.y - ansSprite.frame.size.height)
                ansSprite.name = "CODE_SPRITE"
                self.addChild(ansSprite)
                
                posCodAt.y -= leftBtn.frame.size.height
            }
            else if i == DOWN_ACTION {
                let ansSprite = SKSpriteNode(imageNamed: "downBtn")
                ansSprite.size = CGSize(width: leftBtn.frame.size.width, height: leftBtn.frame.size.height)
                ansSprite.position = CGPoint(x: posCodAt.x, y: posCodAt.y - ansSprite.frame.size.height)
                ansSprite.name = "CODE_SPRITE"
                self.addChild(ansSprite)
                
                posCodAt.y -= leftBtn.frame.size.height
            }
            else if i == LEFT_ACTION {
                let ansSprite = SKSpriteNode(imageNamed: "leftBtn")
                ansSprite.size = CGSize(width: leftBtn.frame.size.width, height: leftBtn.frame.size.height)
                ansSprite.position = CGPoint(x: posCodAt.x, y: posCodAt.y - ansSprite.frame.size.height)
                ansSprite.name = "CODE_SPRITE"
                self.addChild(ansSprite)
                
                posCodAt.y -= leftBtn.frame.size.height
            }
            else if i == IF_ACTION {
                let ansSprite = SKSpriteNode(imageNamed: "ifCarsBtn")
                ansSprite.size = CGSize(width: 3.5*upBtn.frame.size.height, height: upBtn.frame.size.height)
                ansSprite.position = CGPoint(x: posCodAt.x, y: posCodAt.y - ansSprite.frame.size.height)
                ansSprite.name = "CODE_SPRITE"
                self.addChild(ansSprite)
                
                posCodAt.y -= leftBtn.frame.size.height
            }
        }
    }
}
