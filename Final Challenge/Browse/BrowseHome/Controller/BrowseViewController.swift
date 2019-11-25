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
    let url = URL(string: "http://83761bd6.ngrok.io/api/browse-category")

    var browseModel = BrowseModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        setNavigation()
        initialization()
        
    }
    
    private func setNavigation(){
        self.title = "Court Category"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setNavigation()
        getData()
    }
    
    private func initialization(){
        
        browseView.browserTableView.register(UINib(nibName: "BrowseTableViewCell", bundle: nil), forCellReuseIdentifier: "browseCell")
        browseView.browserTableView.delegate = self
        browseView.browserTableView.dataSource = self

    }
    
    private func getData(){
        guard let jsonUrl = url else{
            return
        }
        
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
extension BrowseViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return browseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "browseCell") as! BrowseTableViewCell
        cell.sportTypeLbl.text = browseData[indexPath.row].sportTypeName
        cell.sportImage.image = UIImage(named: "court_category")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let getID = browseData[indexPath.row].sportTypeID
        let storyboard = UIStoryboard(name: "CourtList", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "courtList") as! CourtListViewController
    
        vc.getSportTypeID = getID
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

extension BrowseViewController: UITableViewDelegate{
    
}
