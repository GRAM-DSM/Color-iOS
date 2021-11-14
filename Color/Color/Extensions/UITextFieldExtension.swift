//
//  UITextFieldExtension.swift
//  Color
//
//  Created by 장서영 on 2021/11/07.
//

import UIKit

extension UITextField {
    func makeUnderLine() {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height-1, width: self.frame.width, height: 1)
        border.borderWidth = 1
        border.borderColor = UIColor.gray.cgColor
        self.layer.addSublayer(border)
        self.adjustsFontSizeToFitWidth = true
    }
}
