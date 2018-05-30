//
//  List.swift
//  TestApp
//
//  Created by  Kostantin Zarubin on 24.05.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import Foundation

class Repo: NSObject {
    var fullName : String
    var descriptionStr : String
    var starsCount : Int
    var watchersCount : Int
    var forksCount : Int
    var url : String
    
    init(fullName : String, descriptionStr: String, starCount: Int, watchersCount: Int, forksCount: Int, url: String) {
        self.fullName = fullName
        self.descriptionStr = descriptionStr
        self.starsCount = starCount
        self.watchersCount = watchersCount
        self.forksCount = forksCount
        self.url = url
    }
}
