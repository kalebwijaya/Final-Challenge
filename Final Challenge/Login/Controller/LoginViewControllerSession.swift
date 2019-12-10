//
//  LoginViewControllerSession.swift
//  Final Challenge
//
//  Created by Michael Louis on 09/12/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

extension LoginViewController
{
    
    func loginUserToServer(){
        
        guard let jsonUrl  = url ,
            let username = usernameTextField.text ,
            let password = passwordTextField.text
            
            else
        {
            return
            
        }
        
        loginParam = LoginParam(id: username, password: password)
        
        loginModel.getLogin(url: jsonUrl, setBodyParam: loginParam!){ (result, error) in
            if let result = result{
                if(result.errorCode == "200"){
                    self.loginResponse = result
                    print("200 "+result.errorMessage)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loggedIn", sender: nil)
                        UserDefaults.standard.set(true, forKey: "sudahLogin")
                    }
                    
                }else if(result.errorCode == "400"){
                    DispatchQueue.main.async {
                        self.labelWrong.text = "Username/Password is wrong"
                    }
                    print("400 "+result.errorMessage)
                }
            }else if let error = error {
                print(error)
            }
        }
        
    }
}
