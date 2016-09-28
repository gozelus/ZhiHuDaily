


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

fileprivate var lastImgView : UIImageView?

fileprivate let kImgViewWidth = ZHDScreenWidth


class ZHDCircle: UIScrollView {
    
    private var imgURLs : [String] = [String]()
    private var imgViews  : [UIImageView] = [UIImageView]()
    private var imgViewTopContraints : [Constraint] = [Constraint]()
    
    
    //MARK: public
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    
    
    /// 根据数组跟新ui
    ///
    /// - parameter array: <#array description#>
    public func update(_ array : [String]!){
        
        self.imgURLs = array
        
        //处理urls数组
        let firstURLStr = self.imgURLs.first
        let lastURLStr = self.imgURLs.last
        
        self.imgURLs.insert(firstURLStr!, at: 0)
        self.imgURLs.append(lastURLStr!)

        self.initUI()
    }
    
    
    
    //MARK: pravite
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
                let imgView = UIImageView()
                let url : URL = URL(string: self.imgURLs[index])!
                imgView.sd_setImage(with: url)
                imgView.contentMode = UIViewContentMode.scaleAspectFill
                self.addSubview(imgView)
                
                imgView.snp.makeConstraints({ (make) in
                    make.top.equalTo(self.snp.top)
                    if lastImgView == nil {
                        make.left.equalTo(self.snp.left)
                    }else{
                        make.left.equalTo((lastImgView?.snp.right)!)
                    }
                    lastImgView = imgView
                    
                    make.size.equalTo(self.snp.size)
                })

               self.imgViews.append(imgView)
                index += 1
            }
        }
    }
    
    
    /// 生成布局好的imgView
    ///
    /// - parameter index: urls数组下表
    ///
    /// - returns: <#return value description#>
    private func  getClipsImgView(_ index : Int) -> UIImageView{
        let imgView = UIImageView()
        self.addSubview(imgView)
        imgView.contentMode = UIViewContentMode.scaleAspectFill
        
        imgView.sd_setImage(with:URL(string:self.imgURLs[index]))
        imgView.snp.makeConstraints { (make) in
            
        }
        
        lastImgView = imgView
        return imgView
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
