//
//  DownloadHelper.swift
//  Homework58AppleMusicRanking50
//
//  Created by 黃柏嘉 on 2022/6/19.
//

import Foundation

class DownloadHelper{
    
    static let shared = DownloadHelper()
    
    func download(url:URL,completion:@escaping (Result<Data,Error>)->()){
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completion(.success(data))
            }
            else if let error = error{
                completion(.failure(error))
            }
        }.resume()
    }
    
}
