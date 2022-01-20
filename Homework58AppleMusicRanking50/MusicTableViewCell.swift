//
//  MusicTableViewCell.swift
//  Homework58AppleMusicRanking50
//
//  Created by 黃柏嘉 on 2022/1/20.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var songCoverImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rankImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        songCoverImageView.layer.cornerRadius = songCoverImageView.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
