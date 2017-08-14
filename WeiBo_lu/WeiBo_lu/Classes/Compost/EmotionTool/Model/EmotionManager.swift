//
//  EmotionManager.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/13.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class EmotionManager: NSObject {

    var packages : [EmotionPack] = [EmotionPack]()
    
    override init() {
        
        //1最近表情包
        packages.append(EmotionPack(id: ""))
        //2默认表情包
        packages.append(EmotionPack(id: "Contents/Resources/default"))
        //3emoji表情包
        packages.append(EmotionPack(id: "Contents/Resources/emoji"))
        //4浪小花表情包
        packages.append(EmotionPack(id: "Contents/Resources/lxh"))

        
    }
    
    
    
    
   
    
}
