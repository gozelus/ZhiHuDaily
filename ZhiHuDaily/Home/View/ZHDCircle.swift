


//
//  ZHDCircle.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/28.
//  Copyright © 2016年 征里. All rights reserved.
//  图片轮播器

import UIKit
import SnapKit
import SDWebImage

fileprivate var lastImgView : ZHDCircleCell?

fileprivate let kImgViewWidth = ZHDScreenWidth



class ZHDCircle: UIScrollView {
    
    
    private var imgURLs = [String]()
    private var imgViews = [UIImageView]()
    private var titles = [String]()
    private var imgViewTopContraints = [Constraint]()
    
    // MARK: - Public
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bounces = false
    }

    
    
    // 更新数据、UI
    public func update(models : [ZHDHomeTopBannerModel]!){
        
        var urls = [String]()
        var titles = [String]()
    
        
        for model in models {
            if let url = model.imageURL {
                urls.append(url)
            }
            if let title = model.title {
                titles.append(title)
            }
        }
        
        // 这两行把5条数据改成了7条，有问题
//        self.imgURLs = changeArray(urls)
//        self.titles = changeArray(titles)
        
        self.imgURLs = urls
        self.titles = titles
        
        self.initUI()
    }
    
    
    
    
    // MARK: - Private
    private func changeArray(_ array : [String]) -> [String] {
        
        var changedArray = array
        
        //处理urls数组
        if let firstURLStr = array.last, let lastURLStr = array.first {
            changedArray.insert(firstURLStr, at: 0)
            changedArray.append(lastURLStr)
        }
        return changedArray
    }
    
    private func initUI(){
        
        if !(self.imgURLs.isEmpty) {
            
            let imgCount : CGFloat = CGFloat(self.imgURLs.count)
            self.contentSize = CGSize(width: kImgViewWidth * imgCount, height: 100)
            self.showsVerticalScrollIndicator = false
            self.showsHorizontalScrollIndicator = false
            self.isPagingEnabled = true
            
            //添加imgviews
            var index = 0
            while index < self.imgURLs.count {
                let url : URL = URL(string: self.imgURLs[index])!
                let title : String = self.titles[index]
                
                let circleCell = ZHDCircleCell(url, title)
                
                self.addSubview(circleCell)
                circleCell.snp.makeConstraints({ (make) in
                    make.top.equalTo(self.snp.top)
                    if lastImgView == nil {
                        make.left.equalTo(self.snp.left)
                    }else{
                        make.left.equalTo((lastImgView?.snp.right)!)
                    }
                    lastImgView = circleCell
                    
                    make.size.equalTo(self.snp.size)
                })

                self.imgViews.append(circleCell)
                index += 1
            }
            
        }
        
        
    }
        
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
