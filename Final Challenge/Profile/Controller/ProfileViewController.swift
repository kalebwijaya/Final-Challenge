//
//  ProfileViewController.swift
//  Final Challenge
//
//  Created by Steven on 12/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var profileView: ProfileView!
    var profileStoragedData = [Any]()
    let url = URL(string: "\(BaseURL.baseURL)api/edit-profile")
    var profileModel = ProfileModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialization()
        
    }
    
    private func initialization(){
        
        profileStoragedData.append("header")
        profileStoragedData.append(("FullName","Steven"))
        profileStoragedData.append(("Phone Number","0817"))
        profileStoragedData.append(("Email","asd@adw.com"))
        profileStoragedData.append(("Password","123123132"))

        print(profileStoragedData)
        profileView.profileTableView.delegate = self
        profileView.profileTableView.dataSource = self
        profileView.profileTableView.tableFooterView = UIView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))

    }
    
    @objc func doneTapped(){
        var sendData = [Any]()
        for index in 1 ..< profileStoragedData.count{
            let indexPath = IndexPath(row: index, section: 0)
            let cell = profileView.profileTableView.cellForRow(at: indexPath) as! ProfileBodyTableViewCell
            
            sendData.append((key: cell.bodyTitleTypeLbl, value: cell.bodyInput))
           
        }
        let dataParsed = sendData as![(key :String, value: String)]
        let profileParam = ProfileParam(id: "1", fullname: dataParsed[0].value, phoneNumber: dataParsed[1].value, oldPassword: dataParsed[2].value, password: dataParsed[3].value)
        
       
        guard let url = url else{
            return
        }
        
        profileModel.sendEditProfile(url: url, getProfileData: profileParam) { (response, error) in
            
        }
        
    }
    
    @objc func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.profileTableView.register(UINib(nibName: "ProfileHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "headerCell")
        
        profileView.profileTableView.register(UINib(nibName: "ProfileBodyTableViewCell", bundle: nil), forCellReuseIdentifier: "bodyCell")
        
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
