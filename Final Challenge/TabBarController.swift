
//
//  TabBarController.swift
//  Final Challenge
//
//  Created by Michael Louis on 02/01/20.
//  Copyright © 2020 Kaleb Wijaya. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    // Create the alert controller
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // Create the actions
       
        
        if item == (self.tabBar.items!)[0]{
           //Do something if index is 0
            print("asdas1")
        }
        else if item == (self.tabBar.items!)[1]{
            let alertController = UIAlertController(title: "Log In to see details", message: "You need to log in first to see order lists.", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Login", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                self.performSegue(withIdentifier: "alertToLogin", sender: self)
                
            }
                  
                 
              let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                     UIAlertAction in
                     NSLog("Cancel Pressed")
                  
                 }

                 // Add the actions
                 alertController.addAction(okAction)
                 alertController.addAction(cancelAction)
           //Do something if index is 1
            if(UserDefaults.standard.bool(forKey: "sudahLogin") == false)
            {
                      self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {

    }
    
    func toLogin()
    {
                        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
                      
                      let vc = storyBoard.instantiateViewController(identifier: "login") as! LoginViewController
                      let navController = UINavigationController(rootViewController: vc)
                      
                      self.navigationController?.present(navController, animated: true, completion: nil)
    }
}
