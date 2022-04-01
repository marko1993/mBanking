//
//  TransactionTableViewCell.swift
//  mBanking
//
//  Created by Marko Matijević on 01.04.2022..
//

import UIKit

class TransactionTableViewCell: UITableViewCell, BaseView {
    
    let containerView = UIView()
    let descriptionLabel = UILabel()
    let borderView = UIView()
    let dateLabel = UILabel()
    let amountLabel = UILabel()
    let transactionTypeLabel = TransactionTypeLabel()
    
    var transaction : Transaction!
    
    static let cellIdentifier = "TransactionTableViewCell"
    static let rowHeight: CGFloat = 110.0
    
    func addSubviews() {
        addSubview(containerView)
        addSubview(descriptionLabel)
        addSubview(borderView)
        addSubview(amountLabel)
        addSubview(dateLabel)
        addSubview(transactionTypeLabel)
    }
    
    func styleSubviews() {
        descriptionLabel.text = transaction.description
        
        amountLabel.text = transaction.amount
        amountLabel.textAlignment = .right
        
        transactionTypeLabel.text = transaction.type
        transactionTypeLabel.isHidden = transaction.type == nil
        
        dateLabel.text = transaction.date
        dateLabel.font = UIFont.boldSystemFont(ofSize: 14)
        dateLabel.textColor = UIColor.lightGray
        dateLabel.textAlignment = .right
        
        borderView.backgroundColor = UIColor.lightGray
        
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 0.1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.backgroundColor = .white
    }
    
    func positionSubviews() {
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16))
        descriptionLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 2, right: 20))
        descriptionLabel.constrainHeight(30)
        
        borderView.anchor(top: descriptionLabel.bottomAnchor, leading: leadingAnchor, padding: UIEdgeInsets(top: 2, left: 20, bottom: 6, right: 9), size: CGSize(width: 120, height: 1))
        
        dateLabel.anchor(top: topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 6, left: 8, bottom: 8, right: 20), size: CGSize(width: 100, height: 30))
        
        amountLabel.anchor(top: borderView.bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 20), size: CGSize(width: 120, height: 30))
        
        transactionTypeLabel.anchor(top: borderView.bottomAnchor, leading: leadingAnchor, padding: UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 8))
    }
    
    func setup(with transaction: Transaction) {
        self.transaction = transaction
        self.setupView()
    }
    
}
