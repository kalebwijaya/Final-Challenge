//
//  CourtSearchModel.swift
//  Final Challenge
//
//  Created by Steven on 11/19/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtSearchModel{
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
                completion(nil,error)
            }else if let data = data{
                do{
                    let result = try JSONDecoder().decode(CourtSearchResponse.self, from: data)
                    
                    print("\(result.data) ini ni")
                    
                    completion(result,nil)
                }catch {
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
                    completion(data)
                }
            }
        }
    }
}
