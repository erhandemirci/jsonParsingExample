//
//  article.swift
//  jsonParsingExample
//
//  Created by erhan demirci on 24.02.2022.
//

import Foundation
struct article : Codable
{
    var source:sourceModel?
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    var content:String?
    
    
    
}
