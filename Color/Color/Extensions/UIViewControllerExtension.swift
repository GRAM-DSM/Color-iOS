//
//  UIViewControllerExtension.swift
//  Color
//
//  Created by 장서영 on 2021/09/02.
//

import UIKit

extension UIViewController {
    func setLogoNavigationBarTitle() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "Logo_2")
        imageView.image = image
        navigationItem.titleView = imageView
    }
}
