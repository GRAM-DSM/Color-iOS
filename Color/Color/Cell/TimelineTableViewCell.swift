//
//  TimelineTableViewCell.swift
//  Color
//
//  Created by 정창용 on 2021/09/23.
//

import UIKit
import Hashtags

class TimelineTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var heartLabel: UILabel!
    
    @IBOutlet weak var hashtagView: HashtagView!
    
    let sampleTag1 = HashTag(word: "금수저")
    let sampleTag2 = HashTag(word: "Flex")
    let sampleTag3 = HashTag(word: "루저")

    override func awakeFromNib() {
        super.awakeFromNib()
        
        heartButton()
        hashtagView.addTag(tag: sampleTag1)
        hashtagView.addTag(tag: sampleTag2)
        hashtagView.addTag(tag: sampleTag3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func heartButton() {
        let buttonFrame = CGRect(x: 14,
                                 y: contentView.frame.maxY - 27,
                                 width: 19,
                                 height: 18)
        let heartButton = HeartButton(frame: buttonFrame)
        heartButton.addTarget(
            self, action: #selector(handleHeartButtonTap(_:)), for: .touchUpInside)
        contentView.addSubview(heartButton)
    }
    
    @objc private func handleHeartButtonTap(_ sender: UIButton) {
        guard let button = sender as? HeartButton else { return }
        button.flipLikedState()
    }
}
