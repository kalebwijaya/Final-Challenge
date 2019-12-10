//
//  BrowseViewController.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {

    @IBOutlet var browseView: BrowseView!
    var browseData = [BrowseData]()
    let url = URL(string: "\(BaseURL.baseURL)api/browse-category")
    
    let loadingView = UIView()
    var loadingIndicator:LoadingIndicator?
    var browseModel = BrowseModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialization()
    }
    
    
    private func setNavigation(){
        
//        self.title = "Court Category"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        let profileButton = CircularBarButton(image: UIImage(named: "court_category"))
//        profileButton.button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        
        navigationItem.rightBarButtonItems = [profileButton.load()]
            navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigation()
        getData()
        print(navigationItem.title)
    }
    
    private func initialization(){
        loadingIndicator = LoadingIndicator(loadingView: loadingView, mainView: self.view)
        browseView.browserTableView.register(UINib(nibName: "BrowseTableViewCell", bundle: nil), forCellReuseIdentifier: "browseCell")
        browseView.browserTableView.delegate = self
        browseView.browserTableView.dataSource = self

    }
    
    private func getData(){
        guard let jsonUrl = url, let loadingIndicator = loadingIndicator else{
            return
        }
        
        loadingIndicator.showLoading()
    
        browseModel.fetchData(url: jsonUrl) { (responses, error) in
            if let response = responses {
                if (response.errorCode == "200"){
                   self.browseData = response.data
                    DispatchQueue.main.async {
                        self.browseView.browserTableView.reloadData()
                    }
                }else if (response.errorCode == "400"){
                    print(response.errorMessage)
                }
            }
        }
        
        loadingIndicator.removeLoading()
        
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
