//
//  OrderModel.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 26/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class OrderModel {
    public func sendOrderRequest(url: URL, completion: @escaping (HistoryResult?, Error?) -> Void){
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url){
            (data, response , error) in
            if let error = error{
                completion(nil,error)
            }else if let data = data{
                do{
                    let result = try JSONDecoder().decode(HistoryResult.self, from: data)
                    completion(result,nil)
                }catch {
                    completion(nil,error)
                }
            }
        }
        task.resume()
    }
}
