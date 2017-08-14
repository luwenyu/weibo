//
//  HomeViewController.swift
//  WeiBo
//
//  Created by lu on 17/6/8.
//  Copyright © 2017年 lu. All rights reserved.
//
///2222
import UIKit


class HomeViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate{

    
    @IBOutlet weak var Mytableview: UITableView!
    
    lazy var tipLab : UILabel = UILabel()
    lazy var titleBtn  : TitltBuuton = TitltBuuton()
    lazy var pickCollectionView : PicCollectionView = PicCollectionView()

    lazy var animal : PopAnimal = PopAnimal {[weak self] (ispresent) in
        self?.titleBtn.isSelected = ispresent
    }
    lazy var pAnimal : PhotoAnimal = PhotoAnimal() //转场
    
    lazy var statusesArr : [StatuesTool]  = [StatuesTool]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viView.addRotation()
        // 没有登陆
        if !isLogin{
          return
        }
        //设置nav
        Nav()
        //请求数据
       // loadDatas()
        //初始化tableview
        iniTablview()
        Mytableview.header.beginRefreshing()
       
       //提示lable
        settipLab()
        setNotice()
        
    }

}
//MARK:-UI
extension HomeViewController
{

      func Nav()
    {
    
        // 左边item
//          let leftBtn = UIButton()
//        leftBtn.setImage(UIImage(named:"navigationbar_friendsearch"), for: .normal)
//        leftBtn.setImage(UIImage(named:"navigationbar_friendsearch_highlighted"), for: .highlighted)
//        leftBtn.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch");
        
        //右边item
        
//        let rightBtn = UIButton()
//        rightBtn.setImage(UIImage(named:"navigationbar_pop"), for: .normal)
//        rightBtn.setImage(UIImage(named:"navigationbar_pop_highlighted"), for: .highlighted)
//        rightBtn.sizeToFit()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        //titleView
        
        titleBtn.setTitle("name", for: .normal)
        navigationItem.titleView = titleBtn
        titleBtn.addTarget(self, action: #selector(HomeViewController.titleBtnClick(tBtn:)), for: .touchUpInside)
        

    }
    
    func settipLab() {
        view.insertSubview(tipLab, belowSubview: (navigationController?.navigationBar)!)
        tipLab.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 32)
        tipLab.backgroundColor = UIColor.orange
        tipLab.textColor = UIColor.white
        tipLab.isHidden = true
        tipLab.font = UIFont.systemFont(ofSize: 14)
        tipLab.textAlignment = NSTextAlignment.center
    }


}

//MARK:--事件监听
extension HomeViewController{

   @objc fileprivate func titleBtnClick(tBtn:TitltBuuton) {
    print(tBtn.currentTitle!)
    tBtn.isSelected = !tBtn.isSelected
    
    //弹出控制器
    let vc  = PopViewController()
    //设置控制器modal样式 不移除其他控制器
    vc.modalPresentationStyle = .custom
    //转场代理
    vc.transitioningDelegate = animal
    animal.presentFame = CGRect(x:UIScreen.main.bounds.size.width*0.5-90, y: 64, width: 180, height: 250)
    self.present(vc, animated: true, completion: nil)
    
    NetworkTools.shareInstance.requst(RequestType: .POST, URLString: "http://httpbin.org/post", parameters: ["age" : "18"]) { (result, error) in
        
        if error != nil{
           print("=======",error!)
            return
        }
        print(result!)
    }
    
   
    }
    

}
//MARK:---请求数据
extension HomeViewController{


    func loadDatas(isNewData: Bool) {
        
        //1获取since_id
        var  since_id = 0
        var max_id = 0
        
        if isNewData {
            since_id = statusesArr.first?.status?.mid ?? 0
        }
        else{
          //如果没值给0
            max_id = statusesArr.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id-1)
        }
        
        
        NetworkTools.shareInstance.loadStatule(max_id: max_id,since_id: since_id) { (result, error) in
            
            if error != nil{
            print(error!)
            return
            }
            guard let result = result else{
            
              return
            }
        var tempModelArr = [StatuesTool]()
        for dic in result
        {
            
            let model = StatuesModel(dic: dic)
            let sModel = StatuesTool.init(statusModel: model)
            self.statusesArr.append(sModel)
            tempModelArr.append(sModel)
            
        }
            self.statusesArr = tempModelArr + self.statusesArr
            
            //缓存图片
            self.cachaimage(modelArr: tempModelArr)
            
            
        }
    }
    
   private func cachaimage(modelArr : [StatuesTool] ) {
    //创建goup   完成所有异步下载后 再刷新tableview
    let group = DispatchGroup.init()
    
    for model in modelArr{
    
        for picUrl in model.picURLs {
            
             group.enter()
            SDWebImageManager.shared().downloadImage(with: picUrl, options: [], progress: nil, completed: { (_, _, _, _, _) in
                
                group.leave()
            })
        }
    }
    group.notify(queue: DispatchQueue.main) {
        
        self.Mytableview.reloadData()
        self.Mytableview.header.endRefreshing()
        self.Mytableview.footer.endRefreshing()
        self.showTipLable(count: modelArr.count)
        

    }
    
    
    }
    
    func showTipLable(count : Int) {
        self.tipLab.isHidden = false
        tipLab.text = count == 0 ? "没数据" : "刷新\(count)条数据"
        UIView.animate(withDuration: 1, animations: { 
            
            self.tipLab.frame.origin.y = 64
        }) { (_) in
           
            UIView.animate(withDuration: 1, delay: 1.5, options: [], animations: { 
                self.tipLab.frame.origin.y = 10
            }, completion: { (_) in
                self.tipLab.isHidden = true
            })
        }

    }
    
     func setNotice(){
    
        NotificationCenter.default.addObserver(self, selector: #selector(showImage), name: NSNotification.Name(rawValue: showPhoneBrowserNote), object: nil)

        
        
    }

}

//MARK:---初始化Mytableview
extension HomeViewController{

    func iniTablview() {
        
        Mytableview.delegate = self
        Mytableview.dataSource = self
        Mytableview.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "homeCell")
        Mytableview.addLegendFooter(withRefreshingTarget: self, refreshingAction: #selector(HomeViewController.refreshFooter))
        Mytableview.addLegendHeader(withRefreshingTarget: self, refreshingAction: #selector(HomeViewController.refreshHeader))
        //自动调整cell高度
       // Mytableview.rowHeight = UITableViewAutomaticDimension
      // Mytableview.estimatedRowHeight = 200.0
        
    }

}

//MARk:---tableview 代理
extension HomeViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusesArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = statusesArr[indexPath.row]
        
        return model.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell : HomeCell = tableView .dequeueReusableCell(withIdentifier: "homeCell") as! HomeCell
        let model = statusesArr[indexPath.row]
        cell.model = model
        return cell
    }
    
    


}
//MARK:--上下拉刷新
extension HomeViewController{

   func refreshFooter(){
    
    loadDatas(isNewData: false)

    }
    func refreshHeader() {
        loadDatas(isNewData: true)
        
    }

}

//MARK--监听点击图片放大
extension HomeViewController{

  
    func showImage(notice : NSNotification) {
        
        let index = notice.userInfo!["indexPath"] as! IndexPath
        let picURL = notice.userInfo!["picURLs"] as! [URL]
        let obj  = notice.object as! PicCollectionView
        //动画代理
        pAnimal.presentDelegate = obj
        pAnimal.indexp = index as NSIndexPath
        
        let VC = PhotoViewController(indexpa: index, picURL: picURL)
       
        //设置mdal样式
        VC.modalPresentationStyle = .custom
        //转场代理
        VC.transitioningDelegate = pAnimal
        pAnimal.dismissDelegate = VC
        present(VC, animated: true, completion: nil)
        
    }

}









