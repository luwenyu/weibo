//
//  ButtonExten.swift
//  WeiBo
//
//  Created by lu on 17/6/8.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit
extension UIButton{

    convenience init(imageName:String,bgImageName:String) {
        self.init()

        setBackgroundImage(UIImage(named:bgImageName), for: .normal)
        setBackgroundImage(UIImage(named:bgImageName+"_highlighted"), for: .highlighted)
        setImage(UIImage(named:imageName), for: .normal)
        setImage(UIImage(named:imageName+"_highlighted"), for: .highlighted)
        sizeToFit()
        
    }

}
