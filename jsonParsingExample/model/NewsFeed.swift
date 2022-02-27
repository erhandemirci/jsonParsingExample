//
//  NewsFeed.swift
//  jsonParsingExample
//
//  Created by erhan demirci on 24.02.2022.
//

import Foundation

struct Request: BaseRequest {
    var requestURL: String
}


struct NewsFeed: Codable{

    var status:String?
    var totalResults:Int?
    var articles:[article]?
    
    init(s:String,t:Int,a:String)
    {
        self.totalResults=t
        self.status=s
       
    }
  
    
  
}
