//
//  SainiData.swift
//  SainiUtils
//
//  Created by Rohit Saini on 07/06/20.
//

import Foundation


extension Data {
    //MARK:- Convert Data into pretty json format
    public var sainiPrettyJSON: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }

}
