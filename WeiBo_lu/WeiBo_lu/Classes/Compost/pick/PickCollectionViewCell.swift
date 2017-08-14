//
//  PickCollectionViewCell.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/12.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class PickCollectionViewCell: UICollectionViewCell {
    
    fileprivate lazy var addBtn = UIButton()
    fileprivate lazy var xBtn = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
          addBtn.frame = self.bounds
        addBtn.setBackgroundImage(UIImage(named:"compose_pic_add"), for: .normal)
        addBtn.setBackgroundImage(UIImage(named:"compose_pic_add_highlighted"), for: .highlighted)
        addSubview(addBtn)
        xBtn.frame = CGRect(x: self.bounds.width-24, y: 0, width: 24, height: 24)
        addSubview(xBtn)
        xBtn.setBackgroundImage(UIImage(named:"compose_photo_close"), for: .normal)

      
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
