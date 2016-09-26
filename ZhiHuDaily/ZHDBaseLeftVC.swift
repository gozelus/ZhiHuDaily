//
//  ZHDBaseLeftVC.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/25.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit

class ZHDBaseLeftVC: UIViewController {
    
    var tableview = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        self.setupSubviews()
    }
    
    func setupSubviews(){
        self.tableview.frame = CGRect(x: ZHDScreenWidth * 0.5, y: 0, width: ZHDScreenWidth * 0.5, height: ZHDScreenHeight)
        self.view.addSubview(self.tableview)
        self.tableview.backgroundColor = UIColor.black
    }

}
