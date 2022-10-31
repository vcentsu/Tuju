//
//  SearchViewController.swift
//  Searching-Locations-iOS
//
//  Created by Ulul I. on 05/10/22.
//

import UIKit
import CoreLocation

protocol PanelViewControllerDelegate: AnyObject {
    func PanelViewController(_ vc: PanelViewController, didSelectLocationWith Coordinate: CLLocationCoordinate2D?)
}

class PanelViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: PanelViewControllerDelegate?
    
    private let asalField: UITextField = {
        let field = UITextField()
        field.placeholder = "Asal: Pilih Stasiun Asal"
        field.layer.cornerRadius = 9
        field.backgroundColor = .tertiarySystemBackground
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        
        return field
    }()
    
    private let tujuanField: UITextField = {
        let field = UITextField()
        field.placeholder = "Tujuan: Pilih Stasiun Tujuan"
        field.layer.cornerRadius = 9
        field.backgroundColor = .tertiarySystemBackground
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        
        return field
    }()
    
    private let startBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 20
        button.setTitle("Mulai Perjalanan", for: .normal)
        button.addTarget(PanelViewController.self, action: #selector(didTapMulai), for: .touchUpInside)
        
        
        return button
    }()
    
    private let label: UILabel = {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "info.circle.fill")
        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " Mulai perjalanan saat berada di stasiun awal")
        imageString.append(textString)
        let label = UILabel()
        label.attributedText = imageString
        label.font = .systemFont(ofSize: 14, weight: .ultraLight)
        return label
    }()
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        //Asal
        view.addSubview(asalField)
        asalField.delegate = self
        
        view.addSubview(tujuanField)
        tujuanField.delegate = self
        
        view.addSubview(label)
        view.addSubview(startBtn)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        asalField.frame = CGRect(x: 20, y: 30, width: view.frame.size.width-40, height: 50)
        tujuanField.frame = CGRect(x: 20, y: 40+asalField.frame.size.height, width: view.frame.size.width-40, height: 50)

        label.sizeToFit()
        label.frame = CGRect(x: 25, y: 120+tujuanField.frame.size.height, width: label.frame.size.width, height: label.frame.size.height)
        startBtn.frame = CGRect(x: 20, y: 180+label.frame.size.height, width: view.frame.size.width-40, height: 50)
    }
    

//    @objc private func didTapButton() {
//
//        let textEntry = AsalViewController()
//        textEntry.completion = { [weak self] text in
//            DispatchQueue.main.async {
//                self?.label.text = text
//            }
//        }
//        let vc = UINavigationController(rootViewController: textEntry)
//        present(vc, animated: true)
//    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if asalField.isEditing {
            print("asal clicked")

            let AsalVC =  UIStoryboard(name: "Asal", bundle: nil).instantiateViewController(withIdentifier: "AsalID")
            if let sheet = AsalVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.preferredCornerRadius = 24
            }
            self.present(AsalVC, animated: true, completion: nil)
            asalField.resignFirstResponder()


        }
        
        if tujuanField.isEditing {
            print("tujuan clicked")

            let TujuanVC =  UIStoryboard(name: "Tujuan", bundle: nil).instantiateViewController(withIdentifier: "TujuanID")
            if let sheet = TujuanVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.preferredCornerRadius = 24
            }
            self.present(TujuanVC, animated: true, completion: nil)
            tujuanField.resignFirstResponder()
        }
    }
    
    // Not used
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        asalField.resignFirstResponder()
//        if let text = asalField.text, !text.isEmpty {
//            LocationManager.shared.findLocations(with: text) { [weak self] locations in
//                DispatchQueue.main.async {
//                    self?.locations = locations
//                    //self?.tableView.reloadData()
//                }
//            }
//        }
//        return true
//    }
    
    @objc func didTapMulai(sender: UIButton!) {
        print("Button tapped")
    }
    
}
