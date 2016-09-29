


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
    private var timer : Timer?
    
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initSubviews()
    }
    
    
    //MARK:- Public
    public func updateWithBannerModel(_ models : [ZHDHomeTopBannerModel]!){
        
        setupTimer()
        
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
    
    /// 设置定时器
    private func setupTimer(){
        
        self.timer = Timer(timeInterval: 1.5, target: self, selector: #selector(timerNextPic), userInfo: nil, repeats: true)
        let runloop = RunLoop.current
        runloop.add(self.timer!, forMode: .commonModes)
    }
    
    
    /// 更换图片
    @objc  private func timerNextPic(){
        print("run!")
        
        let currentPageIndex = self.pageController.currentPage
        
        var nextPageOffset : CGPoint?
        var nextPageIndex : Int?
        
        
        nextPageIndex = currentPageIndex == (self.BannerModels?.count)! - 1 ? 0 : currentPageIndex + 1//注意处理最后一张
        nextPageOffset = CGPoint(x: CGFloat(nextPageIndex!) * ZHDScreenWidth, y: 0)
        
        self.pageController.currentPage = nextPageIndex!
        
        if nextPageIndex == 0{
            
            nextPageOffset = CGPoint(
                x: CGFloat((self.BannerModels?.count)!) * ZHDScreenWidth,
                y: 0)//先到倒数第1张
            
            self.circleView.setContentOffset(nextPageOffset!, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                self.circleView.setContentOffset(.zero, animated: false)//快速切换到第二张

            })
            
            
        }else{
            self.circleView.setContentOffset(nextPageOffset!, animated: true)
        }
    }
    
    
    //MARK:- scrollviewDelegate
    
    //这个地方记得去除定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //结束拖拽时 设置定时器
        setupTimer()
        
        let offset = scrollView.contentOffset.x
        
        let theLastOffset = ZHDScreenWidth * CGFloat((self.BannerModels?.count)! + 1)
        let theFirstOffset = CGFloat(0)
        
        let theSecondImgPoint = CGPoint(x: ZHDScreenWidth, y: 0)
        let thePreLastImgPoint = CGPoint(x: CGFloat((self.BannerModels?.count)!) * ZHDScreenWidth, y: 0)
        
        if offset >= theLastOffset {
            scrollView.setContentOffset(theSecondImgPoint, animated: false)//最后一张 跳转到第二张
        }
        
        if offset <= theFirstOffset{
            scrollView.setContentOffset(thePreLastImgPoint, animated: false)//第一张 跳转到倒数第二张
        }
        
        let currentPageIndex = scrollView.contentOffset.x / ZHDScreenWidth;
        
        self.pageController.currentPage = Int(currentPageIndex)

    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
}
