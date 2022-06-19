//
//  MusicCellViewModel.swift
//  Homework58AppleMusicRanking50
//
//  Created by 黃柏嘉 on 2022/6/19.
//

import UIKit

class MusicCellViewModel{
    
    var rank:Int
    var artistName:String
    var songName:String
    var releaseDate:String
    var imageURL:String
    var url:String
    
    var imageDownloadEnd:((UIImage?)->())?
    
    init(rank:Int,artistName:String,songName:String,releaseDate:String,imageURL:String,url:String){
        self.rank = rank
        self.artistName = artistName
        self.songName = songName
        self.releaseDate = releaseDate
        self.imageURL = imageURL
        self.url = url
    }
    
    func getImage(){
        guard let url = URL(string: imageURL) else { return }
        DownloadHelper.shared.download(url: url) { result in
            switch result{
            case.success(let response):
                let image = UIImage(data: response)
                guard let imageDownloadEnd = self.imageDownloadEnd else {
                    return
                }
                imageDownloadEnd(image)
            case .failure(_):
                print("download Fail")
            }
        }
    }
    
}
