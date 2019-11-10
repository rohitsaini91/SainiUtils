//
//  SainiCGFloat.swift
//  SainiExtensions
//
//  Created by Rohit Saini on 14/07/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import UIKit


//MARK:- CGFLOAT
extension CGFloat {
    //generate random CGFloat number
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    public func getminimum(value2:CGFloat)->CGFloat
    {
        if self < value2
        {
            return self
        }
        else
        {
            return value2
        }
    }
}
