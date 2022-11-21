//
//  Alert.swift
//  Tuju
//
//  Created by Vincentius Sutanto on 21/11/22.
//

import Foundation
import UIKit

class MyAlert {
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgroundView: UIView = {
        let background = UIView()
        background.backgroundColor = .black
        background.alpha = 0
        return background
    }()
    
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    
    private let alertTitle: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    func showAlert(with title: String, message: String, on viewController: UIViewController){
        guard let targetView = viewController.view else {
            return
        }
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        targetView.addSubview(alertView)
        alertView.anchor(top: targetView.topAnchor, left: targetView.leftAnchor, bottom: targetView.bottomAnchor, right: targetView.rightAnchor, paddingTop: 60, paddingLeft: 40, paddingBottom: 60, paddingRight: 40, width: 0, height: 445, enableInsets: false)
        
        alertView.addSubview(alertTitle)
        alertTitle.text = title
        alertTitle.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: nil, right: alertView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0, enableInsets: false)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        })
    }
    
    func dismissAlert(){
        
    }
}
