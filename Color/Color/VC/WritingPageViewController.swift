//
//  WritingPageViewController.swift
//  Color
//
//  Created by 장서영 on 2021/09/02.
//

import UIKit
import Hashtags

class WritingPageViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var selectedColor = UIColor()
    
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
        placeholderSetting()
        introLabel.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction private func redButton(_ sender: UIButton) {
        colorButtonDefaultSetting(button: sender, color: "angry")
    }
    
    @IBAction private func yellowButton(_ sender: UIButton) {
        colorButtonDefaultSetting(button: sender, color: "happy")
    }
    
    @IBAction private func blueButton(_ sender: UIButton) {
        colorButtonDefaultSetting(button: sender, color: "sad")
    }
    
    @IBAction private func grayButton(_ sender: UIButton) {
        colorButtonDefaultSetting(button: sender, color: "bored")
    }
    
    @IBAction private func pinkButton(_ sender: UIButton) {
        colorButtonDefaultSetting(button: sender, color: "love")
    }
    
    @IBAction private func navyButton(_ sender: UIButton) {
        colorButtonDefaultSetting(button: sender, color: "shamed")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text?.replacingOccurrences(of: " ", with: "_")
        let tag = HashTag(word: text!, withHashSymbol: true, isRemovable: true)
        hashtagView.addTag(tag: tag)
        textField.text = " "
        return true
    }
    
    func resetButtonSetting() {
        let buttonAndConceptColor : [String : UIButton] = ["angry": redButton, "happy": yellowButton, "sad": blueButton, "bored": grayButton, "love": pinkButton, "shamed": navyButton]
        
        buttonAndConceptColor.forEach {(key, value) in
            value.backgroundColor = UIColor.init(named: key)
        }
    }
    
    private func placeholderSetting() {
        contentTxtView.delegate = self
        contentTxtView.text = "오늘 하루 당신의 이야기를 들려주세요"
        contentTxtView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray{
            textView.text = nil
            textView.textColor = UIColor.black
        }
        enableButton()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "오늘 하루 당신의 이야기를 들려주세요"
            textView.textColor = UIColor.lightGray
        }
        enableButton()
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
    
}
