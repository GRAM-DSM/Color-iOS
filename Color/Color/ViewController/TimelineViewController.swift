//
//  TimelineViewController.swift
//  Color
//
//  Created by 정창용 on 2021/09/23.
//

import UIKit
import AlignedCollectionViewFlowLayout

class TimelineViewController: UIViewController {
    @IBOutlet weak var timelineTableView: UITableView!
    
    private let sample1 = ["정현왕자님", "안병헌", "정현왕자님", "안병헌"]
    private let sample2 = ["나는 강남에 빌딩있는데 이 인생 패배자들아 ㅗㅗ", "오우오우 지려버렸고", "나는 강남에 빌딩있는데 이 인생 패배자들아 ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ", "오우오우 지려버렸고"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLogoNavigationBarTitle()
        setNavigationBar()
        customSeparator(tableView: timelineTableView)
    }
    
    func customSeparator(tableView: UITableView) {
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.separatorInset.left = 0
    }
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TimelineTableViewCell = tableView.dequeueReusableCell(withIdentifier: "timelineCell", for: indexPath) as! TimelineTableViewCell
        
        cell.delegate = self
        
        cell.nameLabel?.text = self.sample1[indexPath.row]
        cell.detailTextView?.text = self.sample2[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample1.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func updateTextViewHeight(_ cell: TimelineTableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = timelineTableView.sizeThatFits(CGSize(width: size.width,
                                                    height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            timelineTableView.beginUpdates()
            timelineTableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 181
    //    }
}
