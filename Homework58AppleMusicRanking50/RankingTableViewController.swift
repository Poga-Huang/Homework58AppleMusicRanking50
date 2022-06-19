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
    
    let viewModel = RankingViewModel()
    var passUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.isStarting = true
        
        viewModel.onRequestEnd = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.musicCellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MusicTableViewCell else{return UITableViewCell()}
       
        let viewModel = viewModel.musicCellViewModels[indexPath.row]
        cell.setupCell(viewModel: viewModel)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let viewModel = viewModel.musicCellViewModels[indexPath.row]
        passUrl = viewModel.url
        
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            if let dvc = segue.destination as? WebViewController{
                dvc.urlString = passUrl
            }
        }
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
