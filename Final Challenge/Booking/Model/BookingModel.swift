//
//  BookingModel.swift
//  Final Challenge
//
//  Created by Steven on 11/25/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class BookingModel{
    public func sendBookingRequest(url: URL, setBodyParam: BookingParam, completion: @escaping (BookingResponse?, Error?) -> Void){
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do{
            let bodyParam = try encoder.encode(setBodyParam)
            request.httpBody = bodyParam
        }catch{
            print(error)
        }
        
        let task = session.dataTask(with: request){
            (data, response , error) in
            if let error = error{
                completion(nil,error)
            }else if let data = data{
                do{
                    let result = try JSONDecoder().decode(BookingResponse.self, from: data)
                    completion(result,nil)
                }catch {
                    completion(nil,error)
                }
            }
        }
        task.resume()
    }
    
    public func getBookingView(url: URL , setBodyParam: BookingViewParam, completion: @escaping (BookingCourtResult?,Error?) -> Void){
        
        let session = URLSession(configuration: .default)
               var request = URLRequest(url: url)
               
               request.httpMethod = "POST"
               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
               
               let encoder = JSONEncoder()
               
               do{
                   let bodyParam = try encoder.encode(setBodyParam)
                   request.httpBody = bodyParam
               }catch{
                   print(error)
               }
               
               let task = session.dataTask(with: request){
                   (data, response , error) in
                   if let error = error{
                       completion(nil,error)
                   }else if let data = data{
                       do{
                           let result = try JSONDecoder().decode(BookingCourtResult.self, from: data)
                           completion(result,nil)
                       }catch {
                           completion(nil,error)
                       }
                   }
               }
               task.resume()
        
    }
}
