import SpriteKit
import Foundation

public class FirstScene: SKScene {
    
    private var spinnyNode : SKShapeNode?
    
    
    var screenWidth:CGFloat = 600
    var screenHeight:CGFloat = 550
    
    var widthSquare:CGFloat = 50
    var heightSquare:CGFloat = 50
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 0.5137254902, green: 0.9529411765, blue: 0.6901960784, alpha: 1)
        
        screenWidth = self.view!.frame.size.width
        screenHeight = self.view!.frame.size.height
        
        drawBoard()
    }
    
    
    override public func update(_ currentTime: TimeInterval) {
    }
    
    // MARK: - DRAW BOARD
    public func drawBoard() {
        let blu = SKShapeNode(circleOfRadius: screenHeight/50)
        blu.fillColor = #colorLiteral(red: 0.1647058824, green: 0.6980392157, blue: 1, alpha: 1)
        blu.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        blu.position = CGPoint(x: screenWidth/3, y: 2*screenHeight/3 - blu.frame.size.height)
        self.addChild(blu)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.firstLineHeadIndent = 5.0
        
        let strBlu = NSAttributedString(string:"Este é Blu", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .light),
             NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let bluApresentationLbl = SKLabelNode(attributedText: strBlu)
        bluApresentationLbl.horizontalAlignmentMode = .center
        bluApresentationLbl.verticalAlignmentMode = .center
        bluApresentationLbl.position = CGPoint(x: screenWidth/3, y: 2*screenHeight/3)
        self.addChild(bluApresentationLbl)
        
        let strInstructions = NSAttributedString(string:"Selecione as instruções\npara levar Blu ao seu\ndestino", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .light),
             NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let instructionLbl = SKLabelNode(attributedText: strInstructions)
        instructionLbl.horizontalAlignmentMode = .center
        instructionLbl.verticalAlignmentMode = .center
        instructionLbl.numberOfLines = 0;
        instructionLbl.lineBreakMode = .byWordWrapping
        instructionLbl.position = CGPoint(x: screenWidth/3, y: 2*screenHeight/3 - instructionLbl.frame.size.height)
        self.addChild(instructionLbl)
        
        let line = SKShapeNode(rect: CGRect(x: 0, y: 0, width: screenWidth/1.2, height: 1))
        line.fillColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        line.strokeColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        line.position = CGPoint(x: screenWidth/2 - line.frame.size.width/2, y: screenHeight/3)
        self.addChild(line)
        
    }
}
