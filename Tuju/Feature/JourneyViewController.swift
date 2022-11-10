//
//  JourneyViewController.swift
//  Tuju
//
//  Created by Vincentius Sutanto on 25/10/22.
//

import UIKit

class JourneyViewController: UIViewController {

    private var background: UIImageView = {
        let image = UIImage(systemName: "")

        let imgView = UIImageView()
        imgView.image = image
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true

        return imgView
    }()
    
    private var tujuan: UILabel = {
        let label = UILabel()
        label.text = "Menuju Stasiun Manggarai"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private var infoWaktu: UILabel = {
        let label = UILabel()
        label.text = "4 stasiun lagi - 25 menit"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private var isTransit: UILabel = {
        let label = UILabel()
        label.text = "TRANSIT"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private var cardView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var ubahBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    private var stopBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tujuan)
        view.addSubview(infoWaktu)
        
        //tujuan.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
    }

}
