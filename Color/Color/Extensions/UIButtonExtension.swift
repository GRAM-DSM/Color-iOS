//
//  UIButtonExtension.swift
//  Color
//
//  Created by 장서영 on 2021/10/14.
//

import Foundation
import UIKit

extension UIButton {
    func chooseColor(buttonColor: UIColor) {
        if self.backgroundColor == buttonColor {
            self.backgroundColor = .white
            self.layer.borderColor = buttonColor.cgColor
        } else {
            self.backgroundColor = buttonColor
        }
    }
}
