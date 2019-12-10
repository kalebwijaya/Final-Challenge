//
//  RegisterViewControllerSession.swift
//  Final Challenge
//
//  Created by Michael Louis on 06/12/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

extension RegisterViewController{
    
    func regisUserToServer(){
        
        guard let jsonUrl = url,
            let fullname = fullnameTextField.text,
            let username = usernameTextField.text,
            let phoneNumber = phonenumberTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text
            else {
                return
        }
        
        registerParam = RegisterParam(fullname: fullname, username: username, phoneNumber: phoneNumber, email: email, password: password)
    
        registerModel.sendData(url: jsonUrl, setParam: registerParam!){ (result, error) in
            if let result = result{
                if(result.errorCode == "200"){
                    self.registerResponse = result
                    print("200 "+result.errorMessage)
                    DispatchQueue.main.async {
                        self.passwordErrorLabel.text = "User successfully registered"
                        self.passwordErrorLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                        self.performSegue(withIdentifier: "regisToMain", sender: nil)
                    }
                }else if(result.errorCode == "400"){
                    DispatchQueue.main.async {
                        self.passwordErrorLabel.text = "Username/Email is already registered"
                    }
                    print("400 "+result.errorMessage)
                }
            }else if let error = error {
                print(error)
            }
        }
        
    }
}
