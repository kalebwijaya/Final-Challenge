//
//  CourtSearchModel.swift
//  Final Challenge
//
//  Created by Steven on 11/19/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation
import UIKit

class CourtSearchModel{
    let cache = NSCache<NSString,UIImage>()
    
    public func fetchData(url: URL, getUserData: CourtSearchParam, completion: @escaping (CourtSearchResponse?, Error?) -> Void){
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"

        let encoder = JSONEncoder()
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do{
            let bodyParam = try encoder.encode(getUserData)
            request.httpBody = bodyParam
        }catch{
            print(error)
        }
        let task = session.dataTask(with: request) {
               (data , response , error) in
            
            if let error = error{
                print(error)
                completion(nil,error)
            }else if let data = data{
                do{
                    let result = try JSONDecoder().decode(CourtSearchResponse.self, from: data)
                    
                    completion(result,nil)
                }catch {
                    print(error)
                    completion(nil,error)
                }
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
