//
//  RankingTableViewController.swift
//  Homework58AppleMusicRanking50
//
//  Created by 黃柏嘉 on 2022/1/20.
//

import UIKit
private let reuseIdentifier = "musicCell"
private let segueIdentifier = "appleMusicPage"

class RankingTableViewController: UITableViewController {
    
    var results = [APIResponse]()
    var passUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catchData()
    }
    
    @IBSegueAction func passUrl(_ coder: NSCoder) -> WebViewController? {
        guard let passUrl = passUrl else {return nil}
        return WebViewController(coder: coder, urlString: passUrl)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if results.isEmpty == false{
            return results[0].feed.results.count
        }else{
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MusicTableViewCell else{return UITableViewCell()}
        
        if results.isEmpty == false{
            cell.artistNameLabel.text = results[0].feed.results[indexPath.row].artistName
            cell.songNameLabel.text = results[0].feed.results[indexPath.row].name
            cell.releaseDateLabel.text = "發行日期：" + results[0].feed.results[indexPath.row].releaseDate
            cell.rankImageView.image = UIImage(systemName: "\(indexPath.row+1).circle")
            cell.songCoverImageView.image = UIImage(systemName: "photo.artframe")
            //抓圖
            if indexPath == tableView.indexPath(for: cell){
                catchPhoto(url: results[0].feed.results[indexPath.row].artworkUrl100) { (data) in
                    DispatchQueue.main.async {
                        cell.songCoverImageView.image = UIImage(data: data)
                    }
                }
            }
        }else{
            //如果資料還沒載好先顯示Loading...
            cell.artistNameLabel.text = "Loading..."
            cell.songNameLabel.text  = "Lodaing ..."
            cell.releaseDateLabel.text = "Loading..."
            cell.songCoverImageView.image = UIImage(systemName: "photo.artframe")
            tableView.allowsSelection = false
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passUrl = results[0].feed.results[indexPath.row].url
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard passUrl != nil else {return false}
        return true
    }
    
    
    //抓資料
    func catchData(){
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/tw/music/most-played/50/songs.json") else{return}
        URLSession.shared.dataTask(with: url) { (data,response,error)in
            if let data = data {
                do{
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    self.results.append(apiResponse)
                    DispatchQueue.main.async {
                        self.animateTable()
                    }
                    print("catchData")
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
    //抓圖
    func catchPhoto(url:String,completion:@escaping(Data)->()){
        guard let url = URL(string: url) else{return}
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }.resume()
    }
    //TableView動畫
    func animateTable() {
        //先重新讀入tableView
        tableView.reloadData()
        
        //得到畫面上的cell
        let cells = tableView.visibleCells
        //得到整個tableView的高度
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        //跑迴圈將所有畫面的cell的Y變成與tableView等高移出畫面之外
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        //為了讓每個cell都比前一個delay0.1秒，不然如果都一樣只是晚0.1秒所有一起出現
        var index = 0
        //然後再跑迴圈將cell一個一個用動畫歸位
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.5, delay: 0.1*Double(index), options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: { _ in
                self.tableView.allowsSelection = true
            })
            index += 1
        }
    }
   
}
