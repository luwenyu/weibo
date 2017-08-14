//
//  UItextView-Extension.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/24.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

extension UITextView{

//扩展textView
    
    //给textView插进表情
    func insertEmotion(em : Emotion) {
        
        //if isEmpty return
        
        if em.isRemove{
            
            deleteBackward()
            return
            
        }
        
        //1emoji 表情
        if em.emojiCode != nil{
            
            //获取光标所在位置
            let textRange = selectedTextRange!
            
            replace(textRange, withText: em.emojiCode!)
            return
            
        }
        //2普通表情:图文混排
        //2.1根据图片路径创建属性字符串
        let attachment : EmoNSTextAttachment = EmoNSTextAttachment()
        attachment.chs = em.chs
        attachment.image = UIImage(contentsOfFile: em.pngPath!)
        let font = self.font!
        //图片大小和文字一样大
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attrImageStr = NSAttributedString(attachment: attachment)
        
        //2.2创建可变属性字符串
        let attrMStr = NSMutableAttributedString(attributedString: attributedText)
        
        //2.3将图片属性字符串替换到可变属性字符串的某一个位置
        let range = selectedRange
        attrMStr.replaceCharacters(in: range, with: attrImageStr)
        
        // 显示
        attributedText = attrMStr
        self.font = font
        
        //将光标设置回到原来的位置+1
        selectedRange = NSRange.init(location: range.location+1, length: 0)
        

        
    }
    
    //获取textView属性字符串,对应的表情字符串
    func getEmotionString() -> String {
        
        //1获取属性字符串
        let attrMstr = NSMutableAttributedString(attributedString: self.attributedText)
        //2遍历属性字符串
        let range = NSRange.init(location: 0, length: attrMstr.length)
        attrMstr.enumerateAttributes(in: range, options: []) { (dic, range, _) in
            
            if let attachment = dic["NSAttachment"] as? EmoNSTextAttachment{
                
                attrMstr.replaceCharacters(in: range, with: attachment.chs!)
                
            }
            
        }
        
        return attrMstr.string

        
    }
  
}
