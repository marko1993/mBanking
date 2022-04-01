//
//  TransactionsViewController.swift
//  mBanking
//
//  Created by Marko Matijević on 26.03.2022..
//

import UIKit
import RxSwift
import RxCocoa

class TransactionsViewController: BaseViewController {
    
    let viewModel: TransactionsViewModel
    private let transactionsView = TransactionsView()
    
    init(viewModel: TransactionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(transactionsView)
        setupBinding()
        viewModel.fetchAccountsData()
    }
    
    func setupBinding() {
        bind(requestState: self.viewModel.networkRequestState.asObservable())
        bind(errorMessage: self.viewModel.errorMessage.asObservable())
        setupBindingsForAccountsCollectionView()
        setupBindingForTransactionsTableView()
    }
    
    private func setupBindingsForAccountsCollectionView() {
        transactionsView.acountsCollectionsView.delegate = nil
        transactionsView.acountsCollectionsView.dataSource = nil
        transactionsView.acountsCollectionsView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel
            .acountsObservable
            .observeOn(MainScheduler.instance)
            .bind(to: transactionsView.acountsCollectionsView
                .rx
                .items) { cv, row, data in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: AcountCollectionViewCell.cellIdentifier, for: IndexPath.init(row: row, section: 0)) as! AcountCollectionViewCell
                
                cell.setup(with: data)
                return cell
            }.disposed(by: disposeBag)
        
        transactionsView.acountsCollectionsView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.viewModel.acountSelected(at: indexPath)
        }).disposed(by: disposeBag)
        
        viewModel.monthlyTransactionsObservable.observeOn(MainScheduler.instance).subscribe(onNext: { _ in
            self.transactionsView.transactionsTableView.reloadData()
        }).disposed(by: disposeBag)
        
        transactionsView.logoutImage.onTap(disposeBag: disposeBag) {
            self.viewModel.logout()
        }
    }
    
    private func setupBindingForTransactionsTableView() {
        transactionsView.transactionsTableView.delegate = self
        transactionsView.transactionsTableView.dataSource = self
    }
    
}

extension TransactionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 100)
    }
}

extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getGetTransactionCount(index: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.cellIdentifier, for: indexPath) as! TransactionTableViewCell
        cell.setup(with: viewModel.getTransaction(section: indexPath.section, index: indexPath.row))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getMonthlyTransactionsCount()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getMonthlyTransactionDate(index: section)
    }
    
}
