//
//  EmotionCell.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/14.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class EmotionCell: UICollectionViewCell {
    var emotion : Emotion?{
     
        didSet{
            guard let em = emotion else {
                return
            }
            btn.setImage(UIImage.init(contentsOfFile: em.pngPath ?? ""), for: .normal)
            btn.setTitle(em.emojiCode, for: .normal)
            
            if em.isRemove{
                let norepatch = Bundle.main.path(forResource: "Contents/Resources/compose_emotion_delete@2x.png", ofType: nil, inDirectory: "HMEmoticon.bundle")
                btn.setImage(UIImage.init(contentsOfFile: norepatch!), for: .normal)

                

                
            }
        
        }
        
    }
    fileprivate var btn : UIButton = UIButton()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        contentView.addSubview(btn)
        btn.frame = contentView.bounds
        btn.isUserInteractionEnabled = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






