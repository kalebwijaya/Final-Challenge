//
//  LoadingIndicator.swift
//  Final Challenge
//
//  Created by Steven on 11/29/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation
import UIKit

class LoadingIndicator{
    private var view: UIView?
    private var mainView: UIView?
    init(loadingView: UIView, mainView: UIView) {
        self.view = loadingView
        self.mainView = mainView
    }
    
    func showLoading(){
        guard let mainView = mainView else{
            return
        }
        view = UIView(frame: mainView.bounds)
        guard let viewLoading = view else{
            return
        }
        viewLoading.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = viewLoading.center
        indicator.startAnimating()
        viewLoading.addSubview(indicator)
        mainView.addSubview(viewLoading)
    }
    
    func removeLoading(){
        guard let view = view else{
            return
        }
        view.removeFromSuperview()
        self.view = nil
    }
    
    
}
