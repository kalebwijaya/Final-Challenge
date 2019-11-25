//
//  CourtListModel.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtListModel{
    public func fetchData(url : URL, getUserData: CourtListParam, completion: @escaping (CourtListResponses?, Error?) -> Void){
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        //kalo ad body param
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            let bodyParam = try encoder.encode(getUserData)
            request.httpBody = bodyParam
        }catch {
            print("Error body param not worked")
        }
        
        let task = session.dataTask(with: request) {
            (data , response , error) in
            
            if let error = error{
                completion(nil,error)
            }else if let data = data{
                do{
                    let result = try JSONDecoder().decode(CourtListResponses.self, from: data)
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
