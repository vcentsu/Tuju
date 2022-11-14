//
//  PerjalananViewController.swift
//  Tuju
//
//  Created by Vincentius Sutanto on 02/11/22.
//

import UIKit

class PerjalananViewController: UIViewController {
    
    var delegate: PerjalananViewControllerDelegate?
    
    
    private var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private var tujuan: UILabel = {
        let label = UILabel()
        label.text = "Menuju Stasiun \(Destination)"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    private var infoWaktu: UILabel = {
        let label = UILabel()
        label.text = "\(RoutesData.count-1) stasiun lagi - 25 menit"
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
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 18
        button.setTitle("Ubah Tujuan", for: .normal)
        button.setTitleColor(UIColor(red: 250/255, green: 107/255, blue: 17/255, alpha: 1), for: .normal) //orangeBtn
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 250/255, green: 107/255, blue: 17/255, alpha: 1).cgColor
        return button
    }()
    
    private var stopBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 18
        button.setTitle("Berhenti", for: .normal)
        button.setTitleColor(UIColor(red: 250/255, green: 107/255, blue: 17/255, alpha: 1), for: .normal) //orangeBtn
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 250/255, green: 107/255, blue: 17/255, alpha: 1).cgColor
        return button
    }()
    
    private var cardColor: UIView = {
        let view = UIView()
        return view
    }()
    
    private var transitLabel1: UILabel = {
        let label = UILabel()
        label.text = "TRANSIT"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        return label
        
    }()
    
    private var transitLabel2: UILabel = {
        let label = UILabel()
        label.text = "TRANSIT"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let currentImg: UIImageView = {
        let image = UIImage(systemName: "tram")
        let imgView = UIImageView()
        imgView.image = image
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true

        return imgView
    }()
    
    private let nextImg: UIImageView = {
        let image = UIImage(systemName: "tram.fill")
        let imgView = UIImageView()
        imgView.image = image
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true

        return imgView
    }()
    
    private var goto: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "moving"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true

        return imgView
    }()
    
    private var currentStation: UILabel = {
        let label = UILabel()
        label.text = "Pasar Minggu Baru"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var nextStation: UILabel = {
        let label = UILabel()
        label.text = "Tanah Abang"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private var timeStation: UILabel = {
        let label = UILabel()
        label.text = "15 menit"
        label.font = .systemFont(ofSize: 13, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    lazy var emptyImg: UIImageView = {
        let image = UIImage(systemName: "tram.fill")
        let imgView = UIImageView()
        imgView.image = image
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.tintColor = UIColor(red: 255/255, green: 118/255, blue: 12/255, alpha: 0.5)
        imgView.isHidden = true
        return imgView
    }()
    
    lazy var emptyLbl: UILabel = {
        let label = UILabel()
        label.text = "Anda sedang berada pada rute terakhir"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(red: 124/255, green: 24/255, blue: 124/255, alpha: 0.5)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    var myCollectionView: UICollectionView!
    
    var currStation = ""
    var neStation = ""
    let isTransit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        //navigationItem.hidesBackButton = true
        
        //TOP
        view.addSubview(titleView)
        titleView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.size.width, height: 85, enableInsets: false)
        titleView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 85)
        titleView.applyGradient(withColours: [UIColor(red: 222/255, green: 0, blue: 0, alpha: 1),UIColor(red: 255/255, green: 119/255, blue: 10/255, alpha: 1)], gradientOrientation: .topRightBottomLeft)
        
        titleView.addSubview(tujuan)
        titleView.addSubview(infoWaktu)
        tujuan.anchor(top: titleView.topAnchor, left: titleView.leftAnchor, bottom: nil, right: titleView.rightAnchor, paddingTop: 27, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: titleView.frame.size.width-40, height: 20, enableInsets: false)
        infoWaktu.anchor(top: tujuan.bottomAnchor, left: titleView.leftAnchor, bottom: nil, right: titleView.rightAnchor, paddingTop: 0 , paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: titleView.frame.size.width-40, height: 20, enableInsets: false)
        
        
        // MAIN CONTENT
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBlue
        
        view.addSubview(contentView)
        contentView.anchor(top: titleView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.size.width, height: 285, enableInsets: false)
        
        contentView.addSubview(background)
        background.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: contentView.frame.size.width, height: contentView.frame.size.height, enableInsets: false)
        
        // CARD
        contentView.addSubview(cardView)
        cardView.backgroundColor = .white
        cardView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: contentView.frame.size.width-60, height: 157, enableInsets: false)
        
        cardView.addSubview(cardColor)
        cardColor.backgroundColor = .systemGreen
        cardColor.anchor(top: cardView.topAnchor, left: cardView.leftAnchor, bottom: nil, right: cardView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: cardView.frame.size.width, height: 20, enableInsets: false)
        
        cardView.addSubview(transitLabel1)
        cardView.addSubview(currentImg)
        currentImg.tintColor = .systemOrange
        cardView.addSubview(currentStation)
        cardView.addSubview(goto)
        cardView.addSubview(transitLabel2)
        cardView.addSubview(nextImg)
        nextImg.tintColor = .systemOrange
        cardView.addSubview(nextStation)
        cardView.addSubview(timeStation)

        transitLabel1.anchor(top: cardColor.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 20, paddingBottom: 0, paddingRight: 10, width: 90, height: 20, enableInsets: false)
        currentImg.anchor(top: transitLabel1.bottomAnchor, left: cardView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 20, width: 50, height: 40, enableInsets: false)
        currentStation.anchor(top: currentImg.bottomAnchor, left: cardView.leftAnchor, bottom: cardView.bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 20, paddingBottom: 8, paddingRight: 10, width: 90, height: 45, enableInsets: false)
        
        transitLabel2.anchor(top: cardColor.bottomAnchor, left: nil, bottom: nil, right: cardView.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 90, height: 20, enableInsets: false)
        nextImg.anchor(top: transitLabel2.bottomAnchor, left: nil, bottom: nil, right: cardView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 40, width: 50, height: 40, enableInsets: false)
        nextStation.anchor(top: nextImg.bottomAnchor, left: nil, bottom: cardView.bottomAnchor, right: cardView.rightAnchor, paddingTop: 3, paddingLeft: 10, paddingBottom: 8, paddingRight: 20, width: 90, height: 45, enableInsets: false)
        
        goto.anchor(top: cardColor.bottomAnchor, left: currentImg.rightAnchor, bottom: nil, right: nextImg.leftAnchor, paddingTop: 40, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 140, height: 45, enableInsets: false)
        timeStation.anchor(top: goto.bottomAnchor, left: currentImg.rightAnchor, bottom: nil, right: nextImg.leftAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 50, height: 15, enableInsets: false)
        
        contentView.addSubview(ubahBtn)
        contentView.addSubview(stopBtn)
        ubahBtn.anchor(top: cardView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 30, paddingBottom: 0, paddingRight: 15, width: 160, height: 40, enableInsets: false)
        stopBtn.anchor(top: cardView.bottomAnchor, left: ubahBtn.rightAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 30, width: 160, height: 40, enableInsets: false)

        
        //COLLECTION
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.register(JourneyViewCell.self, forCellWithReuseIdentifier: "cell")
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        view.addSubview(myCollectionView)
        myCollectionView.anchor(top: contentView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.size.width, height: view.frame.size.height, enableInsets: false)
        myCollectionView.backgroundColor = backgroundColor
        
        self.myCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        view.addSubview(emptyImg)
        view.addSubview(emptyLbl)
        emptyImg.anchor(top: myCollectionView.topAnchor , left: myCollectionView.leftAnchor, bottom: nil, right: myCollectionView.rightAnchor, paddingTop: 90, paddingLeft: 80, paddingBottom: 0, paddingRight: 80, width: 70, height: 70, enableInsets: false)
        emptyLbl.anchor(top: emptyImg.bottomAnchor, left: myCollectionView.leftAnchor, bottom: nil, right: myCollectionView.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 270, height: 60, enableInsets: false)
    }

}

extension PerjalananViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
             sectionHeader.label.text = "Rute Berikutnya"
             return sectionHeader
        } else { //No footer in this case but can add option for that
             return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(350), height: CGFloat(90))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if RoutesData.count == 2 {
            if hijauData.contains(where: {$0.namaStasiun == RoutesData[0].namaStasiun}) {
                cardColor.backgroundColor = .systemGreen
                currentImg.tintColor = .systemGreen
            } else if birukiriData.contains(where: {$0.namaStasiun == RoutesData[0].namaStasiun}) {
                cardColor.backgroundColor = .systemBlue
                currentImg.tintColor = .systemBlue
            } else if birukananData.contains(where: {$0.namaStasiun == RoutesData[0].namaStasiun}) {
                cardColor.backgroundColor = .systemBlue
                currentImg.tintColor = .systemBlue
            } else if merahatasData.contains(where: {$0.namaStasiun == RoutesData[0].namaStasiun}) {
                cardColor.backgroundColor = .systemRed
                currentImg.tintColor = .systemRed
            } else if merahbawahData.contains(where: {$0.namaStasiun == RoutesData[0].namaStasiun}) {
                cardColor.backgroundColor = .systemRed
                currentImg.tintColor = .systemRed
            }
            
            currentStation.text = RoutesData[0].namaStasiun
            nextStation.text =  RoutesData[1].namaStasiun
            
            emptyImg.isHidden = false
            emptyLbl.isHidden = false
        }else{
            emptyImg.isHidden = true
            emptyLbl.isHidden = true
        }
        return (RoutesData.count - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? JourneyViewCell)
        cell?.stationA.text = RoutesData[indexPath.row+1].namaStasiun
        cell?.stationB.text = RoutesData[indexPath.row+2].namaStasiun

        if hijauData.contains(where: {$0.namaStasiun == RoutesData[indexPath.row+1].namaStasiun}) {
            cell?.cardColor.backgroundColor = .systemGreen
        } else if birukiriData.contains(where: {$0.namaStasiun == RoutesData[indexPath.row+1].namaStasiun}) {
            cell?.cardColor.backgroundColor = .systemBlue
        } else if birukananData.contains(where: {$0.namaStasiun == RoutesData[indexPath.row+1].namaStasiun}) {
            cell?.cardColor.backgroundColor = .systemBlue
        } else if merahatasData.contains(where: {$0.namaStasiun == RoutesData[indexPath.row+1].namaStasiun}) {
            cell?.cardColor.backgroundColor = .systemRed
        } else if merahbawahData.contains(where: {$0.namaStasiun == RoutesData[indexPath.row+1].namaStasiun}) {
            cell?.cardColor.backgroundColor = .systemRed
        }
        
        if indexPath.row == 0 {
            if hijauData.contains(where: {$0.namaStasiun == RoutesData[indexPath.row].namaStasiun}) {
                cardColor.backgroundColor = .systemGreen
            } else if birukiriData.contains(where: {$0.namaStasiun == RoutesData[indexPath.row].namaStasiun}) {
                cardColor.backgroundColor = .systemBlue
            } else if birukananData.contains(where: {$0.namaStasiun == RoutesData[indexPath.row].namaStasiun}) {
                cardColor.backgroundColor = .systemBlue
            } else if merahatasData.contains(where: {$0.namaStasiun == RoutesData[indexPath.row].namaStasiun}) {
                cardColor.backgroundColor = .systemRed
            } else if merahbawahData.contains(where: {$0.namaStasiun == RoutesData[indexPath.row].namaStasiun}) {
                cardColor.backgroundColor = .systemRed
            }
            
            currentStation.text = RoutesData[indexPath.row].namaStasiun
            nextStation.text =  RoutesData[indexPath.row+1].namaStasiun
        }
        
        cell?.backgroundColor = .white
        return cell!
    }
}
