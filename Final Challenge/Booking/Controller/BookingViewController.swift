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
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    let datePickerKeyboard = UIDatePicker()
    let dateFormatter = DateFormatter()
    var tableCellHeight = 0
    var totalPrice = 0
    var totalPricePerCourt = [Int:Int]()
    var dateString = ""
    var sportCenterName = ""
    let userID = "1423556093315144139"
    var bookingCourt:BookingCourt?
    var bookingModel = BookingModel()
    let cellIdentifier = "CourtTableViewCell"
    let url = URL(string: "\(BaseURL.baseURL)api/sport-center/courts/schedule")
    let urlBook = URL(string: "\(BaseURL.baseURL)api/sport-center/courts/book")
    var bookParamDetail = [Int:BookParamDetail]()
    
    var getSportTypeID, getSportCenterID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        getData()
        title = sportCenterName
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    @objc func datePickerTap(sender : UITapGestureRecognizer) {
        dateField.becomeFirstResponder()
    }
    
    func setDatePicker(){
        datePicker.isUserInteractionEnabled = true
        datePickerKeyboard.datePickerMode = .date
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.datePickerTap))
        self.datePicker.addGestureRecognizer(gesture)
        dateField.inputView = datePickerKeyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let submitButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(submitTapped))
        toolbar.setItems([submitButton], animated: true)
        dateField.inputAccessoryView = toolbar
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateString = dateFormatter.string(from: datePickerKeyboard.date)
        dateField.text = dateFormatter.string(from: datePickerKeyboard.date)
    }
    
    @objc func submitTapped(){
        dateField.text = dateFormatter.string(from: datePickerKeyboard.date)
        dateString = dateFormatter.string(from: datePickerKeyboard.date)
        getData()
        self.view.endEditing(true)
    }
    
    func getData(){
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
        if(totalPrice != 0){
            guard let jsonUrl = urlBook, let sportTypeID = getSportTypeID, let sportCenterID = getSportCenterID else {return}
            
            var bookParamDetail = [BookParamDetail]()
            for n in 0 ..< self.bookParamDetail.count{
                bookParamDetail.append(self.bookParamDetail[n]!)
            }
            
            let sendParam = BookingParam(bookDate: dateString, userID: userID, sportCenterID: sportCenterID, bookInput: bookParamDetail)
            
            bookingModel.sendBookingRequest(url: jsonUrl, setBodyParam: sendParam){ (result, error) in
                if let result = result{
                    if(result.errorCode == "200"){
                        print("Book Success")
                        print(result.data.bookID)
                        //TINGGAL SEGUE
                    }else if(result.errorCode == "400"){
                        print(result.errorMessage)
                    }
                }else if let error = error {
                    print(error)
                }
            }
        }
    }
    
}

