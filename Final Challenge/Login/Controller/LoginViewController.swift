//
//  LoginViewController.swift
//  Final Challenge
//
//  Created by Michael Louis on 03/12/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController ,UITextFieldDelegate{
    
   
    
    @IBAction func loginButton(_ sender: Any) {
        let username = UserDefaults.standard.string(forKey: "username")
        let password = UserDefaults.standard.string(forKey: "password")
        
        
        if(usernameTextField.text == username && passwordTextField.text == password)
        {
            print("benar1")
            labelWrong.isHidden = true
            UserDefaults.standard.set(true, forKey: "sudahLogin")
            performSegue(withIdentifier: "loggedIn", sender: nil)
        }
        else if(usernameTextField.text != username)
        {
            labelWrong.isHidden = false
            print("salah1")
        }
        else if(passwordTextField.text != password)
        {
            labelWrong.isHidden = false
            print("salah2")
        }
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func CreateIDButton(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
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
         return false
      }
    
    
    
    @IBOutlet weak var labelWrong: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        labelWrong.isHidden = true
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        
    }
    
    func setupView()
    {
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")

        view.addGestureRecognizer(tap)

        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
    }
}
