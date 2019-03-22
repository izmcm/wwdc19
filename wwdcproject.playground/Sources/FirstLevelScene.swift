import SpriteKit

public class FirstLevelScene: SKScene {
    
    let FONT_SIZE:CGFloat = 20
    let WALK_ACTION = 1
    let LIMIT_CODE = 1
    
    var screenWidth:CGFloat = 600
    var screenHeight:CGFloat = 800
    
    var blu = SKShapeNode()
    
    // BUTTONS
    var codeBtn = SKSpriteNode()
    var runBtn = SKSpriteNode()
    var undoBtn = SKSpriteNode()
    var goBtn = SKSpriteNode()
    
    // POPUP
    var popUp = SKSpriteNode()
    
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
        blu = SKShapeNode(circleOfRadius: screenHeight/70)
        blu.fillColor = #colorLiteral(red: 0.1647058824, green: 0.6980392157, blue: 1, alpha: 1)
        blu.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        blu.position = CGPoint(x: screenWidth/5, y: screenHeight/2)
        blu.zPosition = 1000
        self.addChild(blu)
        
        let cross = SKSpriteNode(imageNamed: "cross")
        cross.size = CGSize(width: screenWidth/4, height: 2.5*screenWidth/3)
        cross.position = CGPoint(x: blu.position.x + cross.frame.size.width, y: blu.position.y + blu.frame.size.height)
        self.addChild(cross)
        
        let car = SKSpriteNode(imageNamed: "car")
        car.size = CGSize(width: cross.frame.size.width/4, height: 1.3*cross.frame.size.width/4)
        car.position = CGPoint(x: cross.position.x, y: cross.position.y - cross.frame.size.height/3)
        self.addChild(car)
        
        /************************** INSTRUCTIONS **************************/
        let strBlu = NSAttributedString(string:"Blu needs to cross the street", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_SIZE, weight: .medium),
             NSAttributedString.Key.paragraphStyle: paragraphCenter])
        let bluApresentationLbl = SKLabelNode(attributedText: strBlu)
        bluApresentationLbl.horizontalAlignmentMode = .center
        bluApresentationLbl.verticalAlignmentMode = .center
        bluApresentationLbl.position = CGPoint(x: screenWidth/2, y: screenHeight - screenHeight/10)
        self.addChild(bluApresentationLbl)
        
        let strCars = NSAttributedString(string:"the cars\nare stopped", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_SIZE, weight: .light),
             NSAttributedString.Key.paragraphStyle: paragraphCenter])
        let carsApresentationLbl = SKLabelNode(attributedText: strCars)
        carsApresentationLbl.horizontalAlignmentMode = .center
        carsApresentationLbl.verticalAlignmentMode = .center
        carsApresentationLbl.numberOfLines = 0;
        carsApresentationLbl.lineBreakMode = .byWordWrapping
        carsApresentationLbl.position = CGPoint(x: screenWidth/5, y: screenHeight/1.3 + carsApresentationLbl.frame.size.height/2)
        self.addChild(carsApresentationLbl)
        
        let traffic0 = SKSpriteNode(imageNamed: "trafficlightRED")
        traffic0.size = CGSize(width: carsApresentationLbl.frame.size.width/3, height: 2.2*carsApresentationLbl.frame.size.width/3)
        traffic0.position = CGPoint(x: carsApresentationLbl.position.x, y: carsApresentationLbl.position.y - traffic0.frame.size.height/2 - carsApresentationLbl.frame.size.height/2)
        self.addChild(traffic0)
        
        let strInstructions = NSAttributedString(string:"it's safe!", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_SIZE, weight: .regular),
             NSAttributedString.Key.paragraphStyle: paragraphCenter])
        let instructionLbl = SKLabelNode(attributedText: strInstructions)
        instructionLbl.horizontalAlignmentMode = .center
        instructionLbl.verticalAlignmentMode = .center
        instructionLbl.numberOfLines = 0;
        instructionLbl.lineBreakMode = .byWordWrapping
        instructionLbl.position = CGPoint(x: traffic0.position.x, y: traffic0.position.y - traffic0.frame.size.height/2 - instructionLbl.frame.size.height/2)
        self.addChild(instructionLbl)
        
        /************************ CODE OPTIONS ************************/
        let line = SKShapeNode(rect: CGRect(x: 0, y: 0, width: screenWidth/1.2, height: 0.5))
        line.fillColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        line.strokeColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        line.position = CGPoint(x: screenWidth/2 - line.frame.size.width/2, y: screenHeight/6)
        self.addChild(line)
        
        codeBtn.texture = SKTexture(imageNamed: "walkBtn")
        codeBtn.size = CGSize(width: 2.25*screenHeight/20, height: screenHeight/20)
        codeBtn.position = CGPoint(x: line.position.x + line.frame.size.width/2, y: line.position.y - codeBtn.frame.size.height)
        self.addChild(codeBtn)
        
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
        
        popUp.texture = SKTexture(imageNamed: "limitPopUp")
        popUp.size = CGSize(width: screenWidth/3.5, height: screenWidth/3.5)
        popUp.position = CGPoint(x: screenWidth - line.position.x - popUp.frame.size.width/2, y: line.position.y)
        popUp.isHidden = true
        self.addChild(popUp)
        
        // CODE POSITION
        posCodeInit = CGPoint(x: commentLbl.position.x, y: commentLbl.position.y)
    }
    
    // MARK: - MOVES
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if popUp.isHidden == false {
            popUp.isHidden = true
        }
        
        if codeBtn.contains(touchLocation) {
            codeBtnClick()
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
                    let moveAction = SKAction.moveBy(x: screenWidth/3 + blu.frame.size.width*2, y: 0, duration: 1)
                    blu.run(moveAction)
                    
                    stars += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.goBtnClick()
                    }
                }
            }
        }
        else {
            popUp.isHidden = false
        }
    }
    
    func codeBtnClick() {
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
                ansSprite.size = CGSize(width: codeBtn.frame.size.width, height: codeBtn.frame.size.height)
                ansSprite.position = CGPoint(x: posCodAt.x, y: posCodAt.y - ansSprite.frame.size.height)
                ansSprite.name = "CODE_SPRITE"
                self.addChild(ansSprite)
                
                posCodAt.y -= codeBtn.frame.size.height
            }
        }
    }
}
