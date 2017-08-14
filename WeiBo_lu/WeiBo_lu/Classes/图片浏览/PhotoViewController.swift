//
//  PhotoViewController.swift
//  WeiBo_lu
//
//  Created by lu on 2017/8/8.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

fileprivate let cellID = "cell"
class PhotoViewController: UIViewController {

    var indexp:IndexPath
    var picURL:[URL]
    
    fileprivate lazy var  colletionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: potoLayout())
    fileprivate lazy var saleBtn : UIButton = UIButton()
    fileprivate lazy var closeBtn : UIButton = UIButton()
    
    
    init(indexpa : IndexPath,picURL : [URL]) {
        
        self.indexp = indexpa
        self.picURL = picURL
        
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = UIColor.white
        view.frame.size.width += 20
        setUI()

    }

 

}

extension PhotoViewController {

    func setUI(){
        view.addSubview(colletionView)
        view.addSubview(saleBtn)
        view.addSubview(closeBtn)
        colletionView.frame = view.bounds
        colletionView.isPagingEnabled = true
        closeBtn.snp.makeConstraints { (mark) in
            mark.left.equalTo(view.snp.left)
            mark.size.equalTo(CGSize(width: 90, height: 32))

            mark.bottom.equalTo(view.snp.bottom)
            
        }
        saleBtn.snp.makeConstraints { (make) in
            
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
            make.size.equalTo(CGSize(width: 90, height: 32))
        }
        closeBtn.backgroundColor = UIColor.darkGray
        closeBtn.setTitle("关闭", for: .normal)
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        saleBtn.backgroundColor = UIColor.darkGray
        saleBtn.setTitle("保存", for: .normal)
        saleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        saleBtn.addTarget(self, action: #selector(saleActon), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(closeActon), for: .touchUpInside)

        
        colletionView.register(PhotoCell.self, forCellWithReuseIdentifier: cellID)
        colletionView.dataSource = self
        colletionView.delegate = self
        
        
        colletionView.scrollToItem(at: indexp as IndexPath, at: .left, animated: false)

    }
    
}

extension PhotoViewController{

    func saleActon() {
        
        let  cell: PhotoCell = colletionView.visibleCells.first as! PhotoCell
        
        guard let image = cell.imageView.image else {
            return
        }
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
    }
    
    func closeActon() {
        
        dismiss(animated: true, completion: nil)
    }

}

extension PhotoViewController : UICollectionViewDataSource,UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURL.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  cell : PhotoCell = collectionView .dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PhotoCell
        cell.pikURL = picURL[indexPath.row]
        cell.delegate = self
        return cell
        
    }
    
    

}
//MARK: 遵守代理执行代理方法
extension PhotoViewController : photDelegate{

    func imageViewClick()
    {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: 遵守动画代理
extension PhotoViewController : AnimalDismissDelegate{
  
    func indexpath() -> NSIndexPath {
       
        let cell = colletionView.visibleCells.first
        return colletionView.indexPath(for: cell!)! as NSIndexPath
        
    }
    func imageview() -> UIImageView {
        
        let imageView = UIImageView()
        let cell = colletionView.visibleCells.first as! PhotoCell
        imageView.frame = cell.imageView.frame
        imageView.image = cell.imageView.image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
        
    }
    
}

class potoLayout: UICollectionViewFlowLayout {
    override func prepare()
    {
        itemSize = (collectionView?.frame.size)!
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.horizontal
        
        
    }
    
}
