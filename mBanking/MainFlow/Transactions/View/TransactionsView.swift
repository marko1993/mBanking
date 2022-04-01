//
//  TransactionsView.swift
//  mBanking
//
//  Created by Marko Matijević on 26.03.2022..
//

import UIKit

class TransactionsView: UIView, BaseView {
    
    private let acountsLabel = UILabel()
    let logoutImage = UIImageView(image: UIImage(named: "logoutImage"))
    lazy var acountsCollectionsView: UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        return cv
    }()
    let transactionsLabel = UILabel()
    let transactionsTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(acountsLabel)
        addSubview(logoutImage)
        addSubview(acountsCollectionsView)
        addSubview(transactionsLabel)
        addSubview(transactionsTableView)
    }
    
    func styleSubviews() {
        acountsLabel.text = "Acounts"
        transactionsLabel.text = "Transactions"
        styleAcountsCollectionsView()
        styleTransactionsTableView()
    }
    
    func positionSubviews() {
        acountsLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 16, right: 0))
        
        logoutImage.anchor(top: self.safeAreaLayoutGuide.topAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 16, right: 16), size: CGSize(width: 20, height: 20))
        
        acountsCollectionsView.anchor(top: acountsLabel.bottomAnchor,leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 20, right: 16))
        acountsCollectionsView.constrainHeight(110)
        
        transactionsLabel.anchor(top: acountsCollectionsView.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 12, right: 0))
        
        transactionsTableView.anchor(top: transactionsLabel.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 16, right: 0))
    }
    
    private func styleTransactionsTableView() {
        transactionsTableView.backgroundColor = .clear
        transactionsTableView.rowHeight = TransactionTableViewCell.rowHeight
        transactionsTableView.separatorStyle = .none
        transactionsTableView.showsVerticalScrollIndicator = false
        transactionsTableView.contentInsetAdjustmentBehavior = .never
        transactionsTableView.allowsSelection = false
        transactionsTableView.tableHeaderView = nil
        transactionsTableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.cellIdentifier)
    }
    
    private func styleAcountsCollectionsView() {
        acountsCollectionsView.delaysContentTouches = false
        acountsCollectionsView.translatesAutoresizingMaskIntoConstraints = false
        acountsCollectionsView.isScrollEnabled = true
        acountsCollectionsView.showsVerticalScrollIndicator = false
        acountsCollectionsView.showsHorizontalScrollIndicator = false
        acountsCollectionsView.backgroundColor = .clear
        acountsCollectionsView.isPagingEnabled = false
        acountsCollectionsView.backgroundView?.backgroundColor = .clear
        acountsCollectionsView.register(AcountCollectionViewCell.self, forCellWithReuseIdentifier: AcountCollectionViewCell.cellIdentifier)
    }
    
}
