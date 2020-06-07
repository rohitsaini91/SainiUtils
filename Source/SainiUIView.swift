//
//  Extension.swift
//  SainiExtensions
//
//  Created by Rohit Saini on 11/07/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import UIKit

//MARK: - AIEdge
public enum AIEdge:Int {
    case
    Top,
    Left,
    Bottom,
    Right
}

//MARK:- UIVIEW
extension UIView{
    
    
    //MARK:- HEIGHT / WIDTH
    
    var width:CGFloat {
        return self.frame.size.width
    }
    var height:CGFloat {
        return self.frame.size.height
    }
    var xPos:CGFloat {
        return self.frame.origin.x
    }
    var yPos:CGFloat {
        return self.frame.origin.y
    }
    
    //responsible for rotating and stop the view animation
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    //MARK:- sainiCircle
    public func sainiCircle() {
        if self.layer.frame.height != self.layer.frame.width {
            assertionFailure("Height and Width of any view should be same in order to make it perfaect circle...")
            return
        }
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.layer.masksToBounds = true
    }//1
    
    //MARK:- sainiBlur
    public func sainiBlur(style: UIBlurEffect.Style){
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }//2
    
    //MARK:- sainiGradientColor
    public func sainiGradientColor(colorArr: [CGColor],vertical: Bool){
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.startPoint = CGPoint.zero
        layer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
        layer.colors = colorArr
        self.layer.insertSublayer(layer, at: 0)
    }//3
    
    //MARK:- sainiCornerRadius
    public func sainiCornerRadius(radius: CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }//4
    
    //MARK:- sainiRoundCorners
    public func sainiRoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }//5
    
    //MARK:- sainiShadow
    public func sainiShadow(shadowColor: CGColor,shadowOpacity: Float,shadowRadius:CGFloat){
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }//6
    
    //MARK:- sainiShadowWithCornerRadius
    public func sainiShadowWithCornerRadius(shadowColor: CGColor,shadowOpacity: Float,shadowRadius:CGFloat,cornerRadius: CGFloat){
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
    }//7
    
    //MARK:- sainiShadowWithGradientAndCornerRadius
    public func sainiShadowWithGradientAndCornerRadius(shadowColor: CGColor,shadowOpacity: Float,shadowRadius:CGFloat,cornerRadius: CGFloat,colorArr: [CGColor],verticalGradient: Bool){
        
        //Shadow
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        //gradient
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.startPoint = CGPoint.zero
        
        layer.endPoint = verticalGradient ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
        layer.colors = colorArr
        layer.cornerRadius = cornerRadius
        self.layer.insertSublayer(layer, at: 0)
        
        //corner radius
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
    }//8
    
    //MARK:- sainiGrowAndShrink
    public func sainiGrowAndShrink(startValue: Float,endValue: Float,duration:CFTimeInterval){
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [startValue, endValue, startValue]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = duration
        animation.repeatCount = Float.infinity
        self.layer.add(animation, forKey: nil)
    }//9
    
    //MARK:- sainiRotate
    public func sainiRotate(duration: Double = 1,isForward: Bool = true) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = isForward ? Float.pi * 2.0 : Float.pi * -2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    //MARK:- sainiStopRotating
    public func sainiStopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }//10
    
    //MARK:- sainiTapToChangeColor
    public func sainiTapToChangeColor(){
        self.isUserInteractionEnabled = true
        self.backgroundColor = .random()
    }//11
    
    //MARK:- sainiScreenshot
    public func sainiScreenshot() -> UIImage {
        // Using a function since `var image` might conflict with an existing variable
        // (like on `UIImageView`)
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    
    //MARK:- sainiAddBorderWithColor
    public func sainiAddBorderWithColor(color:UIColor, edge:AIEdge, thicknessOfBorder:CGFloat)  {
        
        // dispatch_async(dispatch_get_main_queue()) {
        
        DispatchQueue.main.async {
            
            var rect:CGRect = CGRect.zero
            
            switch edge {
            case .Top:
                rect = CGRect(x: 0, y: 0, width: self.width, height: thicknessOfBorder) //CGRectMake(0, 0, self.width, thicknessOfBorder);
            case .Left:
                rect = CGRect(x: 0, y: 0, width: thicknessOfBorder, height:self.width ) //CGRectMake(0, 0, thicknessOfBorder, self.height);
            case .Bottom:
                rect = CGRect(x: 0, y: self.height - thicknessOfBorder, width: self.width, height: thicknessOfBorder) //CGRectMake(0, self.height - thicknessOfBorder, self.width, thicknessOfBorder);
            case .Right:
                rect = CGRect(x: self.width-thicknessOfBorder, y: 0, width: thicknessOfBorder, height: self.height) //CGRectMake(self.width-thicknessOfBorder, 0,thicknessOfBorder, self.height);
                
            }
            
            let layerBorder = CALayer()
            layerBorder.frame = rect
            layerBorder.backgroundColor = color.cgColor
            self.layer.addSublayer(layerBorder)
        }
    }
    
    //MARK:- sainiDrawDashedBorderAroundView
    public func sainiDrawDashedBorderAroundView(dashColor: UIColor,dashWidth: CGFloat) {
        let cornerRadius: CGFloat = self.frame.size.width / 2
        let borderWidth: CGFloat = dashWidth
        let dashPattern1: Int = 10
        let dashPattern2: Int = 10
        let lineColor = dashColor
        
        //drawing
        let frame: CGRect = self.bounds
        let shapeLayer = CAShapeLayer()
        //creating a path
        let path: CGMutablePath = CGMutablePath()
        
        //drawing a border around a view
        path.move(to: CGPoint(x: CGFloat(0), y: CGFloat(frame.size.height - cornerRadius)), transform: .identity)
        path.addLine(to: CGPoint(x: CGFloat(0), y: CGFloat(cornerRadius)), transform: .identity)
        path.addArc(center: CGPoint(x: CGFloat(cornerRadius), y: CGFloat(cornerRadius)), radius: CGFloat(cornerRadius), startAngle: CGFloat(Double.pi), endAngle: CGFloat(-Double.pi / 2), clockwise: false, transform: .identity)
        path.addLine(to: CGPoint(x: CGFloat(frame.size.width - cornerRadius), y: CGFloat(0)), transform: .identity)
        path.addArc(center: CGPoint(x: CGFloat(frame.size.width - cornerRadius), y: CGFloat(cornerRadius)), radius: CGFloat(cornerRadius), startAngle: CGFloat(-Double.pi / 2), endAngle: CGFloat(0), clockwise: false, transform: .identity)
        path.addLine(to: CGPoint(x: CGFloat(frame.size.width), y: CGFloat(frame.size.height - cornerRadius)), transform: .identity)
        path.addArc(center: CGPoint(x: CGFloat(frame.size.width - cornerRadius), y: CGFloat(frame.size.height - cornerRadius)), radius: CGFloat(cornerRadius), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi / 2), clockwise: false, transform: .identity)
        path.addLine(to: CGPoint(x: CGFloat(cornerRadius), y: CGFloat(frame.size.height)), transform: .identity)
        path.addArc(center: CGPoint(x: CGFloat(cornerRadius), y: CGFloat(frame.size.height - cornerRadius)), radius: CGFloat(cornerRadius), startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: false, transform: .identity)
        
        //path is set as the _shapeLayer object's path
        
        shapeLayer.path = path
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.frame = frame
        shapeLayer.masksToBounds = false
        shapeLayer.setValue(NSNumber(value: false), forKey: "isCircle")
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = borderWidth
        shapeLayer.lineDashPattern = [NSNumber(integerLiteral: dashPattern1),NSNumber(integerLiteral: dashPattern2)]
        //shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        self.layer.addSublayer(shapeLayer)
        
    }
    
    //MARK:- sainiFadeIn
    public func sainiFadeIn() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 //
        }, completion: nil)
    }
    
    //MARK:- sainiFadeOut
    public func sainiFadeOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    //MARK:- sainiFadeOutInfinite
    public func sainiFadeOutInfinite() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { (success) in
            self.sainiFadeInInfinite()
        })
    }
    //MARK:- sainiFadeInInfinite
    public func sainiFadeInInfinite() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 1.0
        }, completion: { (success) in
            self.sainiFadeOutInfinite()
        })
    }
    
    //MARK:- sainiShowLoader
    public func sainiShowLoader(loaderColor: UIColor, backgroundColor: UIColor = UIColor.clear) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.center = backgroundView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        activityIndicator.color = loaderColor
        activityIndicator.startAnimating()
        //self.isUserInteractionEnabled = false
        backgroundView.addSubview(activityIndicator)
        self.addSubview(backgroundView)
    }
    
    //MARK:- sainiRemoveLoader
    public func sainiRemoveLoader() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        //self.isUserInteractionEnabled = true
    }
    
    //MARK:- sainiRotateByAngle
    public func sainiRotateByAngle(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
    
    
    //MARK:- sainiDashedLine
    public func sainiDashedLine(color: CGColor,lineDashPattern: [NSNumber]) {
        let path = CGMutablePath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = self.frame.height
        shapeLayer.strokeColor = color
        shapeLayer.lineDashPattern = lineDashPattern
        path.addLines(between: [CGPoint(x: bounds.minX, y: bounds.height/2),
                                CGPoint(x: bounds.maxX, y: bounds.height/2)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    //MARK:- sainiAddGestureToUIView
    public func sainiAddTapGesture(action : @escaping ()->Void ){
        let tap = SainiTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    @objc public func handleTap(_ sender: SainiTapGestureRecognizer) {
        sender.action!()
    }
    
    //MARK:- sainiAddSwipe to UIView
    public func sainiAddSwipe(action : @escaping (Swipe)->Void) {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let swipe = SainiSwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            swipe.direction = direction
            swipe.disha = action
            self.addGestureRecognizer(swipe)
            self.isUserInteractionEnabled = true
        }
    }
    
    @objc public func handleSwipe(sender: SainiSwipeGestureRecognizer) {
        switch sender.direction {
        case .down:
            sender.disha!(.down)
            break
        case .up:
            sender.disha!(.up)
            break
        case .left:
            sender.disha!(.left)
            break
        case .right:
            sender.disha!(.right)
            break
        default:
            break
        }
        
    }
    
    //MARK:- sainiPulsateAnimation
    public func sainiPulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: "pulse")
    }
    
    //MARK:- sainiFlashAnimation
    public func sainiFlash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        
        layer.add(flash, forKey: nil)
    }
    
    //MARK:- sainiShakeAnimation
    public func sainiShake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    //MARK:- sainiShowToast
    public func sainiShowToast(message: String) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let toastLbl = UILabel()
        toastLbl.text = message
        toastLbl.textAlignment = .center
        toastLbl.font = UIFont.systemFont(ofSize: 18)
        toastLbl.textColor = UIColor.white
        toastLbl.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLbl.numberOfLines = 0
        
        
        let textSize = toastLbl.intrinsicContentSize
        let labelHeight = ( textSize.width / window.frame.width ) * 30
        let labelWidth = min(textSize.width, window.frame.width - 40)
        let adjustedHeight = max(labelHeight, textSize.height + 20)
        
        toastLbl.frame = CGRect(x: 20, y: (window.frame.height - 90 ) - adjustedHeight, width: labelWidth + 20, height: adjustedHeight)
        toastLbl.center.x = window.center.x
        toastLbl.layer.cornerRadius = 10
        toastLbl.layer.masksToBounds = true
        
        window.addSubview(toastLbl)
        
        UIView.animate(withDuration: 3.0, animations: {
            toastLbl.alpha = 0
        }) { (_) in
            toastLbl.removeFromSuperview()
        }
    }
    
}


