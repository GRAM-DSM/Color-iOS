//
//  TimelineTableViewCell.swift
//  Color
//
//  Created by 정창용 on 2021/09/23.
//

import UIKit
import Hashtags

protocol TableViewCellDelegate: AnyObject {
    func updateTextViewHeight(_ cell: TimelineTableViewCell, _ textView: UITextView)
}

class TimelineTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var heartBtn: HeartButton!
    @IBOutlet weak var heartLabel: UILabel!
    @IBOutlet weak var hashtags: HashtagView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    weak var delegate: TableViewCellDelegate?

    let sampleTag1 = HashTag(word: "금수저")
    let sampleTag2 = HashTag(word: "Flex")
    let sampleTag3 = HashTag(word: "루저")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTableView()
        setView(headerView)
        setView(bottomView)
        
        hashtags.addTag(tag: sampleTag1)
        hashtags.addTag(tag: sampleTag2)
        hashtags.addTag(tag: sampleTag3)
        
        heartBtn.addTarget(self, action: #selector(handleHeartButtonTap(_:)), for: .touchUpInside)
    }
    
    private func setView(_ view: UIView) {
//        view.layer.shadowRadius = 1
//        view.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 35, width: view.bounds.width, height: 1)).cgPath
//        view.layer.shadowOpacity = 1
//        view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        view.layer.shouldRasterize = true
    }
    
    @objc private func handleHeartButtonTap(_ sender: UIButton) {
         guard let button = sender as? HeartButton else { return }
         button.flipLikedState()
    }
}

extension TimelineTableViewCell: UITextViewDelegate {
    private func setTableView() {
        detailTextView.delegate = self
        detailTextView.isScrollEnabled = false
        detailTextView.sizeToFit()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let delegate = delegate {
            delegate.updateTextViewHeight(self, textView)
        }
    }
}

extension TimelineTableViewCell: HashtagViewDelegate {
    func hashtagRemoved(hashtag: HashTag) {
        print(hashtag.text + " Removed!")
    }
    
    func viewShouldResizeTo(size: CGSize) {
        heightConstraint.constant = size.height
        
        UIView.animate(withDuration: 0.4) {
            self.contentView.layoutIfNeeded()
        }
    }
}
