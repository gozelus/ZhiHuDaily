
//
//  ZHDHomeViewModel.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/26.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit

class ZHDHomeNewsCellViewModel{
    var id : String?
    var imageURL : String?
    var title : String?
    var type : String?

    init(_ json : JSON) {
        
        self.id = json["id"].string
        self.title = json["image"].string
        self.type = json["type"].string
        self.imageURL = json["image"].string
    }
}

//首页顶部banner数据模型
class ZHDHomeTopBannerViewModel{
    var id : String?
    var imgeUrl : String?
    var title : String?
    var type : String?
    
    init(_ json : JSON) {
        
        self.id = json["id"].string
        self.title = json["image"].array?[0].string
        self.type = json["type"].string
        self.imgeUrl = json["image"].string
        
    }
    
}


//首页数据模型
class ZHDHomeModel{

    var date : String?
    var top_stroies : [ZHDHomeTopBannerViewModel] = Array()
    var stroies : [ZHDHomeNewsCellViewModel] = Array()
    init(_ json : JSON){

        self.date = json["date"].string
        
        let json : JSON = json
        let topStories  =  json["top_stories"].array
        let stories = json["stories"].array
        
        for storyModelJson in stories! {
            
            self.stroies.append(ZHDHomeNewsCellViewModel(storyModelJson))
        }
        
        for topStoryModelJson in topStories! {
          
          self.top_stroies.append(ZHDHomeTopBannerViewModel(topStoryModelJson))
        }
    }
    
}
