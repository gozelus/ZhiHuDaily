


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
    
    
    private var circleView = ZHDCircle()
    private var circleViewTop: Constraint?
    private var bannerModels = [ZHDHomeTopBannerModel]()
    private var pageController = UIPageControl()
    private var timer: Timer?
    
    
    // MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Public
    public func updateWithBannerModel(_ models:[ZHDHomeTopBannerModel]) {
        
        addTimer()
        
        self.bannerModels = models
        self.circleView.update(models: self.bannerModels)
        
        self.addSubview(self.pageController)
        self.pageController.numberOfPages = self.bannerModels.count
        self.pageController.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(5)
            make.width.equalTo(20)
        }
    }
    
    public func updateDepthFieldView(_ scale : CGFloat){
        guard scale >= 0 else { return }
        self.circleViewTop?.update(offset: -64 - 100 * scale )
    }
    
    
    // MARK: - Private
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
    
    private func addTimer() {
        
        self.timer = Timer(timeInterval: 3, target: self, selector: #selector(timerNextPic), userInfo: nil, repeats: true)
        let runloop = RunLoop.current
        guard let t = self.timer else { return }
        runloop.add(t, forMode: .commonModes)
    }
    
    private func removeTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc private func timerNextPic() {
        
        let currentPageIndex = self.pageController.currentPage
        let nextPageIndex = (currentPageIndex == self.bannerModels.count-1) ? 0 : currentPageIndex + 1 //注意处理最后一张
        var nextPageOffset = CGPoint(x: CGFloat(nextPageIndex) * ZHDScreenWidth, y: 0)
        
        
        if nextPageIndex == 0 {
            nextPageOffset = CGPoint(
                x: CGFloat(self.bannerModels.count) * ZHDScreenWidth,
                y: 0)//先到倒数第1张
            
            self.circleView.setContentOffset(nextPageOffset, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                self.circleView.setContentOffset(.zero, animated: false) //快速切换到第二张
            })
        }else{
            self.circleView.setContentOffset(nextPageOffset, animated: true)
        }
    }
    
    
    // MARK: - ScrollviewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // 结束拖拽时 设置定时器
        addTimer()
        
        let offset = scrollView.contentOffset.x
        
        let theLastOffset = ZHDScreenWidth * CGFloat(self.bannerModels.count + 1)
        let theFirstOffset: CGFloat = 0
        
        if offset >= theLastOffset {
            let theSecondImgPoint = CGPoint(x: ZHDScreenWidth, y: 0)
            scrollView.setContentOffset(theSecondImgPoint, animated: false)//最后一张 跳转到第二张
        }else if offset <= theFirstOffset {
            let thePreLastImgPoint = CGPoint(x: CGFloat(self.bannerModels.count) * ZHDScreenWidth, y: 0)
            scrollView.setContentOffset(thePreLastImgPoint, animated: false)//第一张 跳转到倒数第二张
        }
        
        // 不能在结束拖拽时设置 pageController，ScrollView 向哪个方向滑动由滑动加速度、位置共同决定，无法靠位置判断
//        let currentPageIndex = Int((scrollView.contentOffset.x / ZHDScreenWidth) + 0.5)
//        self.pageController.currentPage = currentPageIndex
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPageIndex = Int((scrollView.contentOffset.x / ZHDScreenWidth) + 0.5)
        self.pageController.currentPage = currentPageIndex
    }
    
    
    
    
    
}
