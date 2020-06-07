//
//  SainiUIColor.swift
//  SainiExtensions
//
//  Created by Rohit Saini on 14/07/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import UIKit

//MARK:- UICOLOR
extension UIColor {
    //generate random color
    public static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
