//
//  EmotionViewController.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/12.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

fileprivate let emotionCell = "emotionCell"

class EmotionViewController: UIViewController {
  
      fileprivate lazy var colletionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmotionCollectionCellLaout())
    fileprivate lazy var toolBar : UIToolbar = UIToolbar()
    fileprivate lazy var manager : EmotionManager = EmotionManager()
   
    var emotionCb : (_ emo : Emotion)->()
    
    //自定义构造函数
    init(emotionCallBack : @escaping (_ em : Emotion)->()) {
        self.emotionCb = emotionCallBack
        super.init(nibName:nil,bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }


}
extension EmotionViewController{

    //布局
    fileprivate func setUI()
    {
    
    view.addSubview(colletionView)
    view.addSubview(toolBar)
        
    colletionView.translatesAutoresizingMaskIntoConstraints = false
    toolBar.translatesAutoresizingMaskIntoConstraints = false
    
    let views = ["tBar" : toolBar,"cview" : colletionView] as [String : Any]
    var cons =   NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tBar]-0-|", options: [], metrics: nil, views: views)
        
    cons += cons + NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[cview]-0-[tBar]-0-|", options: [.alignAllLeft,.alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        
        setColletionView()
        setToolBar()
        
    }
    //colletionView
    fileprivate func setColletionView(){
    
    colletionView.register(EmotionCell.self, forCellWithReuseIdentifier: emotionCell)
   colletionView.dataSource = self as UICollectionViewDataSource
   colletionView.delegate = self
     colletionView.backgroundColor = UIColor.white
        
    }
    //表情
   fileprivate  func  setToolBar(){
    
        let titleArr = ["最近","默认","emoji","浪小花"]
        var index = 0
        var tempItems = [UIBarButtonItem]()
        
        for name in titleArr
        {
            
            let item : UIBarButtonItem = UIBarButtonItem(title: name, style: .plain, target: self, action: #selector(itemClick))
            item.tag = index

            index += 1
            tempItems.append(item)
            //弹簧间距
            tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
            
        }
        tempItems.removeLast()
        toolBar.items = tempItems
        toolBar.tintColor = UIColor.orange
    
        
    
    }
    func itemClick(item : UIBarButtonItem){
        
        let tag = item.tag
        let indexPath = NSIndexPath.init(row: 0, section: tag)
        colletionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: true)
        
        
    }

}
extension EmotionViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return manager.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let package = manager.packages[section]
        return  package.emoticons.count

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : EmotionCell = colletionView.dequeueReusableCell(withReuseIdentifier: emotionCell, for: indexPath) as! EmotionCell
        let pakage = manager.packages[indexPath.section]
        let emotion = pakage.emoticons[indexPath.item]
        cell.emotion = emotion
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pack = manager.packages[indexPath.section]
        let emotion = pack.emoticons[indexPath.item]
        insertRecentlyEmtion(emotion: emotion)
        emotionCb(emotion)
        
    }

    fileprivate func insertRecentlyEmtion(emotion : Emotion)
    {
    
        if emotion.isRemove  {
            return
        }
        //删除一个表情
        if manager.packages.first!.emoticons.contains(emotion)
        {
            let index = manager.packages.first?.emoticons.index(of: emotion)
            manager.packages.first?.emoticons.remove(at: index!)
            
            
            
        }
        else{
        
           manager.packages.first?.emoticons.remove(at: 19)
        }
        
        //插进最近分组
        manager.packages.first?.emoticons.insert(emotion, at: 0)
        colletionView.reloadData()
    
    }
    
}

class EmotionCollectionCellLaout: UICollectionViewFlowLayout {
    
    
    override func prepare() {
        super.prepare()
        
        let itemH  =  UIScreen.main.bounds.width/7
        itemSize = CGSize(width: itemH, height: itemH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        
        let insetMargin = ((collectionView?.bounds.height)!-3*itemH)/2
           collectionView?.contentInset = UIEdgeInsetsMake(insetMargin, 0, insetMargin, 0)
        
        
        
    }
  
    
}



