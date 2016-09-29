


//
//  ZHDHomeBannerCell.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/25.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit
import SnapKit

class ZHDHomeBannerCell: UITableViewCell, UIScrollViewDelegate {
    
    
    private var circleView : ZHDCircle = ZHDCircle()
    private var circleViewTop: Constraint?
    private var BannerModels : [ZHDHomeTopBannerModel]?
    private var pageController : UIPageControl = UIPageControl()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initSubviews()
    }
    
    
    //MARK:- Public
    public func updateWithBannerModel(_ models : [ZHDHomeTopBannerModel]!){
        
        self.BannerModels = models
        
        self.circleView.update(models: self.BannerModels)
        
        self.addSubview(self.pageController)
        self.pageController.numberOfPages = (self.BannerModels?.count)!
        self.pageController.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(5)
            make.width.equalTo(20)
        }
    }
    
    
    public func updateDepthFieldView(_ scale : CGFloat){
        if scale < 0 {
            return
        }
        self.circleViewTop?.update(offset: -64 - 100 * scale )
        
        
    }
    
    
    
    //MARK:- private
    private  func initSubviews(){
        
        self.addSubview(self.circleView)
        self.circleView.snp.makeConstraints { (make) in
            
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            self.circleViewTop = make.top.equalTo(self.snp.top).offset(-64).constraint
            make.bottom.equalTo(self.snp.bottom)
        }
        self.circleView.delegate = self
        
    }
    
    
    //MARK:- scrollviewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        
        let theLastOffset = ZHDScreenWidth * CGFloat((self.BannerModels?.count)! + 1)
        let theFirstOffset = CGFloat(0)
        
        let theSecondImgPoint = CGPoint(x: ZHDScreenWidth, y: 0)
        let thePreLastImgPoint = CGPoint(x: CGFloat((self.BannerModels?.count)! + 1) * ZHDScreenWidth, y: 0)
        
        if offset >= theLastOffset {
            scrollView.setContentOffset(theSecondImgPoint, animated: false)
        }
        
        if offset <= theFirstOffset{
            scrollView.setContentOffset(thePreLastImgPoint, animated: false)
        }
        
        let currentPageIndex = offset / ZHDScreenWidth;
        print(currentPageIndex)
        self.pageController.currentPage = Int(currentPageIndex)
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
}
