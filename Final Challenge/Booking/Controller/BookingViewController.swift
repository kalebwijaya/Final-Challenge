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
    var sportCenterName = ""
    var bookingCourt:BookingCourt!
    let cellIdentifier = "CourtTableViewCell"
    let url = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = sportCenterName
        getData()
//        tableView.delegate = self
//        tableView.dataSource = self
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateField.text = dateFormatter.string(from: datePickerKeyboard.date)
        self.view.endEditing(true)
    }
    
    func getData(){
        guard let jsonUrl = url else {return}
        URLSession.shared.dataTask(with: jsonUrl) {(data,response, error) in
            guard let data = data, error == nil, response != nil else {
                print("URL Error")
                return
            }
            do {
                let result = try JSONDecoder().decode(BookingCourtResult.self, from: data)
                if(result.errorCode == "200"){
                    self.bookingCourt = result.data
                    print("JSON Get")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }else if(result.errorCode == "400"){
                    print(result.errorMessage)
                }
            } catch {
                print("Error After Getting JSON")
            }
        }.resume()
    }
    
}

extension BookingViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookingCourt.sportCenterDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CourtTableViewCell
        cell.courtName.text = bookingCourt.sportCenterDetail[indexPath.row].courtName
        cell.courtDayPrice.text = "Rp. "+bookingCourt.sportCenterDetail[indexPath.row].courtPriceDay
        cell.courtNightPrice.text = "Rp. "+bookingCourt.sportCenterDetail[indexPath.row].courtPriceNight
        cell.courtId = bookingCourt.sportCenterDetail[indexPath.row].courtID
        cell.courts = bookingCourt.sportCenterDetail
        cell.collectionView.reloadData()
        return cell
    }
    
    
}


