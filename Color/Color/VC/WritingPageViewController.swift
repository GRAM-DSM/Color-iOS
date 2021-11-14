//
//  WritingPageViewController.swift
//  Color
//
//  Created by 장서영 on 2021/09/02.
//

import UIKit
import Hashtags
import RxCocoa
import RxSwift
import Moya

class WritingPageViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var currentFeel = String()
    var hashTags = [String]()
    let disposeBag = DisposeBag()
    
    let provider = MoyaProvider<ColorAPI>()
    
    @IBOutlet weak private var introLabel: UILabel!
    
    @IBOutlet weak private var redButton: UIButton!
    @IBOutlet weak private var yellowButton: UIButton!
    @IBOutlet weak private var blueButton: UIButton!
    @IBOutlet weak private var grayButton: UIButton!
    @IBOutlet weak private var pinkButton: UIButton!
    @IBOutlet weak private var navyButton: UIButton!
    
    @IBOutlet weak private var contentTxtView: UITextView!
    
    @IBOutlet weak private var hashtagLabel: UILabel!
    @IBOutlet weak private var hashtagTxtField: UITextField!
    @IBOutlet weak private var hashtagView: HashtagView!
    
    @IBOutlet weak private var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLogoNavigationBarTitle()
        setNavigationBar()
        hashtagTxtField.delegate = self
        hashtagView.tagBackgroundColor = .systemGray4
        placeholder()
        introLabel.adjustsFontSizeToFitWidth = true
        colorButtonTapped()
        addHashTag()
        writingPost()
    }
    
    func colorButtonTapped() {
        redButton.rx.tap
            .bind(onNext: { [unowned self] in
                colorButtonDefaultSetting(button: redButton, color: "angry")
                currentFeel = "ANGRY"
            }).disposed(by: disposeBag)
        
        yellowButton.rx.tap
            .bind(onNext: { [unowned self] in
                colorButtonDefaultSetting(button: yellowButton, color: "happy")
                currentFeel = "HAPPY"
            }).disposed(by: disposeBag)
        
        blueButton.rx.tap
            .bind(onNext: { [unowned self] in
                colorButtonDefaultSetting(button: blueButton, color: "sad")
                currentFeel = "SAD"
            }).disposed(by: disposeBag)
        
        grayButton.rx.tap
            .bind(onNext: { [unowned self] in
                colorButtonDefaultSetting(button: grayButton, color: "bored")
                currentFeel = "BORED"
            }).disposed(by: disposeBag)
        
        pinkButton.rx.tap
            .bind(onNext: { [unowned self] in
                colorButtonDefaultSetting(button: pinkButton, color: "love")
                currentFeel = "LOVE"
            }).disposed(by: disposeBag)
        
        navyButton.rx.tap
            .bind(onNext: { [unowned self] in
                colorButtonDefaultSetting(button: navyButton, color: "shamed")
                currentFeel = "SHAMED"
            }).disposed(by: disposeBag)
    }
    
    func addHashTag() {
        hashtagTxtField.rx.controlEvent([.editingDidEndOnExit])
            .asObservable()
            .subscribe(onNext: { [unowned self] in
                let text = hashtagTxtField.text?.replacingOccurrences(of: " ", with: "_")
                let tag = HashTag(word: text!, withHashSymbol: true, isRemovable: true)
                hashtagView.addTag(tag: tag)
                hashTags.append(text!)
                print(hashTags)
                hashtagTxtField.text = " "
            }).disposed(by: disposeBag)
    }
    
    func resetButtonSetting() {
        let buttonAndConceptColor : [String : UIButton] = ["angry": redButton, "happy": yellowButton, "sad": blueButton, "bored": grayButton, "love": pinkButton, "shamed": navyButton]
        
        buttonAndConceptColor.forEach {(key, value) in
            value.backgroundColor = UIColor.init(named: key)
        }
    }
    
    func placeholder() {
        contentTxtView.delegate = self
        contentTxtView.text = "오늘 하루 당신의 이야기를 들려주세요"
        contentTxtView.textColor = UIColor.lightGray
        
        contentTxtView.rx.didBeginEditing
            .subscribe(onNext: { [unowned self] _ in
                if contentTxtView.textColor == UIColor.lightGray{
                    contentTxtView.text = nil
                    contentTxtView.textColor = UIColor.black
                }
                enableButton()
            }).disposed(by: disposeBag)
        
        contentTxtView.rx.didEndEditing
            .subscribe(onNext: { [unowned self] _ in
                if contentTxtView.text.isEmpty {
                    contentTxtView.text = "오늘 하루 당신의 이야기를 들려주세요"
                    contentTxtView.textColor = UIColor.lightGray
                }
                enableButton()
            }).disposed(by: disposeBag)
    }
    
    func enableButton() {
        let colorButton = [redButton, yellowButton, blueButton, grayButton, pinkButton, navyButton]
        for i in 0..<colorButton.count {
            if colorButton[i]?.backgroundColor == .white && contentTxtView.text != "오늘 하루 당신의 이야기를 들려주세요" {
                doneButton.backgroundColor = hashtagView.tagBackgroundColor
                doneButton.isEnabled = true
                break
            } else if contentTxtView.text == "오늘 하루 당신의 이야기를 들려주세요" || contentTxtView.text == ""{
                doneButton.backgroundColor = .systemGray
                doneButton.isEnabled = false
            } else {
                doneButton.backgroundColor = .systemGray
                doneButton.isEnabled = false
            }
        }
    }
    
    func colorButtonDefaultSetting(button: UIButton ,color : String) {
        resetButtonSetting()
        hashtagView.tagBackgroundColor = UIColor.init(named: color)!
        button.chooseColor(buttonColor: UIColor.init(named: color)!)
        enableButton()
    }
    
    func writingPost() {
        doneButton.rx.tap
            .subscribe(
                onNext: { [unowned self] in
                    provider.request(.createPost(contentTxtView.text!, currentFeel, hashTags)) { result in
                        switch result {
                        case .success( _ ):
                            showAlert(title: "게시글 작성 완료", message: nil)
                        case .failure(let error):
                            showAlert(title: "게시글 작성에 실패하셨습니다.", message: error.failureReason)
                            print(error.response?.statusCode)
                        }
                        
                    }
                }).disposed(by: disposeBag)
    }
    
}
