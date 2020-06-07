//
//  SainiUIViewController.swift
//  Pods-SainiUtils_Tests
//
//  Created by Rohit Saini on 07/06/20.
//

import Foundation

extension UIViewController{
    
    //MARK:- ScrollToTop
    public func scrollToTop() {
      func scrollToTop(view: UIView?) {
       guard let view = view else { return }
       switch view {
       case let scrollView as UIScrollView:
        if scrollView.scrollsToTop == true {
          scrollView.setContentOffset(CGPoint(x: 0.0, y: -scrollView.contentInset.top), animated: true)
          return
        }
       default:
        break
       }
       for subView in view.subviews {
        scrollToTop(view: subView)
       }
     }
     scrollToTop(view: view)
    }
    public var isScrolledToTop: Bool {
     for subView in view.subviews {
       if let scrollView = subView as? UIScrollView {
        return (scrollView.contentOffset.y == 0)
       }
     }
     return true
    }
}
