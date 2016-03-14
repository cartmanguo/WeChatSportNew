//
//  User.swift
//  WeiXinSportNew
//
//  Created by randy on 16/3/14.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit

class User: NSObject {
    var name:String?
    var steps:Int?
    var likes:Int?
    init(name:String,steps:Int,likes:Int)
    {
        self.name = name
        self.steps = steps
        self.likes = likes
    }
}
