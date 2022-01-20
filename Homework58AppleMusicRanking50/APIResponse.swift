//
//  APIResponse.swift
//  Homework58AppleMusicRanking50
//
//  Created by 黃柏嘉 on 2022/1/20.
//

import Foundation

struct APIResponse:Codable{
    var feed:Feed
    struct Feed:Codable{
        var results:[Results]
        struct Results:Codable{
            var artistName:String
            var name:String
            var releaseDate:String
            var artworkUrl100:String
            var url:String
        }
    }
}
