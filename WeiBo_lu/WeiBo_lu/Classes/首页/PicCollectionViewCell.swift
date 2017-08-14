//
//  PicCollectionViewCell.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/6.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class PicCollectionViewCell: UICollectionViewCell {
    
    var url:URL?{
      
        didSet{
            
            guard let url = url else {
                return
            }
           imgView.sd_setImage(with: url, placeholderImage: nil)
        
        }
    
    }
    
    @IBOutlet weak var imgView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
