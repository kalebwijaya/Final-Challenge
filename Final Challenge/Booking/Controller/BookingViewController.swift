//
//  BookingViewController.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 22/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var datePickerKeyboard = UIDatePicker.init()
    let toolbar = UIToolbar()
    var toolBar = UIToolbar()
    let dateFormatter = DateFormatter()
    var tableCellHeight = 0
    var totalPrice = 0
    var totalPricePerCourt = [Int:Int]()
    var dateString = ""
    var sportCenterName = ""
    var userID = ""
    var bookingCourt:BookingCourt?
    var bookingModel = BookingModel()
    let cellIdentifier = "CourtTableViewCell"
    let url = URL(string: "\(BaseURL.baseURL)api/sport-center/courts/schedule")
    let urlBook = URL(string: "\(BaseURL.baseURL)api/sport-center/courts/book")
    let currencyFormatter = NumberFormatter()
    var bookParamDetail = [Int:BookParamDetail]()
    
    var getSportTypeID, getSportCenterID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.778283298, blue: 0.4615219235, alpha: 1)
        if(UserDefaults.standard.bool(forKey: "sudahLogin") == false)
        {
            
        }
        else
        {
        userID = UserDefaults.standard.string(forKey: "id")!
        print("ID : " + userID + " From Booking")
        }
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.groupingSeparator = "."
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.locale = Locale(identifier: "id_ID")
        setDatePicker()
        getData()
        title = sportCenterName
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    @objc func datePickerTap(sender : UITapGestureRecognizer) {
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        components.day = 7
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        datePickerKeyboard.datePickerMode = .date
        datePickerKeyboard.maximumDate = maxDate
        datePickerKeyboard.minimumDate = minDate
        
        datePickerKeyboard.backgroundColor = UIColor.white
        
        datePickerKeyboard.autoresizingMask = .flexibleWidth
        datePickerKeyboard.datePickerMode = .date
        
        datePickerKeyboard.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePickerKeyboard)
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        //        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Pick", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonClick() {
        dateLabel.text = dateFormatter.string(from: datePickerKeyboard.date)
        dateString = dateFormatter.string(from: datePickerKeyboard.date)
        getData()
        totalPrice = 0
        self.totalPriceLabel.text = "Rp. " + currencyFormatter.string(from: NSNumber(value: self.totalPrice))!
        self.view.endEditing(true)
        toolBar.removeFromSuperview()
        datePickerKeyboard.removeFromSuperview()
    }
    
    func setDatePicker(){
        datePicker.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.datePickerTap))
        self.datePicker.addGestureRecognizer(gesture)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateString = dateFormatter.string(from: datePickerKeyboard.date)
        dateLabel.text = dateFormatter.string(from: datePickerKeyboard.date)
    }
    
    func getData(){
        //        self.present(loadingView, animated: true, completion: nil)
        guard let jsonUrl = url, let sportTypeID = getSportTypeID, let sportCenterID = getSportCenterID else {return}
        let getParam = BookingViewParam(sportTypeID: sportTypeID, sportCenterID: sportCenterID, date: dateString)
        bookingModel.getBookingView(url: jsonUrl, setBodyParam: getParam) { (result, error) in
            if let result = result{
                if(result.errorCode == "200"){
                    self.bookingCourt = result.data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }else if(result.errorCode == "400"){
                    print(result.errorMessage)
                }
            }else if let error = error {
                print(error)
            }
        }
    }
    
    func calcTotalTime() -> Int{
        let startTime = bookingCourt!.sportCenterOpenTime.prefix(2)
        let endTime = bookingCourt!.sportCenterClosedTime.prefix(2)
        let hours = Int(endTime)! - Int(startTime)!
        return Int(hours)
    }
    
    
    @IBAction func bookNowBtn(_ sender: Any) {
        
        if(UserDefaults.standard.bool(forKey: "sudahLogin") == true){
        if(totalPrice != 0){
            guard let jsonUrl = urlBook, let sportCenterID = getSportCenterID else {return}
            
            var bookParamDetail = [BookParamDetail]()
            for n in 0 ... self.bookParamDetail.count{
                if(self.bookParamDetail[n] != nil){
                    bookParamDetail.append(self.bookParamDetail[n]!)
                }
            }
            
            let sendParam = BookingParam(bookDate: dateString, userID: userID, sportCenterID: sportCenterID, bookInput: bookParamDetail)
            
            bookingModel.sendBookingRequest(url: jsonUrl, setBodyParam: sendParam){ (result, error) in
                if let result = result{
                    if(result.errorCode == "200"){
                        print("Book Success")
                        print(result.data.bookID)
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        DispatchQueue.main.async {
                            let vc = storyboard.instantiateViewController(identifier: "mainTab") as? UITabBarController
                            vc?.selectedIndex = 1
                            vc?.navigationItem.setHidesBackButton(true, animated: true)
                            vc?.modalPresentationStyle = .fullScreen
                            self.present(vc!,animated: false)
                        }
                        
                    }else if(result.errorCode == "400"){
                        print(result.errorMessage)
                    }
                }else if let error = error {
                    print(error)
                }
            }
            }
            
        }
        
        else
        {
            let alertController = UIAlertController(title: "Log In to book court", message: "You need to log in first to book the court.", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Login", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                self.performSegue(withIdentifier: "bookToLogin", sender: self)
                
            }
                  
                 
              let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                     UIAlertAction in
                     NSLog("Cancel Pressed")
                  
                 }

                 // Add the actions
                 alertController.addAction(okAction)
                 alertController.addAction(cancelAction)
                
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}

