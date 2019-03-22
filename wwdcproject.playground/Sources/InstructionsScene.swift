import SpriteKit

var stars = 0

public class InstructionsScene: SKScene {
        
    let FONT_SIZE:CGFloat = 20
    
    var screenWidth:CGFloat = 600
    var screenHeight:CGFloat = 800
    
    var codeBtn = SKSpriteNode()
    var runBtn = SKSpriteNode()
    var goBtn = SKSpriteNode()
    
    var codeAns = [0]
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 0.5137254902, green: 0.9529411765, blue: 0.6901960784, alpha: 1)
        
        screenWidth = self.view!.frame.size.width
        screenHeight = self.view!.frame.size.height
        
        drawBoard()
    }
    
    // MARK: - DRAW BOARD
    public func drawBoard() {
        let paragraphCenter = NSMutableParagraphStyle()
        paragraphCenter.alignment = .center
        paragraphCenter.firstLineHeadIndent = 5.0
        
        /************************** PLAYER **************************/
        let blu = SKShapeNode(circleOfRadius: screenHeight/50)
        blu.fillColor = #colorLiteral(red: 0.1647058824, green: 0.6980392157, blue: 1, alpha: 1)
        blu.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        blu.position = CGPoint(x: screenWidth/3, y: 2*screenHeight/3 - blu.frame.size.height)
        self.addChild(blu)
        
        let strBlu = NSAttributedString(string:"This is Blu!", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_SIZE, weight: .light),
             NSAttributedString.Key.paragraphStyle: paragraphCenter])
        let bluApresentationLbl = SKLabelNode(attributedText: strBlu)
        bluApresentationLbl.horizontalAlignmentMode = .center
        bluApresentationLbl.verticalAlignmentMode = .center
        bluApresentationLbl.position = CGPoint(x: screenWidth/3, y: 2*screenHeight/3)
        self.addChild(bluApresentationLbl)
        
        let strInstructions = NSAttributedString(string:"Select\nthe instructions\nto help Blu!", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_SIZE+CGFloat(3), weight: .regular),
             NSAttributedString.Key.paragraphStyle: paragraphCenter])
        let instructionLbl = SKLabelNode(attributedText: strInstructions)
        instructionLbl.horizontalAlignmentMode = .center
        instructionLbl.verticalAlignmentMode = .center
        instructionLbl.numberOfLines = 0;
        instructionLbl.lineBreakMode = .byWordWrapping
        instructionLbl.position = CGPoint(x: screenWidth/3, y: screenHeight/2 - instructionLbl.frame.size.height/2)
        self.addChild(instructionLbl)
        
        /************************ CODE OPTIONS ************************/
        let line = SKShapeNode(rect: CGRect(x: 0, y: 0, width: screenWidth/1.2, height: 0.5))
        line.fillColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        line.strokeColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        line.position = CGPoint(x: screenWidth/2 - line.frame.size.width/2, y: screenHeight/6)
        self.addChild(line)
        
        let strCode = NSAttributedString(string:"This is the instructions", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_SIZE, weight: .light),
             NSAttributedString.Key.paragraphStyle: paragraphCenter])
        let codeLbl = SKLabelNode(attributedText: strCode)
        codeLbl.horizontalAlignmentMode = .center
        codeLbl.verticalAlignmentMode = .center
        codeLbl.numberOfLines = 0;
        codeLbl.lineBreakMode = .byWordWrapping
        codeLbl.position = CGPoint(x: screenWidth/2 - line.frame.size.width/2 + codeLbl.frame.size.width/2, y: screenHeight/6 + codeLbl.frame.height/2)
        self.addChild(codeLbl)
        
        codeBtn.texture = SKTexture(imageNamed: "codeBtn")
        codeBtn.size = CGSize(width: line.frame.width/6, height: screenHeight/20)
        codeBtn.position = CGPoint(x: line.position.x + line.frame.size.width/2, y: line.position.y - codeBtn.frame.size.height)
        self.addChild(codeBtn)
        
        /************************* CODE IDE *************************/
        let ide = SKShapeNode(rect: CGRect(x: 0, y: 0, width: screenWidth/4, height: screenHeight/2), cornerRadius: 5)
        ide.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.33)
        ide.strokeColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 0)
        ide.position = CGPoint(x: screenWidth/2 + line.frame.size.width/2 - ide.frame.size.width, y: screenHeight/1.8 - ide.frame.size.height/2)
        self.addChild(ide)
        
        let strIde = NSAttributedString(string:"This is your code", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: FONT_SIZE, weight: .light)])
        let ideLbl = SKLabelNode(attributedText: strIde)
        ideLbl.horizontalAlignmentMode = .center
        ideLbl.verticalAlignmentMode = .center
        ideLbl.numberOfLines = 0;
        ideLbl.lineBreakMode = .byWordWrapping
        ideLbl.position = CGPoint(x: ide.position.x + ideLbl.frame.size.width/2, y: ide.position.y + ide.frame.size.height + ideLbl.frame.size.height)
        self.addChild(ideLbl)
        
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
        
        runBtn.texture = SKTexture(imageNamed: "runBtn")
        runBtn.size = CGSize(width: ide.frame.size.width/2, height: ide.frame.size.height/13)
        runBtn.position = CGPoint(x: ide.position.x + runBtn.frame.size.width, y: ide.position.y + runBtn.frame.size.height/1.5)
        self.addChild(runBtn)
        
        /************************* GO CODE *************************/
        goBtn.texture = SKTexture(imageNamed: "goBtn")
        goBtn.size = CGSize(width: line.frame.size.width/5, height: screenHeight/15)
        goBtn.position = CGPoint(x: screenWidth/2, y: screenHeight - screenHeight/10)
        self.addChild(goBtn)

    }
    
    // MARK: - MOVES
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if codeBtn.contains(touchLocation) {
            codeBtnClick()
        }
        else if goBtn.contains(touchLocation) {
            goBtnClick()
        }
        else if runBtn.contains(touchLocation) {
            
        }
    }
    
    // MARK: - ACTIONS
    func runBtnClick() {
        
    }
    
    func codeBtnClick() {
        
    }
    
    func goBtnClick() {
        let sceneMoveTo = FirstLevelScene(size: self.size)
        sceneMoveTo.scaleMode = self.scaleMode
        
        let transition = SKTransition.moveIn(with: .right, duration: 0.8)
        self.scene?.view?.presentScene(sceneMoveTo ,transition: transition)
    }
}
