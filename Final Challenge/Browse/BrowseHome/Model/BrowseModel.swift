//
//  BrowseModel.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class BrowseModel  {
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
    
}
