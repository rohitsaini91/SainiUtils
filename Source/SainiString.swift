//
//  SainiString.swift
//  SainiExtensions
//
//  Created by Rohit Saini on 20/08/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import UIKit

//MARK:- String Extenstions
extension String{
    
    //MARK:- sainiDateFromString(convert date string into Date)
    public func sainiDateFromString(dateStr: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: dateStr)
        print("date: \(String(describing: date))")
        return date ?? Date()
    }
}
