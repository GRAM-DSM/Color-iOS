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
<<<<<<< Updated upstream
=======
    
    func makeUnderLine() {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height-1, width: self.frame.width, height: 1)
        border.borderWidth = 1
        border.borderColor = UIColor.gray.cgColor
        self.layer.addSublayer(border)
    }
>>>>>>> Stashed changes
}
