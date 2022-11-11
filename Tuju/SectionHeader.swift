//
//  SectionHeader.swift
//  Tuju
//
//  Created by Vincentius Sutanto on 08/11/22.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    var label: UILabel = {
             let label: UILabel = UILabel()
             label.textColor = .black
             label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
             label.sizeToFit()
             return label
         }()

         override init(frame: CGRect) {
             super.init(frame: frame)

             addSubview(label)

             label.translatesAutoresizingMaskIntoConstraints = false
             label.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 50, height: 20, enableInsets: false)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
