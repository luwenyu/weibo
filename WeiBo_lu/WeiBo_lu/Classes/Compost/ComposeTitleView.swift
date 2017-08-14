//
//  ComposeTitleView.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/11.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class ComposeTitleView: UIView {

     lazy var titleLab : UILabel = UILabel()
     lazy var nameLab : UILabel =  UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension ComposeTitleView{


    func setUI() {
      
        addSubview(titleLab)
        addSubview(nameLab)
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        nameLab.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(titleLab.snp.centerX)
            make.top.equalTo(titleLab.snp.bottom).offset(3)

        }
        
        titleLab.font = UIFont.systemFont(ofSize: 16)
        nameLab.font = UIFont.systemFont(ofSize: 14)
        nameLab.textColor = UIColor.lightGray
        titleLab.text = "发微博"
        nameLab.text = UserAccountTool.shareIntance.accountModel?.screen_name
        
    }

}
