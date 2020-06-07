//
//  SainiUserDefaults.swift
//  SainiUtils
//
//  Created by Rohit Saini on 07/06/20.
//

import Foundation


extension UserDefaults {

    //MARK:- Set Custom Object in UserDefaults
    public func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }

     //MARK:- Get Custom Object from UserDefaults
    public func get<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
