//
//  SainiUIImageView.swift
//  SainiExtensions
//
//  Created by Rohit Saini on 15/07/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import UIKit

//MARK:- UIImageView
extension UIImageView{
    
    //MARK:- sainiStoreImage
    public func sainiStoreImage(urlString: String,img: UIImage){
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        let data  = img.jpegData(compressionQuality: 0.5)
        ((try? data?.write(to: url)) as ()??)
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String: String]
        if dict == nil{
            dict = [String: String]()
        }
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache")
    }
    
    //MARK:- sainiLoadImage
    public func sainiLoadImage(urlString: String){
        self.sainiShowLoader(loaderColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        //if image if already present in cache the download only from there
        if let  dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String: String]{
            if let path = dict[urlString]{
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                    let img = UIImage(data: data)
                    self.image = img
                    self.sainiRemoveLoader()
                    print("Downloaded from Cache")
                    return
                }
            }
        }
        
        // download imgage from server url for the first time
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else{return}
            guard let d = data else {return}
            DispatchQueue.main.async {
                if let image = UIImage(data: d){
                    //store image url and img in temp directory or store as cache
                    self.sainiStoreImage(urlString: urlString, img: image)
                    self.sainiRemoveLoader()
                    print("Downloaded from Internet")
                    self.image = image
                }
            }
        }
        task.resume()
        
    }
    
}
