//
//  RecommendationTableViewCell.swift
//  Tuju
//
//  Created by Vincentius Sutanto on 14/10/22.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {

    var imageStasiun: UIImageView = {
        let image = UIImage(systemName: "tram")

        let imgView = UIImageView()
        imgView.image = image
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true

        return imgView
    }()
    
    let namaStasiun: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let jarakStasiun: UILabel = {
        let label = UILabel()
        label.textColor = .purple
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .left
        return label
    }()
    
    var stasiun : Stasiun? {
        didSet {
            namaStasiun.text = stasiun?.stasiunName
            jarakStasiun.text = stasiun?.stasiunDesc
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageStasiun)
        contentView.addSubview(namaStasiun)
        contentView.addSubview(jarakStasiun)
        
        imageStasiun.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 0, width: 40, height: 40, enableInsets: false)
        namaStasiun.anchor(top: topAnchor, left: imageStasiun.rightAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        jarakStasiun.anchor(top: namaStasiun.bottomAnchor, left: imageStasiun.rightAnchor, bottom: nil, right: nil, paddingTop: 3, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
