//
//  SadViewController.swift
//  Color
//
//  Created by 장서영 on 2021/10/26.
//

import UIKit
import RxCocoa
import RxSwift

class SadViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak private var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.rx.tap
            .bind(onNext: {[unowned self] in
                navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
