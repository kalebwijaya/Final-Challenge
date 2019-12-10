//
//  LoginViewController.swift
//  Final Challenge
//
//  Created by Michael Louis on 03/12/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController ,UITextFieldDelegate{
    
    
    let loginModel = LoginModel()
    var loginParam:LoginParam?
    var loginResponse:LoginResponses?
    let url = URL(string: "\(BaseURL.baseURL)api/login")
    
    @IBAction func loginButton(_ sender: Any) {
        loginUserToServer()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func CreateIDButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()!
        navigationController?.pushViewController(vc,
                                                 animated: true)
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
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
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
