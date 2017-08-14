//
//  EmotionPack.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/13.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class EmotionPack: NSObject {

    var emoticons : [Emotion] = [Emotion]()
    
     init(id : String)
     {
        
        //最近表情
        if id == ""{
            for i in 0..<21 {
                
                let dic = ["":""]

                //添加删除表情
                if i==20 {
                  emoticons.append(Emotion(isRemove: true))
                }
                else{
                    emoticons.append(Emotion(dict:dic))

                }
            
                
            }
        
         return
        }
        
        //根据id凭借info.plist路径
        let listpatch = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "HMEmoticon.bundle")
        
        let arr = (NSArray(contentsOfFile: listpatch!))! as! [[String : String]]
       
      
        //遍历数组
        var index = 0
        
        
        for var dic in arr {
            if let png = dic["png"]{
             
                dic["png"] = id + "/" + png
            }
            
            emoticons.append(Emotion(dict: dic))
            index += 1
            if index==20 {
                
                //添加删除表情
            emoticons.append(Emotion(isRemove: true))
                index = 0
            }
        }
        
        
        
        
    }
}
