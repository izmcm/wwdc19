import SpriteKit

public class ThirdLevelScene: SKScene {
    
    let FONT_SIZE:CGFloat = 20
    let UP_ACTION = 1
    let RIGHT_ACTION = 2
    let DOWN_ACTION = 3
    let LEFT_ACTION = 4
    let IF_ACTION = 5
    
    let LIMIT_CODE = 3
    
    var screenWidth:CGFloat = 600
    var screenHeight:CGFloat = 550
    
    var blu = SKShapeNode()
    var trafficRed = SKSpriteNode()
    var trafficGreen = SKSpriteNode()
    
    // BUTTONS
    var upBtn = SKSpriteNode()
    var rightBtn = SKSpriteNode()
    var downBtn = SKSpriteNode()
    var leftBtn = SKSpriteNode()
    var ifBtn = SKSpriteNode()
    var runBtn = SKSpriteNode()
    var undoBtn = SKSpriteNode()
    var goBtn = SKSpriteNode()
    
    // POPUPs
    var limitPopUp = SKSpriteNode()
    var wrongPopUp = SKSpriteNode()
    
    // ANSWER
    var codeAns:[Int] = []
    var posCodAt = CGPoint(x: 0, y: 0)
    var posCodeInit = CGPoint(x: 0, y: 0)
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 0.5137254902, green: 0.9529411765, blue: 0.6901960784, alpha: 1)
        
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
        
        /************************** SCORE **************************/
        let strScore = NSAttributedString(string:"Score: \(stars)", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_SIZE, weight: .medium),
             NSAttributedString.Key.paragraphStyle: paragraphCenter])
        let scoreLbl = SKLabelNode(attributedText: strScore)
        scoreLbl.horizontalAlignmentMode = .center
        scoreLbl.verticalAlignmentMode = .center
        scoreLbl.position = CGPoint(x: scoreLbl.frame.size.width, y: screenHeight - scoreLbl.frame.size.height*2)
        self.addChild(scoreLbl)
        
        let starSprite = SKSpriteNode(imageNamed: "levels")
        starSprite.size = CGSize(width: scoreLbl.frame.size.height, height: scoreLbl.frame.size.height)
        starSprite.position = CGPoint(x: scoreLbl.position.x + scoreLbl.frame.size.width/2 + starSprite.frame.size.width/2, y: scoreLbl.position.y)
        self.addChild(starSprite)
        
        /************************** PLAYER **************************/
        let cross = SKSpriteNode(imageNamed: "cross")
        cross.size = CGSize(width: screenWidth/4, height: 2.5*screenWidth/3)
        cross.position = CGPoint(x: screenWidth/4, y: screenHeight/2)
        cross.zRotation = -(.pi/2)
        self.addChild(cross)
        
        let school = SKSpriteNode(imageNamed: "school")
        school.size = CGSize(width: 1.2*screenWidth/4, height: screenWidth/4)
        school.position = CGPoint(x: cross.position.x - 0.05*cross.frame.size.width, y: screenHeight - screenHeight/10 - 0.7*school.frame.size.height)
        self.addChild(school)
        
        blu = SKShapeNode(circleOfRadius: screenHeight/70)
        blu.fillColor = #colorLiteral(red: 0.1647058824, green: 0.6980392157, blue: 1, alpha: 1)
        blu.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        blu.position = CGPoint(x: school.position.x, y: school.position.y - 0.8*school.frame.size.height)
        blu.zPosition = 1000
        self.addChild(blu)
        
        trafficGreen = SKSpriteNode(imageNamed: "trafficlightGREEN")
        trafficGreen.size = CGSize(width: screenWidth/10, height: 2.2*screenWidth/10)
        trafficGreen.position = CGPoint(x: school.position.x + school.frame.size.width, y: school.position.y)
        self.addChild(trafficGreen)
        
        trafficRed = SKSpriteNode(imageNamed: "trafficlightRED")
        trafficRed.size = CGSize(width: screenWidth/10, height: 2.2*screenWidth/10)
        trafficRed.position = CGPoint(x: school.position.x + school.frame.size.width, y: school.position.y)
        self.addChild(trafficRed)
        
        /************************** INSTRUCTIONS **************************/
        let strBlu = NSAttributedString(string:"Blu needs to go to home", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_SIZE, weight: .medium),
             NSAttributedString.Key.paragraphStyle: paragraphCenter])
        let bluApresentationLbl = SKLabelNode(attributedText: strBlu)
        bluApresentationLbl.horizontalAlignmentMode = .center
        bluApresentationLbl.verticalAlignmentMode = .center
        bluApresentationLbl.position = CGPoint(x: screenWidth/2, y: screenHeight - screenHeight/10)
        self.addChild(bluApresentationLbl)
        
        /************************ CODE OPTIONS ************************/
        let line = SKShapeNode(rect: CGRect(x: 0, y: 0, width: screenWidth/1.2, height: 0.5))
        line.fillColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        line.strokeColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        line.position = CGPoint(x: screenWidth/2 - line.frame.size.width/2, y: screenHeight/6)
        self.addChild(line)
        
        upBtn.texture = SKTexture(imageNamed: "upBtn")
        upBtn.size = CGSize(width: 2.25*screenHeight/20, height: screenHeight/20)
        upBtn.position = CGPoint(x: screenWidth/2 + upBtn.frame.width*1.4, y: line.position.y - upBtn.frame.size.height)
        self.addChild(upBtn)
        
        rightBtn.texture = SKTexture(imageNamed: "rightBtn")
        rightBtn.size = CGSize(width: upBtn.frame.size.width, height: upBtn.frame.size.height)
        rightBtn.position = CGPoint(x: upBtn.position.x - upBtn.frame.size.width - upBtn.frame.size.width/6, y: line.position.y - rightBtn.frame.size.height)
        self.addChild(rightBtn)
        
        downBtn.texture = SKTexture(imageNamed: "downBtn")
        downBtn.size = CGSize(width: upBtn.frame.size.width, height: upBtn.frame.size.height)
        downBtn.position = CGPoint(x: rightBtn.position.x - rightBtn.frame.size.width - rightBtn.frame.size.width/6, y: line.position.y - downBtn.frame.size.height)
        self.addChild(downBtn)
        
        leftBtn.texture = SKTexture(imageNamed: "leftBtn")
        leftBtn.size = CGSize(width: upBtn.frame.size.width, height: upBtn.frame.size.height)
        leftBtn.position = CGPoint(x: upBtn.position.x + upBtn.frame.size.width + upBtn.frame.size.width/6, y: line.position.y - leftBtn.frame.size.height)
        self.addChild(leftBtn)
        
        ifBtn.texture = SKTexture(imageNamed: "ifCarsBtn")
        ifBtn.size = CGSize(width: 3.5*upBtn.frame.size.height, height: upBtn.frame.size.height)
        ifBtn.position = CGPoint(x: downBtn.position.x - ifBtn.frame.size.width/2 - downBtn.frame.size.width/2 - upBtn.frame.size.width/6, y: line.position.y - ifBtn.frame.size.height)
        self.addChild(ifBtn)
        
        /************************* CODE IDE *************************/
        let ide = SKShapeNode(rect: CGRect(x: 0, y: 0, width: screenWidth/4, height: screenHeight/2), cornerRadius: 5)
        ide.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.33)
        ide.strokeColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 0)
        ide.position = CGPoint(x: screenWidth/2 + line.frame.size.width/2 - ide.frame.size.width, y: screenHeight/1.8 - ide.frame.size.height/2)
        self.addChild(ide)
        
        let strComment = NSAttributedString(string:"// code!", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3529411765, green: 0.3529411765, blue: 0.3529411765, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_SIZE, weight: .light),
             NSAttributedString.Key.paragraphStyle: paragraphCenter])
        let commentLbl = SKLabelNode(attributedText: strComment)
        commentLbl.horizontalAlignmentMode = .center
        commentLbl.verticalAlignmentMode = .center
        commentLbl.numberOfLines = 0;
        commentLbl.lineBreakMode = .byWordWrapping
        commentLbl.position = CGPoint(x: ide.position.x + ide.frame.size.width/2, y: ide.position.y + ide.frame.size.height - commentLbl.frame.size.height/2)
        self.addChild(commentLbl)
        
        undoBtn.texture = SKTexture(imageNamed: "undoBtn")
        undoBtn.size = CGSize(width: ide.frame.size.height/13, height: ide.frame.size.height/13)
        undoBtn.position = CGPoint(x: ide.position.x + undoBtn.frame.size.width, y: ide.position.y + undoBtn.frame.size.height/1.5)
        self.addChild(undoBtn)
        
        runBtn.texture = SKTexture(imageNamed: "runBtn")
        runBtn.size = CGSize(width: ide.frame.size.width/2, height: ide.frame.size.height/13)
        runBtn.position = CGPoint(x: undoBtn.position.x + undoBtn.frame.size.width + runBtn.frame.size.width/2, y: ide.position.y + runBtn.frame.size.height/1.5)
        self.addChild(runBtn)
        
        limitPopUp.texture = SKTexture(imageNamed: "limitPopUp")
        limitPopUp.size = CGSize(width: screenWidth/3.5, height: screenWidth/3.5)
        limitPopUp.position = CGPoint(x: screenWidth - line.position.x - limitPopUp.frame.size.width/2, y: line.position.y)
        limitPopUp.isHidden = true
        self.addChild(limitPopUp)
        
        wrongPopUp.texture = SKTexture(imageNamed: "wrongPopUp")
        wrongPopUp.size = CGSize(width: screenWidth/3.5, height: screenWidth/3.5)
        wrongPopUp.position = CGPoint(x: screenWidth - line.position.x - wrongPopUp.frame.size.width/2, y: line.position.y)
        wrongPopUp.isHidden = true
        self.addChild(wrongPopUp)
        
        // CODE POSITION
        posCodeInit = CGPoint(x: commentLbl.position.x, y: commentLbl.position.y)
    }
    
    // MARK: - MOVES
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if limitPopUp.isHidden == false {
            limitPopUp.isHidden = true
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
                    moves.append(SKAction.moveBy(x: (1.2*screenWidth/4)/2, y: 0, duration: 1))
                }
                else if i == UP_ACTION {
                    moves.append(SKAction.moveBy(x: 0, y: screenHeight/4, duration: 1))
                }
                else if i == DOWN_ACTION {
                    moves.append(SKAction.moveBy(x: 0, y: -screenHeight/4, duration: 1))
                }
                else if i == LEFT_ACTION {
                    moves.append(SKAction.moveBy(x: -(1.2*screenWidth/4)/2, y: 0, duration: 1))
                }
                else if i == IF_ACTION {
                    hideAction = SKAction.hide()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.trafficRed.run(hideAction)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let sequence = SKAction.sequence(moves)
                    self.blu.run(sequence)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        if self.codeAns == [self.IF_ACTION, self.DOWN_ACTION, self.RIGHT_ACTION] {
                            stars += 1
                            self.goBtnClick()
                        }
                        else {
                            self.wrongPopUp.isHidden = false
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                self.removeAllChildren()
                                self.drawBoard()
                            }
                        }
                    }
                }
            }
            
        }
        else {
            limitPopUp.isHidden = false
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
    
    // MARK: - UPDATE
    public override func update(_ currentTime: TimeInterval) {
        
    }
}
