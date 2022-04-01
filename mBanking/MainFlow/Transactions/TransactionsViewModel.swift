//
//  TransactionsViewModel.swift
//  mBanking
//
//  Created by Marko Matijević on 26.03.2022..
//

import Foundation
import RxSwift
import RxCocoa

class TransactionsViewModel: BaseViewModel {
    
    private let acounts: BehaviorRelay<[Acount]> = BehaviorRelay(value: [])
    var acountsObservable: Observable<[Acount]> {
        return acounts.asObservable()
    }
    
    private let monthlyTransactions: BehaviorRelay<[MonthlyTransactions]> = BehaviorRelay(value: [])
    var monthlyTransactionsObservable: Observable<[MonthlyTransactions]> {
        return monthlyTransactions.asObservable()
    }
    
    func getGetTransactionCount(index: Int) -> Int  {
        return monthlyTransactions.value[index].transactions.count
    }
    
    func getTransaction(section: Int, index: Int) -> Transaction {
        return monthlyTransactions.value[section].transactions[index]
    }
    
    
    func getMonthlyTransactionsCount() -> Int {
        return monthlyTransactions.value.count
    }
    
    func getMonthlyTransactionDate(index: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        return dateFormatter.string(from: monthlyTransactions.value[index].month)
    }
    
    func fetchAccountsData() {
        self.networkRequestState.accept(.started)
        self.repository.fetchAcountDetails()
            .subscribe(onNext: { [weak self] response in
                self?.acounts.accept(response.acounts)
                self?.acountSelected(at: IndexPath(row: 0, section: 0))
                self?.networkRequestState.accept(.finished)
            }, onError: { error in
                self.errorMessage.accept(K.Error.somethingWentWrong)
                self.networkRequestState.accept(.finished)
            }).disposed(by: disposeBag)
    }
    
    func logout() {
        self.repository.logout()
        self.getAppCoordinator()?.presentAuthenticateScreen()
    }
    
    func acountSelected(at indexPath: IndexPath) {
        updateSelectedAcount(at: indexPath)
        monthlyTransactions.accept(acounts.value[indexPath.row].getSortedMonthlyTransactions())
    }
    
    private func updateSelectedAcount(at indexPath: IndexPath) {
        var updatedAcounts = acounts.value
        for index in 0..<updatedAcounts.count {
            updatedAcounts[index].setIsSelected(false)
        }
        updatedAcounts[indexPath.row].setIsSelected(true)
        acounts.accept(updatedAcounts)
    }
    
}
