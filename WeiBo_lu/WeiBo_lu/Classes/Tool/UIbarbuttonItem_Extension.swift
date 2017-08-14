//
//  UIbarbuttonItem_Extension.swift
//  WeiBo
//
//  Created by lu on 17/6/21.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

    convenience init(imageName:String) {
        
        self.init()
        
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName+"_highlighted"), for: .highlighted)
        btn.sizeToFit()
        self.customView = btn
        
        
    }

}
