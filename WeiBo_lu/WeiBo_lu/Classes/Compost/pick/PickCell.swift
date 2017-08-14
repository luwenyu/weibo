//
//  PickCell.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/12.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class PickCell: UICollectionViewCell {
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var xBtn: UIButton!
    var image : UIImage?{
    
        didSet{
        
            if image != nil {
                imageView.image = image
                addBtn.isUserInteractionEnabled = false
                xBtn.isHidden = false
            }else{
                imageView.image = nil
                addBtn.isUserInteractionEnabled = true
                xBtn.isHidden = true



            }
            
        
        }
    
    }
    
    @IBAction func addPoto(_ sender: Any) {
        
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PICK), object: nil)
        
        
        
    }

    
    @IBAction func removePoto(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: RPICK), object: imageView.image)

    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
