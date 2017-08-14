//
//  ComposeViewController.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/10.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController,UITextViewDelegate {
    
    fileprivate lazy var images : [UIImage] = [UIImage]()
    fileprivate lazy var emotionVC : EmotionViewController = EmotionViewController { (emoton : Emotion) in
        self.insertEmotion(em: emoton)
    
       
        
    }
    @IBOutlet weak var collecionPickView: PickView!
    @IBOutlet weak var bottom: NSLayoutConstraint!

    @IBOutlet weak var textView: ComposerTV!
    lazy var titleView : ComposeTitleView = ComposeTitleView()
    
    @IBOutlet weak var collectionViewH: NSLayoutConstraint!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        
        //监听键盘弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        //选择照片
        NotificationCenter.default.addObserver(self, selector: #selector(chosePoto), name: NSNotification.Name(rawValue: PICK), object: nil)
        //删除照片
        NotificationCenter.default.addObserver(self, selector: #selector(removePoto), name: NSNotification.Name(rawValue: RPICK), object: nil)

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
        
    }

 

}
extension ComposeViewController{

    func setNavigation() {
        
        
       navigationItem.leftBarButtonItem = UIBarButtonItem(title: " 关闭", style: .plain, target: self, action: #selector(close))
       navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(send))
        navigationItem.rightBarButtonItem?.isEnabled = false
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        navigationItem.titleView = titleView
    }
    
    
    func close() {
        
        dismiss(animated: true, completion: nil)
        
        
    }
    //MARK:----发布说说
    func send() {
        
         let text  =  textView.getEmotionString()
        
        let finishCallBack = { (suceess : Bool)->() in
            if !suceess{
                SVProgressHUD .showError(withStatus: " 发送微博失败")
                return
            }
            SVProgressHUD .showSuccess(withStatus: " 发送微博成功")
            self.dismiss(animated: true, completion: nil)
            

            
        }
        
        
        if let image = images.first {
            
            NetworkTools.shareInstance.sendStatus(text: text, image: image, isSuccess:finishCallBack)
        }
        else{
        
            NetworkTools .shareInstance.send(text: text,isSuccess:finishCallBack)
            
        }
        
        
        
    }
    func keyboardWillChange(note : NSNotification) {
        
        
        //键盘弹出消失的时间
        let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        //键盘最终的y值
        let endFrame = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        
        //计算工具栏距离底部间距
        let margin = UIScreen.main.bounds.height-y
        bottom.constant = margin
        UIView.animate(withDuration: duration) { 
            self.view.layoutIfNeeded()
        }

        
    }
    
    //选择图片
    @IBAction func pickAction(_ sender: Any) {
        
        self.textView .resignFirstResponder()
        collectionViewH.constant = UIScreen.main.bounds.height*0.65
        UIView.animate(withDuration: 0.5) { 
            
            self.view.layoutIfNeeded()
        }
    }
    //MARK:-****选择表情
    @IBAction func emotiAction(_ sender: Any) {
        
       textView.resignFirstResponder()
       textView.inputView =  textView.inputView != nil ? nil : emotionVC.view
        textView.becomeFirstResponder()
        
//        let emotion = EmotionManager()
//        for hehe in emotion.packages {
//            for em in hehe.emoticons {
//                print(em)
//
//            }
//        }
        
        
        
    }
    
    
    

}
//MARK:--  选择删除照片

extension ComposeViewController
{

    func chosePoto() {
        
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        let ipc = UIImagePickerController()
        ipc.sourceType = .photoLibrary
        ipc.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(ipc, animated:true, completion: nil)
        
        
    }
    
    func removePoto(note : NSNotification) {
        
        guard let image = note.object as? UIImage else {
            
            return
        }
        guard let index = images.index(of: image) else {
            return
        }
        print(index)
        images.remove(at:index)
        
        collecionPickView.images = images
        collecionPickView.reloadData()
        
    }


}

//MARK:--uiimagepickcontroller代理
extension ComposeViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as!UIImage
        images.append(image)
        collecionPickView.images = images;
        collecionPickView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    
    }
}
//MARK:--textView 代理
extension ComposeViewController{



    func textViewDidChange(_ textView: UITextView) {
        
        self.textView.placeLab.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textView.placeLab.isHidden = true
        self.textView.resignFirstResponder()
    }

}

//MARK:-插进表情
extension ComposeViewController{

    fileprivate func insertEmotion(em : Emotion){
    
        textView.insertEmotion(em: em)
        self .textViewDidChange(textView)
       
    }

}


