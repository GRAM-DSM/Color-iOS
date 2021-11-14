//
//  SignUpViewController.swift
//  Color
//
//  Created by 장서영 on 2021/11/07.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class SignUpViewController: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak private var popVCButton: UIButton!
    
    @IBOutlet weak private var nickNameTextField: UITextField!
    @IBOutlet weak private var confirmNickNameButton: UIButton!
    
    @IBOutlet weak private var pwTextField: UITextField!
    
    @IBOutlet weak private var confirmPWTextField: UITextField!
    
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var sendHexCodeButton: UIButton!
    
    @IBOutlet weak private var hexColorTextField: UITextField!
    @IBOutlet weak private var confirmColorButton: UIButton!
    
    @IBOutlet weak private var signUpButton: UIButton!
    
    // MARK: - Properties
    
    let provider = MoyaProvider<ColorAPI>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popVC()
        confirmNickName()
        pwTextField.textContentType = .oneTimeCode
        confirmPWTextField.textContentType = .oneTimeCode
        hexcodeToUIColor()
    }
    
    override func viewDidLayoutSubviews() {
        makeUnderLine()
    }
    
    // MARK: - private Method
    
    private func makeUnderLine() {
        [nickNameTextField, pwTextField, confirmPWTextField, emailTextField].forEach({$0.makeUnderLine()})
    }
    
    // MARK: - Networking Method
    
    private func confirmNickName() {
        confirmNickNameButton.rx.tap
            .subscribe(
                onNext: {[unowned self] in
                    provider.request(
                        .confirmNickName(nickNameTextField.text!)) { result in
                            switch result {
                            case .success( _ ):
                                showAlert(title: "사용 가능한 닉네임입니다.", message: nil)
                                sendEmail()
                            case .failure(let error):
                                switch error.response?.statusCode {
                                case 409:
                                    showAlert(title: "중복된 닉네임입니다.", message: error.failureReason)
                                default:
                                    showAlert(title: "오류가 발생했습니다.", message: nil)
                                }
                            }
                        }
                },
                onError: {[unowned self] _ in
                    showAlert(title: "오류가 발생했습니다.", message: nil)
                }).disposed(by: disposeBag)
    }
    
    func sendEmail() {
        sendHexCodeButton.rx.tap
            .subscribe(
                onNext: {[unowned self] in
                    provider.request(.sendEmail(emailTextField.text!)) { result in
                        switch result {
                        case .success( _ ):
                            showAlert(title: "메일로 컬러 코드가 전송되었습니다.", message: "코드를 복사해 아래 동그라미에 붙여 넣어 주세요.")
                            confirmEmail()
                        case .failure(let error):
                            showAlert(title: "메일 전송에 실패하였습니다.", message: error.failureReason)
                        }
                        
                    }
                },
                onError: {[unowned self] _ in
                    showAlert(title: "오류가 발생했습니다.", message: nil)
                }).disposed(by: disposeBag)
    }
    
    private func confirmEmail() {
        confirmColorButton.rx.tap
            .subscribe(
                onNext: {[unowned self] in
                    provider.request(
                        .confirmEmail(emailTextField.text!, hexColorTextField.text!)) { result in
                            switch result {
                            case .success( _ ):
                                showAlert(title: "인증이 완료되었습니다.", message: nil)
                                confirmColorButton.setTitle("컬러가 일치합니다 :)", for: .normal)
                                signUpNetworking()
                            case .failure(let error):
                                showAlert(title: "인증에 실패했습니다.", message: error.failureReason)
                            }
                        }
                },
                onError: {[unowned self] _ in
                    showAlert(title: "오류가 발생했습니다.", message: nil)
                }).disposed(by: disposeBag)
    }
    
    private func signUpNetworking() {
        signUpButton.rx.tap
            .subscribe(
                onNext: {[unowned self] in
                    provider.request(
                        .signUp(emailTextField.text!, pwTextField.text!, nickNameTextField.text!)) { result in
                            switch result {
                            case .success( _ ):
                                showAlert(title: "회원가입 성공", message: nil)
                            case .failure(let error):
                                showAlert(title: "회원가입에 실패했습니다.", message: error.failureReason)
                            }
                        }
                },
                onError: {[unowned self] _ in
                    showAlert(title: "오류가 발생했습니다.", message: nil)
                }).disposed(by: disposeBag)
    }
    
    private func popVC() {
        popVCButton.rx.tap
            .bind(onNext: { [unowned self] in
                navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func hexcodeToUIColor() {
        hexColorTextField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { [unowned self] in
                print("hex")
                hexColorTextField.backgroundColor = .blue
            }).disposed(by: disposeBag)
    }
    
}
