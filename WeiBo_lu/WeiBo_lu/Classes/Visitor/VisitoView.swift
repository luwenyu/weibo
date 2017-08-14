//
//  VisitoView.swift
//  WeiBo
//
//  Created by lu on 17/6/8.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit




class VisitoView: UIView {

    @IBOutlet weak var rotationImage: UIImageView!

    @IBOutlet weak var tipLab: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    func setupVisiView(iconName:String, title:String) {
        
        iconImageView.image = UIImage(named: iconName);
        tipLab.text = title
        rotationImage.isHidden = true
    
        
      
    }
    
    
    func addRotation() {
       
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = 0
        animation.toValue =  M_PI * 2
        animation.duration  = 5;
        animation.autoreverses = false;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = 500;
        animation.isRemovedOnCompletion = false
        rotationImage.layer.add(animation, forKey: nil)
        
        
    }
}
