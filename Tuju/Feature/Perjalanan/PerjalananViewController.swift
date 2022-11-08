//
//  PerjalananViewController.swift
//  Tuju
//
//  Created by Vincentius Sutanto on 02/11/22.
//

import UIKit

class PerjalananViewController: UIViewController {
    
    private var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private var tujuan: UILabel = {
        let label = UILabel()
        label.text = "Menuju Stasiun Manggarai"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var infoWaktu: UILabel = {
        let label = UILabel()
        label.text = "4 stasiun lagi - 25 menit"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let background: UIImageView = {
        let image = UIImage(named: "background")
        let imgView = UIImageView()
        imgView.image = image
        imgView.contentMode = .scaleToFill
        imgView.clipsToBounds = true

        return imgView
    }()
    
    private var cardView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var ubahBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 18
        button.setTitle("Ubah Tujuan", for: .normal)
        return button
    }()
    
    private var stopBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 18
        button.setTitle("Berhenti", for: .normal)
        return button
    }()
    
    private var contentStack:UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally // Setting the distribution to fill based on the content
        return stack
    }()
    
//    private var btnStack:UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .horizontal
//        stack.distribution = .fillProportionally // Setting the distribution to fill based on the content
//        return stack
//    }()
    
    private var cardColor: UIView = {
        let view = UIView()
        return view
    }()
    
    private var transitLabel: UILabel = {
        let label = UILabel()
        label.text = "TRANSIT"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private var currentStation: UILabel = {
        let label = UILabel()
        label.text = "Palmerah"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private var nextStation: UILabel = {
        let label = UILabel()
        label.text = "Tanah Abang"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private var timeStation: UILabel = {
        let label = UILabel()
        label.text = "15 menit"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationItem.hidesBackButton = true
        
        //TOP
        view.addSubview(titleView)
        titleView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 85)
        
        titleView.addSubview(tujuan)
        titleView.addSubview(infoWaktu)
        tujuan.frame = CGRect(x: 20, y: 30, width: view.frame.size.width-40, height: 20)
        infoWaktu.frame = CGRect(x: 20, y: 30+tujuan.frame.size.height, width: view.frame.size.width-40, height: 20)
        
        //CARD
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBlue
        
        view.addSubview(contentView)
        contentView.frame = CGRect(x: 0, y: titleView.frame.size.height, width: view.frame.size.width, height: 280)
        
        contentView.addSubview(background)
        background.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        
        contentView.addSubview(cardView)
        cardView.backgroundColor = .white
        cardView.frame = CGRect(x: 30, y: 15, width: contentView.frame.size.width-60, height: 152)
        
        cardView.addSubview(cardColor)
        cardColor.backgroundColor = .systemGreen
        cardColor.frame = CGRect(x: 0, y: 0, width: cardView.frame.size.width, height: 20)
        
        contentView.addSubview(ubahBtn)
        contentView.addSubview(stopBtn)
        ubahBtn.frame = CGRect(x: 30, y: 30+cardView.frame.size.height, width: 160, height: 40)
        stopBtn.frame = CGRect(x: Int(contentView.frame.size.width-ubahBtn.frame.size.width)-30, y: 30+Int(cardView.frame.size.height), width: 160, height: 40)
        
        //TABLE
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: 350, height: 90)
        layout.scrollDirection = .horizontal
        
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //if you use xibs:
        //self.collectionView.register(UINib(nibName:"MyCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        myCollectionView.register(JourneyViewCell.self, forCellWithReuseIdentifier: "cell")
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        view.addSubview(myCollectionView)
        myCollectionView.frame = CGRect(x: 0, y: titleView.frame.size.height+contentView.frame.size.height, width: view.frame.size.width, height: view.frame.size.height-contentView.frame.size.height)
        view.backgroundColor = .systemGray6
        myCollectionView.backgroundColor = .systemGray6
    }


}

extension PerjalananViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(380), height: CGFloat(300))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 8, bottom: 5, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! JourneyViewCell
        cell.backgroundColor = .white
        return cell
    }
    
}
