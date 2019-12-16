//
//  ProfileViewController.swift
//  Final Challenge
//
//  Created by Steven on 12/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var loadingIndicator:LoadingIndicator?
    let loadingView = UIView()
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
        
        loadingIndicator = LoadingIndicator(loadingView: loadingView, mainView: self.view)
        
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            return
        }
        profileStoragedData.append(username)
        profileStoragedData.append(("Full Name",UserDefaults.standard.string(forKey: "fullname")))
        profileStoragedData.append(("Phone Number",UserDefaults.standard.string(forKey: "phonenumber")))
        profileStoragedData.append(("Email",UserDefaults.standard.string(forKey: "email")))

        print(profileStoragedData)
        profileView.profileTableView.delegate = self
        profileView.profileTableView.dataSource = self
        profileView.profileTableView.tableFooterView = UIView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))

    }
    
    @objc func doneTapped(){
        guard let loadingIndicator = loadingIndicator else{
            return
        }
        loadingIndicator.showLoading()
        var sendData = [Any]()
        for index in 1 ..< profileStoragedData.count{
            let indexPath = IndexPath(row: index, section: 0)
            let cell = profileView.profileTableView.cellForRow(at: indexPath) as! ProfileBodyTableViewCell
            
            if cell.bodyTitleTypeLbl.text != "Email" && cell.bodyTitleTypeLbl.text != "Password" {
                sendData.append((key: cell.bodyTitleTypeLbl.text, value: cell.bodyInput.text))
            }
        }
        let dataParsed = sendData as![(key :String, value: String)]
        let profileParam = ProfileParam(id: UserDefaults.standard.string(forKey: "id")!, fullname: dataParsed[0].value, phoneNumber: dataParsed[1].value)
        
        guard let url = url else{
            return        }
        
        profileModel.sendEditProfile(url: url, getProfileData: profileParam) { (response, error) in
            
            if let response = response {
                if response.errorCode == "200" {
                    
                    UserDefaults.standard.set(dataParsed[0].value, forKey: "fullname")
                    
                    UserDefaults.standard.set(dataParsed[1].value, forKey: "phonenumber")
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }else if (response.errorCode == "400"){
                    print(response.errorMessage)
                }
            }
            
        }
        loadingIndicator.removeLoading()
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
