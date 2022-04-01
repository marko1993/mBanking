//
//  TransactionTypeView.swift
//  mBanking
//
//  Created by Marko Matijević on 01.04.2022..
//

import UIKit

class TransactionTypeLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        backgroundColor = UIColor.systemTeal.withAlphaComponent(0.1)
        textColor = UIColor.systemTeal
        font = UIFont.systemFont(ofSize: 14)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 20,
                      height: size.height + 20)
    }
    
}
