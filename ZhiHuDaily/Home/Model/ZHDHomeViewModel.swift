
//
//  ZHDHomeViewModel.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/26.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit
import SwiftyJSON

class ZHDHomeNewsCellModel{
    var id : String?
    var imageURL : String?
    var title : String?
    var type : String?

    init(_ json : JSON) {
        
        self.id = json["id"].string
        self.title = json["title"].string
        self.type = json["type"].string
        self.imageURL =  json["images"][0].string
    }
}

//首页顶部banner数据模型
class ZHDHomeTopBannerModel{
    var id : String?
    var imageURL : String?
    var title : String?
    var type : String?
    
    init(_ json : JSON) {
        
        self.id = json["id"].string
        self.title = json["title"].string
        self.type = json["type"].string
        self.imageURL = json["image"].string
        
    }
    
}


//首页数据模型
class ZHDHomeModel{

    var date : String?
    var top_stroies = [ZHDHomeTopBannerModel]()
    var stroies = [ZHDHomeNewsCellModel]()
    init(_ json : JSON){

        self.date = json["date"].string
        
        let json : JSON = json
        let topStories  =  json["top_stories"].array
        let stories = json["stories"].array
        
        for storyModelJson in stories! {
            
            self.stroies.append(ZHDHomeNewsCellModel(storyModelJson))
        }
        
        for topStoryModelJson in topStories! {
          
          self.top_stroies.append(ZHDHomeTopBannerModel(topStoryModelJson))
        }
    }
    
}
