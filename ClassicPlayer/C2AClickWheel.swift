//
//  C2AClickWheel.swift
//  ClickWheel
//
//  Created by Dirk Gerretz on 16/03/15.
//  Copyright (c) 2015 [code2app];. All rights reserved.
//

import UIKit
import AudioToolbox

@IBDesignable class C2AClickWheel: UIButton {

    // MARK: Properties
    let π = CGFloat(Double.pi)

    
    //@IBInspectable changes should be applied in the Attributes Inspector in Interface Builer

    // Wheel Colors
    @IBInspectable var wheelColor: UIColor = UIColor.lightGray
    @IBInspectable var buttonColor: UIColor = UIColor.darkGray

    // Optional border colors (default to none/transparent)
    @IBInspectable var wheelBorderColor: UIColor = UIColor.clear
    @IBInspectable var buttonBorderColor: UIColor = UIColor.clear

    // Switch feedback sound on/off. False is the default for debugging only
    @IBInspectable var feedbackSound: Bool = false

    // Define the thickness of the arc.
    @IBInspectable var arcWidth: CGFloat = 50

    // will be set at dragging and reflecting the angle in the clickWheel
    // an angle of 0° being at the 9 o'clock position of the wheel like in
    // a unitcircle. Also, in a unitcirlce the angle increases going counte-
    // clockwise. Therefore a decreaseing angle will increase the counter
    // so dragging feel right to the user.
    
    var angle: Int = 0 {
        didSet{
            
            if feedbackSound {
                // play click sound only every other time
                if angle % CLICKWHEEL_SCROLL_MOD_VALUE == 0 {
                    playClickSound()
                }

            }
        }
    }

    override var frame: CGRect {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // the value that will be eventually used
    var counter: Int = 0
    
    // this gets set in lyoutSubview()
    var centerButton: UIButton?
    
    // sound properties
    var soundURL: URL?
    var soundID:SystemSoundID = 0

    // MARK: Lifecycle
    
    override func layoutSubviews() {
    /*************************************************************************************
     Why is all layout work done here rathen than in awakeFromNib()?
        
     The main reason is that I wanted to properly support Auto Layout/Auto Size Classes.
     Basically I'm creating a button programmatically on top of a button that got
     created in Interface Builder. To correctly calculate size and position of the 
     top (or center) button the exact size and position of its host (or wheel) button
     is required. When Auto Layout/Auto Size Classes are used it is here where we get
     proper values of the actual device/view. AwakeFromNib() will alway give you the
     defaults from interface builder regardless of the actual device used.
    *************************************************************************************/
        
        // as layoutSubView may get called multiple times check if button is
        // nil before instantiating
        if centerButton == nil {

            // sign up for orientation change notification
            NotificationCenter.default.addObserver(self, selector: #selector(C2AClickWheel.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
            // add circular button to the center of the clickwheel
            
            // instantiate a centerButton
            // calculate the size of the center button from the size of the wheel button
            centerButton = UIButton(frame: calculateButtonFrame())
            
            // set centerButton properties
            centerButton!.backgroundColor = buttonColor
            
            // Button title
            centerButton!.setTitle(self.titleLabel?.text, for: UIControlState())
            centerButton!.titleLabel!.font =  self.titleLabel?.font
            centerButton!.setTitleColor(self.titleColor(for: UIControlState()), for: UIControlState())
            centerButton!.addTarget(nil, action: Selector(("centerClicked:")), for: .touchUpInside)
            
            // put button on screen. You can't put a button on top of another button so, the
            // center button is also added to the main view
            superview?.addSubview(centerButton!)
            
            // prepare sound playback
            prepareSound()
        }
    }

    override func draw(_ rect: CGRect) {

        //Define the center point of the view where you’ll rotate the arc around.
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)

        // Draw the outer arc

        // Calculate the radius based on the max dimension of the view.
        // max returns the greater of any x and y.
        var radius: CGFloat = (max(bounds.width, bounds.height)/2)

        // Define the start and end angles for the arc as radians.
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * π

        // Create a path based on the center point, radius, and angles you just defined.
        var path = UIBezierPath(arcCenter: center,
            radius: (radius - arcWidth/2) - 2, // -2 to make room for drop shadows
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)

        // these var's are used for both inner and outer ClickWheel shadows
        //let ctx = UIGraphicsGetCurrentContext()
        //let shadowOutside = UIColor.darkGray
        //let shadowInside = UIColor.black
        //let shadowOffset = CGSize(width: 0.0, height: 0.3)   //(3.1, 3.1)
        //let shadowBlurRadius: CGFloat = 5.0

        // add dropshadow to ClickWheel
        //ctx?.setShadow(offset: shadowOffset, blur: shadowBlurRadius,  color: (shadowOutside as UIColor).cgColor)

        // Set the line width and color before finally stroking the path.
        path.lineWidth = arcWidth
        wheelColor.setStroke()
        path.stroke()

        // Optional border for outer wheel
        if wheelBorderColor != UIColor.clear {
            let borderPath = UIBezierPath(arcCenter: center,
                                          radius: (radius) - 2, // stroke along the outside edge
                                          startAngle: startAngle,
                                          endAngle: endAngle,
                                          clockwise: true)
            borderPath.lineWidth = 4.0
            wheelBorderColor.setStroke()
            borderPath.stroke()

//            let innerBorderPath = UIBezierPath(arcCenter: center,
//                                               radius: (radius - arcWidth/2), // stroke along the inside edge
//                                               startAngle: startAngle,
//                                               endAngle: endAngle,
//                                               clockwise: true)
//            innerBorderPath.lineWidth = 1.0
//            wheelBorderColor.setStroke()
//            innerBorderPath.stroke()
        }

        // draw innner circle

        // calculate radius for inner circle
        radius = radius - arcWidth

        // Create a path based on the center point, radius, and angles you just defined.
        path = UIBezierPath(arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)

        // add dropshadow to center button
        
        //ctx?.setShadow(offset: shadowOffset, blur: shadowBlurRadius,  color: (shadowInside as UIColor).cgColor)

        // set color for inner circle and fill path
        buttonColor.setFill()
        path.fill()

        // Optional border for center button
        if buttonBorderColor != UIColor.clear {
            let innerCircleBorder = UIBezierPath(arcCenter: center,
                                                 radius: radius,
                                                 startAngle: startAngle,
                                                 endAngle: endAngle,
                                                 clockwise: true)
            innerCircleBorder.lineWidth = 3.0
            buttonBorderColor.setStroke()
            innerCircleBorder.stroke()
        }
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let lastPoint = touch.location(in: self)

        let centerPoint:CGPoint  = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2);

        //Calculate the direction from a center point and a arbitrary position.
        let currentAngle:Double = AngleFromNorth(centerPoint, p2: lastPoint, flipped: false);
        let angleInt = Int(floor(currentAngle))

        // only update upon new value for less fuzzy results
        if angleInt != angle {
            //Store the new angle
            angle = angleInt // Int(360 - angleInt)

            //Console out new value
            //print("Dragging: \(angle)°")
            
            // send noctifications other other coan register for
            sendActions(for: .valueChanged)
        }

        return true
    }

    // Apple Sourcecode Example
    // Calculate the direction in degrees from a center point to an arbitrary position.
    func AngleFromNorth(_ p1:CGPoint , p2:CGPoint , flipped:Bool) -> Double {
        var v:CGPoint  = CGPoint(x: p2.x - p1.x, y: p2.y - p1.y)
        let vmag:CGFloat = Square(Square(v.x) + Square(v.y))
        var result:Double = 0.0
        v.x /= vmag;
        v.y /= vmag;
        let radians = Double(atan2(v.y,v.x))
        result = RadiansToDegrees(radians)
        return (result >= 0  ? result : result + 360.0);
    }

    @objc func orientationChanged() {
        // re-calculate center button frame when screen roteated
        if let button = centerButton {
            button.frame = calculateButtonFrame()
        }
    }

    // MARK: Converters
    func DegreesToRadians (_ value:Double) -> Double {
        return value * Double.pi / 180.0
    }

    func RadiansToDegrees (_ value:Double) -> Double {
        return value * 180.0 / Double.pi
    }

    func Square (_ value:CGFloat) -> CGFloat {
        return value * value
    }

    func calculateButtonFrame() ->CGRect{

        let buttonWidth = calculateCenterButtonSize(self.frame.width, arcWidth: self.arcWidth)

        let positionX = self.center.x - (buttonWidth / 2)
        let positionY = self.center.y - (buttonWidth / 2)
        
        let newFrame = CGRect(x: positionX, y: positionY, width: buttonWidth, height: buttonWidth)

        return newFrame
    }

    func calculateCenterButtonSize(_ width: CGFloat, arcWidth: CGFloat) -> CGFloat {
        // at this point it is already clear that both width and heights are equal
        // This was checked when the host view was pulled out in Interface Builder

        // this calcualtes the max diagonal for the square inside the ClickWheel
        let diagonal = (width - (arcWidth * 2)) * 1.0

        // calculate square side length using Pythagoras' law
        return sqrt((pow(diagonal, 2.0) / 2))
    }
    
    //MARK: Sound
    func prepareSound() {
        let filePath = Bundle.main.path(forResource: "Click4", ofType: "mp3")

        if let fPath = filePath {
            soundURL = URL(fileURLWithPath: fPath)
        }
    }

    func playClickSound(){
        
        let canPlaySound = UserDefaults.standard.bool(forKey: "soundEffects")
        
        if (canPlaySound) {
            AudioServicesCreateSystemSoundID(soundURL! as CFURL, &soundID)
            AudioServicesPlaySystemSound(soundID)
        }
        
        
    }

}

