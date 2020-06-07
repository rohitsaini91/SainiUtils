
import UIKit

extension MYGadientCircularSlider {
    
    //================================================================================
    // GRADIENT COLORS PROPERTIES
    //================================================================================
    
    @IBInspectable public var _firstGradientColor: UIColor {
        get {
            return gradientColors[0]
        }
        set {
            gradientColors[0] = newValue
        }
    }
    
    @IBInspectable public var _secondGradientColor: UIColor {
        get {
            return gradientColors[1]
        }
        set {
            gradientColors[1] = newValue
        }
    }
    
    @IBInspectable public var _thirdGradientColor: UIColor {
        get {
            return gradientColors[2]
        }
        set {
            gradientColors[2] = newValue
        }
    }
    
    // More colors can be added programatically
    
}
