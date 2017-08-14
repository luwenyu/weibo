//
//  FindEmotion.swift
//  WeiBo_lu
//
//  Created by lu on 2017/8/2.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class FindEmotion: NSObject {
  
    //单利
    static let shanreInstance : FindEmotion = FindEmotion()
    
    fileprivate lazy var manager : EmotionManager = EmotionManager()
    
    func findAttrString(text : String?,font : UIFont) -> NSMutableAttributedString? {
        
        guard let text = text else {
            return nil
        }
        
        let pattern = "\\[.*?\\]"//匹配表情
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else{
            
            return nil
        }
        
        let results = regex.matches(in: text, options: [], range: NSMakeRange(0, text.characters.count))
        
        let attrMStr = NSMutableAttributedString(string: text)
        
        for i in (0..<results.count).reversed(){
        
            let result = results[i]
            let char : String = (text as NSString).substring(with: result.range)
            guard let pngPath = findPath(cha: char) else {
                return nil;
            }
            
            //创建属性字符串
            let attachment = NSTextAttachment()
            attachment.image = UIImage(contentsOfFile: pngPath)
            let font  = font
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let attrImageStr = NSAttributedString(attachment: attachment)
            //将属性字符串替换到原来的文字位置
            attrMStr.replaceCharacters(in: result.range, with: attrImageStr)
            
        }
        return attrMStr
        
        
        
    }
    
     func findPath(cha: String) -> String?{
    
        for page in manager.packages {
            
            for emotion in page.emoticons
            {
            
             
                if emotion.chs == cha {
                    return emotion.pngPath
                }
            }
        }
        return nil
        
    }
    
}
