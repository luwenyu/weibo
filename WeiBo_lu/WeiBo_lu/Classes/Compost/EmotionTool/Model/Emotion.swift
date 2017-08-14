//
//  Emotion.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/13.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class Emotion: NSObject {

    var png :String? {
    
        didSet{
        
        
            guard let png = png else {
                
                return
            }
            
            pngPath = Bundle.main.resourcePath! + "/HMEmoticon.bundle/" + png
        }
    
    }  //普通表情对应的图片名
    var chs :String?   //普通表情对应的文字
    var code :String? //emoji的code
    {
    
        
        didSet{
        
            guard let code = code else {
                
                return
            }
            //  创建扫描器
            let scanner = Scanner(string: code)
            
            // 调用方法 扫描code的值
            var valure : UInt32 = 0
            scanner.scanHexInt32(&valure)
            
            //将value转成字符
            let c  = Character.init(UnicodeScalar(valure)!)
            
            //将字符转成字符串
            emojiCode = String(c)
            
            
            
            
        
        }
    
    }
    
    //数据处理
    var pngPath : String?
    var emojiCode : String?
    var isRemove : Bool = false
    
    

    
    init(dict : [String :String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    init(isRemove : Bool) {
        
        self.isRemove = isRemove
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String{
        
        //重写des属性
        return dictionaryWithValues(forKeys: ["pngPath","emojiCode","chs"]).description
    }
    
    
    
}
