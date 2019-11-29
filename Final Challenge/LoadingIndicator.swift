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
        view = UIView(frame: mainView!.bounds)
        view?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view!.center
        indicator.startAnimating()
        view!.addSubview(indicator)
        mainView!.addSubview(view!)
    }
    
    func removeLoading(){
        view!.removeFromSuperview()
        view = nil
    }
    
    
}
