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
    let url = URL(string: "http://10.60.40.42:3000/browseCategory")

    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        setNavigation()
        initialization()
        browseNavigationBarTitle()
        fetchData()
    }
    
    private func setNavigation(){
        self.navigationItem.title = ""
    }
    
    private func initialization(){
        
        browseView.browserTableView.register(UINib(nibName: "BrowseTableViewCell", bundle: nil), forCellReuseIdentifier: "browseCell")
        browseView.browserTableView.delegate = self
        browseView.browserTableView.dataSource = self
        
        
        
    }
    
    private func fetchData(){
        guard let jsonUrl = url else{
            return
        }
        
        URLSession.shared.dataTask(with: jsonUrl) {
            (data , response , error ) in
            guard let data = data , error == nil , response != nil else {
                return
            }
            do{
                let result = try JSONDecoder().decode(BrowseResponses.self, from: data)
                if (result.errorCode == "200"){
                    print("get data")
                    self.browseData = result.data
                    DispatchQueue.main.async {
                        self.browseView.browserTableView.reloadData()
                    }
                }else if (result.errorCode == "400"){
                    print(result.errorMessage)
                }
            }catch{
                print("error parse data")
            }
            
        }.resume()
    }
    
    private func browseNavigationBarTitle(){
        let logo = UIImage(named: "logo.png")
        let showLogo = UIImageView(image: logo)
        self.navigationItem.titleView = showLogo
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45))

        let label = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.size.width, height: 45))
        label.text = "Court Category"
        label.font = UIFont.boldSystemFont(ofSize: 26.0)
        returnedView.addSubview(label)

        return returnedView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
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
