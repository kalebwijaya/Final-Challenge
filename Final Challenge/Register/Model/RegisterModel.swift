//
//  RegisterModel.swift
//  Final Challenge
//
//  Created by Michael Louis on 06/12/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class RegisterModel {
    func sendData(url: URL,setParam: RegisterParam ,completion: @escaping (RegisterResponse?,Error?) -> Void){
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do{
            let bodyParam = try encoder.encode(setParam)
            request.httpBody = bodyParam
        }catch {
            print("Error body param not worked")
        }
        
        let task = session.dataTask(with: request){
            (data , response , error) in
            
            if let error = error {
                completion(nil,error)
            }else if let data = data {
                do{
                    let result = try JSONDecoder().decode(RegisterResponse.self, from: data)
                    completion(result,nil)
                }catch {
                    completion(nil,error)
                }
            }
        }
        task.resume()
    }
}
