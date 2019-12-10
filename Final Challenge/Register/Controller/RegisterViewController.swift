//
//  RegisterViewController.swift
//  Final Challenge
//
//  Created by Michael Louis on 04/12/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController ,UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var phonenumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmpasswordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    
    let registerModel = RegisterModel()
    var registerParam:RegisterParam?
    var registerResponse:RegisterResponse?
    let url = URL(string: "\(BaseURL.baseURL)api/register")
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        if(cekRegistrasi())
        {
            regisUserToServer()
        }
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupview()
        
    }
    
    func cekRegistrasi()-> Bool
    {
        var i = 7
        
        if(usernameTextField.text!.count <= 6)
        {
            i = i - 1
            passwordErrorLabel.text = "Username should be more than 6 character"
            return false
        }
        if(!validateName(name: usernameTextField.text!))
        {
            i = i - 1
            passwordErrorLabel.text = "Username can not contain symbol"
            return false
        }
        if  (fullnameTextField.text!.count < 3 || fullnameTextField.text!.count > 30 )
        {
            i = i - 1
            passwordErrorLabel.text = "Full name should be between 3 until 30 character"
            return false
        }
        if(isValid(emailTextField.text!) == false)
        {
            i = i - 1
            
            passwordErrorLabel.text = "Email is invalid"
            return false
        }
        if(phonenumberTextField.text!.count < 10 || phonenumberTextField.text!.count > 12)
        {
            i = i - 1
            passwordErrorLabel.text = "Phone number should be between 10 - 12 character"
            return false
        }
        if(isPassValid(passwordTextField.text!) == false)
        {
            i = i - 1
            passwordErrorLabel.text = "Password should be alphanumeric and at least have one capital letter"
            return false
        }
        if(confirmpasswordTextField.text != passwordTextField.text)
        {
            i = i - 1
            passwordErrorLabel.text = "Confirm password is incorrect"
            return false
        }
            
            
        else
        {
            if(i == 7)
            {
                return true
            }
        }
    }
    
    public func validateName(name: String) ->Bool {
        
        let nameRegex =  "^\\w{6,16}$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        
        return nameTest.evaluate(with: name)
    }
    func isPassValid(_ password:String)->Bool
    {
        let passRegEx =  "((?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,20})"
        
        let passTest = NSPredicate(format: "SELF MATCHES[c] %@", passRegEx)
        return passTest.evaluate(with: password)
        
    }
    
    func isValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    func setupview()
    {
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        phonenumberTextField.delegate = self
        passwordTextField.delegate = self
        fullnameTextField.delegate = self
        confirmpasswordTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
        
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        fullnameTextField.attributedPlaceholder = NSAttributedString(string: "Full Name",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        phonenumberTextField.attributedPlaceholder = NSAttributedString(string: "Phone Number",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password ex : Password123",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        confirmpasswordTextField.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


