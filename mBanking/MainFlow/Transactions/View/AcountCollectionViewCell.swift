//
//  AcountCollectionViewCell.swift
//  mBanking
//
//  Created by Marko Matijević on 01.04.2022..
//

import UIKit

class AcountCollectionViewCell: UICollectionViewCell, BaseView {
    
    let IBANLabel = UILabel()
    let amountLabel = UILabel()
    
    var acount: Acount!
    static let cellIdentifier = "AcountCollectionViewCell"
    
    func addSubviews() {
        addSubview(IBANLabel)
        addSubview(amountLabel)
    }

    func styleSubviews() {
        IBANLabel.text = acount.IBAN
        IBANLabel.font = UIFont.systemFont(ofSize: 12)
        IBANLabel.textColor = UIColor.lightGray
        
        amountLabel.text = "\(acount.amount) \(acount.currency)"
        amountLabel.textAlignment = .right
        
        self.isUserInteractionEnabled = true
        self.contentView.isUserInteractionEnabled = false
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.layer.borderWidth = acount.isAcountSelected() ? 1 : 0
        self.layer.borderColor = UIColor.systemTeal.cgColor
        self.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.1)
        
    }
    
    func positionSubviews() {
        
        IBANLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        IBANLabel.constrainHeight(30)
        
        amountLabel.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 16, right: 8))
        IBANLabel.constrainHeight(30)
        
    }
    
    func setup(with acount: Acount) {
        self.acount = acount
        self.setupView()
    }

}

