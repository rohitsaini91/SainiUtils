//
//  SainiThread.swift
//  SainiUtils
//
//  Created by Rohit Saini on 07/06/20.
//

import Foundation

extension Thread {

    //MARK:- Get Current Working Thread 
    public var threadName: String {
        if let currentOperationQueue = OperationQueue.current?.name {
            return "OperationQueue: \(currentOperationQueue)"
        } else if let underlyingDispatchQueue = OperationQueue.current?.underlyingQueue?.label {
            return "DispatchQueue: \(underlyingDispatchQueue)"
        } else {
            let name = __dispatch_queue_get_label(nil)
            return String(cString: name, encoding: .utf8) ?? Thread.current.description
        }
    }
}
