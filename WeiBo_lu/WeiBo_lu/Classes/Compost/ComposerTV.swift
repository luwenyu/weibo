//
//  ComposerTV.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/11.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class ComposerTV: UITextView {

    lazy var placeLab : UILabel = UILabel()
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setUI()
    }

}

extension ComposerTV{

    func setUI() {
        
        addSubview(placeLab)
        placeLab.snp.makeConstraints { (makr) in
            
            makr.top.equalTo(8)
            makr.left.equalTo(5)
            
        }
        placeLab.textColor = UIColor.lightGray
        placeLab.font = font
        placeLab.text = "分享新鲜事..."
        
        //tectview内边距
        textContainerInset = UIEdgeInsetsMake(8, 7, 0, 7)
        
    }

}
