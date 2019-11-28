//
//  Loading.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 28/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation
import UIKit

final class Load {
    static var shared = Load()
    
    private init() {}
    let alert = UIAlertController(title: nil, message: "Please wait ...", preferredStyle: .alert)
    func showLoad() -> UIAlertController {
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
    
        return alert
    }
    
    func dismissLoad() {
        alert.dismiss(animated: true, completion: nil)
        alert.removeFromParent()
    }
    
    
}
