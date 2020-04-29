//
//  SainiUtility.swift
//  SainiExtensions
//
//  Created by Rohit Saini on 19/07/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox

//=====================================================================
//MARK:- Color function
public func sainiColorFromHex(hex : String) -> UIColor
{
    return colorWithHexString(hex, alpha: 1.0)
}

public func colorFromHex(hex : String, alpha:CGFloat) -> UIColor
{
    return colorWithHexString(hex, alpha: alpha)
}

public func colorWithHexString(_ stringToConvert:String, alpha:CGFloat) -> UIColor {
    
    var cString:String = stringToConvert.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

//MARK:- Open Url
public func sainiOpenUrlInSafari(strUrl : String)
{
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(URL(string : strUrl)!, options: [:]) { (isOpen) in
            
        }
    } else {
        // Fallback on earlier versions
    }
}


/**
 A convenient UIImageView to load and cache images.
 */

//MARK:-  CachedImageView
open class CachedImageView: UIImageView {
    
    public static let imageCache = NSCache<NSString, DiscardableImageCacheItem>()
    
    open var shouldUseEmptyImage = true
    
    private var urlStringForChecking: String?
    private var emptyImage: UIImage?
    
    public convenience init(cornerRadius: CGFloat = 0, tapCallback: @escaping (() ->())) {
        self.init(cornerRadius: cornerRadius, emptyImage: nil)
        self.tapCallback = tapCallback
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HandleTap)))
    }
    
    @objc func HandleTap() {
        tapCallback?()
    }
    
    private var tapCallback: (() -> ())?
    
    public init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        self.emptyImage = emptyImage
    }
    
    required public init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Easily load an image from a URL string and cache it to reduce network overhead later.
     
     - parameter urlString: The url location of your image, usually on a remote server somewhere.
     - parameter completion: Optionally execute some task after the image download completes
     */
    
    open func loadImage(urlString: String, completion: (() -> ())? = nil) {
        image = nil
        sainiShowLoader(loaderColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        self.urlStringForChecking = urlString
        
        let urlKey = urlString as NSString
        
        if let cachedItem = CachedImageView.imageCache.object(forKey: urlKey) {
            image = cachedItem.image
            self.sainiRemoveLoader()
            completion?()
            return
        }
        
        guard let url = URL(string: urlString) else {
            if shouldUseEmptyImage {
                image = emptyImage
                self.sainiRemoveLoader()
            }
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                self?.sainiRemoveLoader()
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    let cacheItem = DiscardableImageCacheItem(image: image)
                    CachedImageView.imageCache.setObject(cacheItem, forKey: urlKey)
                    
                    if urlString == self?.urlStringForChecking {
                        self?.image = image
                        self?.sainiRemoveLoader()
                        completion?()
                    }
                }
            }
            
        }).resume()
    }
}

open class DiscardableImageCacheItem: NSObject, NSDiscardableContent {
    
    private(set) public var image: UIImage?
    var accessCount: UInt = 0
    
    public init(image: UIImage) {
        self.image = image
    }
    
    public func beginContentAccess() -> Bool {
        if image == nil {
            return false
        }
        
        accessCount += 1
        return true
    }
    
    public func endContentAccess() {
        if accessCount > 0 {
            accessCount -= 1
        }
    }
    
    public func discardContentIfPossible() {
        if accessCount == 0 {
            image = nil
        }
    }
    
    public func isContentDiscarded() -> Bool {
        return image == nil
    }
    
}


//MARK:- Saini Custom Tap Gesture
open class SainiTapGestureRecognizer: UITapGestureRecognizer {
var action : (()->Void)? = nil

}

//MARK:- CUSTOM BUTTON
open class RSBounceButton: UIButton{
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.5, delay: 0,usingSpringWithDamping: 0.5,initialSpringVelocity:6, options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
        super.touchesBegan(touches, with: event)
    }
}


//=====================================================================
//Image Compression to 10th
//MARK:- CompressImage
public func sainiCompressImage(image: UIImage) -> Data {
    // Reducing file size to a 10th
    
    var actualHeight : CGFloat = image.size.height
    var actualWidth : CGFloat = image.size.width
    let maxHeight : CGFloat = 1920.0
    let maxWidth : CGFloat = 1080.0
    var imgRatio : CGFloat = actualWidth/actualHeight
    let maxRatio : CGFloat = maxWidth/maxHeight
    var compressionQuality : CGFloat = 1.0
    
    if (actualHeight > maxHeight || actualWidth > maxWidth) {
        
        if (imgRatio < maxRatio) {
            
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        } else if (imgRatio > maxRatio) {
            
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
            
        } else {
            
            actualHeight = maxHeight
            actualWidth = maxWidth
            compressionQuality = 1
        }
    }
    
    let rect = CGRect(x: 0.0, y: 0.0, width:actualWidth, height:actualHeight)
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    let imageData = img!.jpegData(compressionQuality: compressionQuality)
    UIGraphicsEndImageContext();
    
    return imageData!
}

//Signature View
//MARK:- Signature View

//Signature Properties
struct Line {
    let strokeWidth: Float
    let color: UIColor
    var points: [CGPoint]
}
//=======================================================================
//MARK:- sainiSignatureView
open class sainiSignatureView: UIView {
    
    // public function
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 1
    
    public func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }
    
    public func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    public func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    public func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    public func save(){
        let img = self.sainiScreenshot()
        UIImageWriteToSavedPhotosAlbum(img, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //MARK: - Add image to Library
     @objc public func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            print(error)
        } else {
            print("saved Successfully!")
        }
    }
    
    fileprivate var lines = [Line]()
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}


//======================================================================
//MARK:- sainiCardView
open class sainiCardView: UIView {
    
    @IBInspectable var cornerRadious : CGFloat = 5
    @IBInspectable var shadowColor : UIColor? = UIColor.black
    
    @IBInspectable let shadowOffSetWidth : Int = 0
    @IBInspectable let shadowOffSetHeight : Int =  1
    
    @IBInspectable var shadowOpacity : CGFloat = 0.2
    
    override open func layoutSubviews(){
        layer.cornerRadius = cornerRadious
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowpath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadious)
        layer.shadowPath =  shadowpath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}

//============================================================
//MARK:- AudioService(play Sound)
open class SainiAudioService {
    func sainiPlayLocalSound(soundName: String,type:String)  {
    var soundID: SystemSoundID = 0
    let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: type)!)
    AudioServicesCreateSystemSoundID(soundURL, &soundID)
    AudioServicesPlaySystemSound(soundID)
  }
}



//=======================================================
//MARK:- sainiReadableDate
public func sainiReadableDate(timeStamp: TimeInterval) -> String? {
    let date = Date(timeIntervalSince1970: timeStamp)
    let dateFormatter = DateFormatter()
    
    if Calendar.current.isDateInTomorrow(date) {
        return "Tomorrow"
    } else if Calendar.current.isDateInYesterday(date) {
        return "Yesterday"
    } else if dateFallsInCurrentWeek(date: date) {
        if Calendar.current.isDateInToday(date) {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date)
        } else {
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        }
    } else {
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}

public func dateFallsInCurrentWeek(date: Date) -> Bool {
    let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
    let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
    return (currentWeek == datesWeek)
}


//=======================================================================
//MARK:- sainiTimesAgo
public func sainiTimesAgo(_ timestamp : Double) -> String
{
    let interval : Int = getDifferenceFromCurrentTime(timestamp)
    
    let second : Int = interval
    let minutes : Int = interval/60
    let hours : Int = interval/(60*60)
    let days : Int = interval/(60*60*24)
    let week : Int = interval/(60*60*24*7)
    let months : Int = interval/(60*60*24*30)
    let years : Int = interval/(60*60*24*30*12)
    
    var timeAgo : String = ""
    if  second < 60
    {
        timeAgo = (second < 3) ? "Just Now" : (String(second) + "s")
    }
    else if minutes < 60
    {
        timeAgo = String(minutes) + "m"
    }
    else if hours < 24
    {
        timeAgo = String(hours) + "h"
    }
    else if days < 30
    {
        timeAgo = String(days) + " "  + ((days > 1) ? "days" : "day")
    }
    else if week < 4
    {
        timeAgo = String(week) + " "  + ((week > 1) ? "weeks" : "week")
    }
    else if months < 12
    {
        timeAgo = String(months) + " "  + ((months > 1) ? "months" : "month")
    }
    else
    {
        timeAgo = String(years) + " "  + ((years > 1) ? "years" : "year")
    }
    
    if second > 3 {
        timeAgo = timeAgo + " ago"
    }
    return timeAgo
}

public func getDifferenceFromCurrentTime(_ timeStemp : Double) -> Int
{
    let newDate : Date = Date(timeIntervalSince1970: TimeInterval(timeStemp))
    let currentDate : Date = Date()
    let interval = currentDate.timeIntervalSince(newDate)
    return Int(interval)
}


//MARK:- SainiShadowButton
final class SainiShadowButton: UIButton {
    
    private var shadowLayer: CAShapeLayer!
    @IBInspectable var cornerRadius : CGFloat = 0
    @IBInspectable var shadowRadius : CGFloat = 0
    @IBInspectable var shadowColor : UIColor? = UIColor.black
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = #colorLiteral(red: 0.3761442602, green: 0.9105725884, blue: 0.4707484245, alpha: 1)
            shadowLayer.shadowColor = shadowColor?.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
            shadowLayer.shadowOpacity = 1
            shadowLayer.shadowRadius = shadowRadius
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
}
