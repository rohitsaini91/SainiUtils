//
//  SainiDouble.swift
//  SainiExtensions
//
//  Created by Rohit Saini on 20/08/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Double Extensions
extension Double {
    //MARK:- sainiRounded
    public func sainiRounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
