//
//  ProfileModel.swift
//  Final Challenge
//
//  Created by Steven on 12/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class ProfileModel{
    public func sendEditProfile(url: URL, getProfileData : ProfileParam, completion: @escaping (ProfileResponses?, Error?) -> Void ){
        
        let session = URLSession(configuration: .default)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let bodyParam = try encoder.encode(getProfileData)
            request.httpBody = bodyParam
        }catch{
            print("Error to send data")
        }
        
        let task = session.dataTask(with: request) {
                (data , response , error) in
                
                if let error = error{
                    completion(nil,error)
                }else if let data = data{
                    do{
                        let result = try JSONDecoder().decode(ProfileResponses.self, from: data)
        
                        completion(result,nil)
                    }catch {
                        completion(nil,error)
                    }
                }
            }
            
            task.resume()
    }
}
