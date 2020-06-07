//
//  SainiWindow.swift
//  SainiUtils
//
//  Created by Rohit Saini on 07/06/20.
//

import Foundation

extension UIWindow{
    //MARK:- Get TopMost Visible ViewController
    public var visibleViewController:UIViewController?{
        return UIWindow.visibleVC(vc:self.rootViewController)
    }
    public static func visibleVC(vc: UIViewController?) -> UIViewController?{
        if let navigationViewController = vc as? UINavigationController{
            return UIWindow.visibleVC(vc:navigationViewController.visibleViewController)
        }
        else if let tabBarVC = vc as? UITabBarController{
           return UIWindow.visibleVC(vc:tabBarVC.selectedViewController)
        }
        else{
            if let presentedVC = vc?.presentedViewController{
                return UIWindow.visibleVC(vc:presentedVC)
            }
            else{
                return vc
            }
        }
    }
}

public func visibleViewController() -> UIViewController?{
    return UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.visibleViewController
}
