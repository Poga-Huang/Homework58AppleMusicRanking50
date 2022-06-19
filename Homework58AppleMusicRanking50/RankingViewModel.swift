//
//  RankingViewModel.swift
//  Homework58AppleMusicRanking50
//
//  Created by 黃柏嘉 on 2022/6/19.
//

import Foundation

class RankingViewModel{
    
    private let apiUrl = URL(string: "https://rss.applemarketingtools.com/api/v2/tw/music/most-played/50/songs.json")
    public var musicCellViewModels = [MusicCellViewModel]()
    
    var isStarting = false{
        didSet{
            sendRequest()
        }
    }
    
    var onRequestEnd:(()->())?
       
    private func sendRequest(){
        DownloadHelper.shared.download(url: apiUrl!) { result in
            switch result{
            case .success(let response):
                if let result = APIResponse.apiResponseHandler(data: response){
                    self.convertMusicCellViewModel(model: result)
                }
            case .failure(_):
                print("error")
            }
        }
        
    }
    
    private func convertMusicCellViewModel(model:APIResponse){
        
        for (index,result) in model.feed.results.enumerated() {
            musicCellViewModels.append(MusicCellViewModel(rank: index+1, artistName: result.artistName, songName: result.name, releaseDate: result.releaseDate, imageURL: result.artworkUrl100, url: result.url))
        }
        onRequestEnd?()
    }
    
}
