//
//  CircularBarButton.swift
//  Final Challenge
//
//  Created by Steven on 11/29/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation
import UIKit
class CircularBarButton: UIView{
    var imageView: UIImageView!
    var button: UIButton!
    
    convenience init(image: UIImage? = nil, frame: CGRect = CGRect(x: 0, y: 0, width: 40, height: 40)){
        self.init(frame: frame)
        
        imageView = UIImageView(frame: frame)
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = frame.height/2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        button = UIButton(frame: frame)
        button.backgroundColor = .clear
        button.setTitle("", for: .normal)
        addSubview(button)
        
        imageView.image = image
    }
    
    func load()-> UIBarButtonItem {
        return UIBarButtonItem(customView: self)
    }
}
