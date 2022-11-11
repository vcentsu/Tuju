//
//  JourneyViewCell.swift
//  Tuju
//
//  Created by Vincentius Sutanto on 03/11/22.
//

import UIKit

class JourneyViewCell: UICollectionViewCell {
    
    var cardColor: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        return view
    }()
    
    
    var imageColor: UIImageView = {
//        let image = UIImage(systemName: "tram")
        let imgView = UIImageView(image: UIImage(named: "merah")) //(frame: CGRectMake(10, 50, 100, 300))
//        imgView.image = image
        imgView.contentMode = .scaleToFill
        imgView.clipsToBounds = true

        return imgView
    }()
    
    var stationA: UILabel = {
        let label = UILabel()
        label.text = "Palmerah"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var stationB: UILabel = {
        let label = UILabel()
        label.text = "Tanah Abang"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var goto: UIImageView = {
//        let image = UIImage(systemName: "tram")

        let imgView = UIImageView(image: UIImage(named: "moving")) //(frame: CGRectMake(10, 50, 100, 300))
//        imgView.image = image
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true

        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardColor)
        contentView.addSubview(stationA)
        contentView.addSubview(stationB)
        contentView.addSubview(goto)
        
        cardColor.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.size.width, height: 20, enableInsets: false)
        stationA.anchor(top: cardColor.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 15, paddingBottom: 10, paddingRight: 10, width: 80, height: 20, enableInsets: false)
        goto.anchor(top: cardColor.bottomAnchor, left: stationA.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 90, height: 20, enableInsets: false)
        stationB.anchor(top: cardColor.bottomAnchor, left: goto.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 15, width: 80, height: 20, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
