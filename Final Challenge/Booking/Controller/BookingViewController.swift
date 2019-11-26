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
    
    let datePickerKeyboard = UIDatePicker()
    let dateFormatter = DateFormatter()
    var dateString = ""
    var sportCenterName = ""
    var bookingCourt:BookingCourt?
    var bookingModel = BookingModel()
    let cellIdentifier = "CourtTableViewCell"
    let url = URL(string: "\(BaseURL.baseURL)api/sport-center/courts/schedule")
    
    var getSportTypeID, getSportCenterID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateString = dateFormatter.string(from: datePickerKeyboard.date)
        getData()
        title = sportCenterName
        tableView.delegate = self
        tableView.dataSource = self
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateField.text = dateFormatter.string(from: datePickerKeyboard.date)
        datePicker.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.datePickerTap))
        self.datePicker.addGestureRecognizer(gesture)
        setDatePicker()
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    @objc func datePickerTap(sender : UITapGestureRecognizer) {
        dateField.becomeFirstResponder()
    }
    
    func setDatePicker(){
        datePickerKeyboard.datePickerMode = .date
        dateField.inputView = datePickerKeyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let submitButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(submitTapped))
        toolbar.setItems([submitButton], animated: true)
        dateField.inputAccessoryView = toolbar
    }
    
    @objc func submitTapped(){
        dateField.text = dateFormatter.string(from: datePickerKeyboard.date)
        dateFormatter.dateFormat = "YYYY-mm-dd"
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
    
}

extension BookingViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let totalCourt = bookingCourt?.sportCenterDetail.count else {
            return 0
        }
        return totalCourt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CourtTableViewCell
        cell.courtName.text = bookingCourt!.sportCenterDetail[indexPath.row].courtName
        cell.courtDayPrice.text = "Rp. "+bookingCourt!.sportCenterDetail[indexPath.row].courtPriceDay
        cell.courtNightPrice.text = "Rp. "+bookingCourt!.sportCenterDetail[indexPath.row].courtPriceNight
        cell.courtId = bookingCourt!.sportCenterDetail[indexPath.row].courtID
        cell.getTotalTime(totalTime: calcTotalTime(), startTime: bookingCourt!.sportCenterOpenTime)
        cell.collectionView.reloadData()
        return cell
    }
    
    
}


