//
//  TitltBuuton.swift
//  WeiBo
//
//  Created by lu on 17/6/21.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class TitltBuuton: UIButton {

    override init(frame: CGRect) {
        super.init(frame:frame)
        setImage(UIImage(named:"navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named:"navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()
    }
    
    //swift规定:重写控件必须实现以下方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 5
        
    }
  
}
