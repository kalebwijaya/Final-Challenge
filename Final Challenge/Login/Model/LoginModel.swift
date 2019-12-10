
import Foundation

class LoginModel {
    public func getLogin(url: URL, setBodyParam: LoginParam, completion: @escaping (LoginResponses?,Error?) -> Void){
        
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
                    let result = try JSONDecoder().decode(LoginResponses.self, from: data)
                    completion(result,nil)
                }catch {
                    completion(nil,error)
                }
            }
        }
        task.resume()
        
    }
}
