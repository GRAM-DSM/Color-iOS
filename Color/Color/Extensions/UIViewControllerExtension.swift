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
    
    func setNavigationBar(){
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = .white
        bar.layer.shadowOpacity = 0.2
        bar.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 6, width: bar.bounds.width, height: 40)).cgPath
        bar.layer.shadowOffset = CGSize(width: 0, height: 0.1)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
<<<<<<< Updated upstream
=======
    
    func showAlert(title : String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
>>>>>>> Stashed changes
}
