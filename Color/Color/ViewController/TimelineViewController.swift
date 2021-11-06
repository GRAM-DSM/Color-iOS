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
    
    private let httpClient = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTimelineList()
        
        setLogoNavigationBarTitle()
        setNavigationBar()
        customSeparator(tableView: timelineTableView)
    }
    
    func getTimelineList() {
        httpClient
            .get(url: TimelineAPI.getTimelineList.path(), params: nil, header: Header.accessToken.header())
            .responseJSON(completionHandler: {[unowned self](response) in
                switch response.response?.statusCode {
                case 200:
                    do {
                        print("OK - getTimelineList")
                    } catch {
                        print("Error: \(error)")
                    }
                    
                case 401:
                    print("401 - getTimelineList")
                    
                default:
                    print(response.response?.statusCode ?? "default")
                    print(response.error ?? "default")
                }
            })
    }
    
    func customSeparator(tableView: UITableView) {
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.separatorInset.left = 0
    }
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample1.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 181
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TimelineTableViewCell = tableView.dequeueReusableCell(withIdentifier: "timelineCell", for: indexPath) as! TimelineTableViewCell
        
        cell.nameLabel?.text = self.sample1[indexPath.row]
        cell.detailTextView?.text = self.sample2[indexPath.row]
        
        return cell
    }
}
