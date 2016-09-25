//
//  ZHDHomeVC.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/25.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit


let dailyString : String = "今日热文"

let kBannerCellReuserID : String = "kBannerCellReuseID"
let kNewsCellReuserID : String = "kNewsCellReuserID"


let kBannerCellHeight = 100.0
class ZHDHomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    //tablview
    var tableview : UITableView = UITableView()
    var naviTitleView : UIView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableview()
        ZHDRequestManagerBase.request("http://news-at.zhihu.com/api/4/news/latest", ["123" : "123"], { (data) in
            
            }) { (error) in
                
        }
   }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigation()

    }
    
    
    
    
    func setupTableview(){
        self.tableview.frame = CGRect.init(origin: CGPoint.zero, size: ZHDScreenRect.size)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(ZHDHomeBannerCell.classForCoder(), forCellReuseIdentifier: kBannerCellReuserID)
        self.tableview.register(ZHDHomeNewsCell.classForCoder(), forCellReuseIdentifier: kNewsCellReuserID)
        self.view.addSubview(self.tableview)
    }
    
    
    
    
    func setupNavigation(){
        //设置标题
        self.setupTitleView()
        
        //设置导航条
        self.setupNavgationBar()
    }

    func setupNavgationBar(){
        let navi = (self.navigationController?.navigationBar.subviews[0])! as UIView
        navi.alpha = 0
        self.navigationController?.navigationBar.barTintColor = .red
    }

    func setupTitleView(){
    
        self.navigationItem.titleView = self.naviTitleView
        let label  = UILabel.init()
        label.text = dailyString
        label.textColor = .white
        label.sizeToFit()

        self.naviTitleView.center = (self.navigationController?.navigationBar.center)!
        self.naviTitleView.zl_setSize(label.zl_size())
        self.naviTitleView.addSubview(label)
        
        
    }
    
    //MARK:- tableview Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
          return self.tableview.dequeueReusableCell(withIdentifier: kBannerCellReuserID)!
        }
        return self.tableview.dequeueReusableCell(withIdentifier: kNewsCellReuserID)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return 20
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
            return 100
        }
        return 50
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y + 64.0
        let scale = offset / 100.0
        
        let navi = (self.navigationController?.navigationBar.subviews[0])! as UIView
        navi.alpha = scale
    }
    
    
    
    //MARK:-

}
