//
//  ExtensionFile.swift
//  SaltCodeTest
//
//  Created by Chrismanto Natanail Manik on 13/11/22.
//

import Foundation
import UIKit
extension UITextField{
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setShowHideRightIcon(){
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        rightButton.tintColor = .lightGray
        rightButton.imageView?.contentMode = .scaleAspectFit
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 22.0)
        rightButton.addTarget(self, action: #selector(previewAction(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([rightButton.widthAnchor.constraint(equalToConstant: 44.0)])
        rightView  = rightButton
        rightViewMode = .always
        isSecureTextEntry = true
    }
    
    
    @objc func previewAction(_ sender: UIButton){
        isSecureTextEntry = !isSecureTextEntry
        if isSecureTextEntry{
            sender.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }else{
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
}

extension UIImageView {
    func load(urlString: String) {
        guard let url = URL(string: urlString) else{
            print("No URL Image")
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
