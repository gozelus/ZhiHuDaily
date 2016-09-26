

//
//  ZHDBaseViewController.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/25.
//  Copyright © 2016年 征里. All rights reserved.
//  window根控制器 负责侧滑效果



import UIKit


class ZHDBaseViewController: UIViewController {
    
    
    //负责滑动的scrollview
    var scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ZHDScreenWidth, height:ZHDScreenHeight))
    
    //左子控制器
    var leftChildVC = ZHDBaseLeftVC()
    
    //右子控制器
    var rightChildVC = ZHDHomeNaviVC(rootViewController : ZHDHomeVC())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        
        //setup child vc
        self.setupChildVC()
        
        //setup scrollview 
        self.setupSubviews()
        
        

    }
    
    
    func setupChildVC(){
        self.addChildViewController(self.leftChildVC)
        self.addChildViewController(self.rightChildVC)
        
        
    }


    func setupSubviews(){
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.leftChildVC.view)
        self.scrollView.addSubview(self.rightChildVC.view)
        self.scrollView.contentSize = CGSize(width: ZHDScreenWidth * 1.5, height: 0)
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: ZHDScreenWidth * 0.5, bottom: 0, right: -ZHDScreenWidth * 0.5)
        self.scrollView.bounces = false
        self.leftChildVC.view.frame = CGRect(x:  -ZHDScreenWidth, y: 0, width: ZHDScreenWidth, height: ZHDScreenHeight)
        self.rightChildVC.view.frame = CGRect(x: 0, y: 0, width: ZHDScreenWidth, height: ZHDScreenHeight)
        self.scrollView.isPagingEnabled = true
    }
}
