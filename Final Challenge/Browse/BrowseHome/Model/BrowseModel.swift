//
//  BrowseModel.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation
import UIKit

class BrowseModel  {
    let cache = NSCache<NSString,UIImage>()
    
    public func fetchData(url: URL, completion: @escaping (BrowseResponses?, Error?) -> Void){
        
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request){
            (data , response , error ) in
            guard let data = data , error == nil , response != nil else {
                return
            }
            do{
                let result = try JSONDecoder().decode(BrowseResponses.self, from: data)
                completion(result, nil)
            }catch{
                completion(nil, error)
                print(error)
            }
        }
        task.resume()
        
    }
    
    public func fetchImage(imageURL : String , completion: @escaping (Data) -> Void){
        if let imageURL = URL(string: imageURL){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    
                    let downloadImage = UIImage(data: data)
                    self.cache.setObject(downloadImage!, forKey: imageURL.absoluteString as NSString)
                    completion(data)
                }
            }
        }
    }
    
    public func getImage(imageURL : String , completion: @escaping (Data) -> Void){
        if let getImage = URL(string: imageURL){
            if let image = cache.object(forKey: getImage.absoluteString as NSString){
                
                completion(image.pngData()!)
            }else{
                fetchImage(imageURL: imageURL, completion: completion)
            }
        }
        
    }
    
}
