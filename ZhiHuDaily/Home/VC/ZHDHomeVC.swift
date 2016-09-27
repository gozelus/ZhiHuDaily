//
//  ZHDHomeVC.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/25.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit
import Alamofire


fileprivate let dailyString = "今日热文"
fileprivate let kBannerCellReuserID = "kBannerCellReuseID"
fileprivate let kNewsCellReuserID = "kNewsCellReuserID"
fileprivate let kBannerCellHeight = 100.0

// https://github.com/OpenMarshall/ZhiHuDaily/tree/xky_develop

class ZHDHomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private var tableview = UITableView()
    private var naviTitleView = UIView()
    
    /// 顶部banner数据模型
    private var topCellViewModels : [ZHDHomeTopBannerModel] = Array()
    
    /// 新闻cell数据模型
    private var newCellViewModels : [ZHDHomeNewsCellModel] = Array()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableview()
        
        HTTPRequestHome.request(success: { (json) in
            let  homeModel = ZHDHomeModel(json)
            
            self.topCellViewModels = homeModel.top_stroies
            self.newCellViewModels = homeModel.stroies
            
            }) { (error) in
                print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigation()
    }
    
    
    // MARK: - Private
    
    // MARK: UI
    private func setupTableview(){
        self.tableview.frame = CGRect(origin: CGPoint.zero, size: ZHDScreenRect.size)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(ZHDHomeBannerCell.classForCoder(), forCellReuseIdentifier: kBannerCellReuserID)
        self.tableview.register(ZHDHomeNewsCell.classForCoder(), forCellReuseIdentifier: kNewsCellReuserID)
        self.view.addSubview(self.tableview)
    }
    
    private func setupNavigation(){
        //设置标题
        self.setupTitleView()
        
        //设置导航条
        self.setupNavgationBar()
    }
    
    private func setupNavgationBar(){
        if let navi = self.navigationController?.navigationBar.subviews.first {
            navi.alpha = 0
        }
        self.navigationController?.navigationBar.barTintColor = .gray
    }
    
    private func setupTitleView(){
        
        self.navigationItem.titleView = self.naviTitleView
        let label = UILabel()
        label.text = dailyString
        label.textColor = .white
        label.sizeToFit()
        
        if let center = self.navigationController?.navigationBar.center {
            self.naviTitleView.center = center
        }
        self.naviTitleView.zl_setSize(label.zl_size())
        self.naviTitleView.addSubview(label)
    }
    
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = self.tableview.dequeueReusableCell(withIdentifier: kBannerCellReuserID) {
                return cell
            }else {
                return UITableViewCell()
            }
        }
        
        if let cell = self.tableview.dequeueReusableCell(withIdentifier: kNewsCellReuserID) {
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        return 50
    }
    
    
    // MARK: - Scroll View
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y + 64.0
        let scale = offset / 100.0
        
        if let navi = self.navigationController?.navigationBar.subviews.first {
            navi.alpha = scale
        }
    }
}
