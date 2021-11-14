//
//  LoginViewController.swift
//  Color
//
//  Created by 장서영 on 2021/11/07.
//

import UIKit
import RxCocoa
import RxSwift
import Moya

class LoginViewController: UIViewController {
    
    // MARK: - UI
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var pwTextField: UITextField!
    
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var signUpButton: UIButton!
    
    // MARK: - Properties
    let provider = MoyaProvider<ColorAPI>()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        login()
    }
    
    override func viewDidLayoutSubviews() {
        makeTextFieldUnderLine()
        makeButtonUnderLine()
    }
    
    private func makeTextFieldUnderLine() {
        [emailTextField, pwTextField].forEach({$0?.makeUnderLine()})
    }
    
    private func makeButtonUnderLine() {
        signUpButton.makeUnderLine()
    }
    
    private func login() {
        loginButton.rx.tap
            .bind(onNext: { [unowned self] in
                provider.request(.login(emailTextField.text!, pwTextField.text!, "asdfasdf")) { result in
                    switch result {
                    case .success(let response):
                        let result = try? JSONDecoder().decode(Tokens.self, from: response.data)
                        TokenUtils.shared.save(result!)
                    case .failure(let error):
                        showAlert(title: "로그인에 실패햐였습니다.", message: error.errorDescription)
                    }
                }
            }).disposed(by: disposeBag)
    }
}
