//
//  Acount.swift
//  mBanking
//
//  Created by Marko Matijević on 26.03.2022..
//

import Foundation

struct Acount: Decodable {
    let id: String
    let IBAN: String
    let amount: String
    let currency: String
    let transactions: [Transaction]
    private var isSelected: Bool? = false
    
    mutating func setIsSelected(_ isSelected: Bool) {
        self.isSelected = isSelected
    }
    
    func isAcountSelected() -> Bool {
        return isSelected ?? false
    }
    
    private func getMonthToTransactionsMap() -> [String : [Transaction]] {
        var transactionsMap: [String : [Transaction]] = [:]
        transactions.forEach { transaction in
            if let date = transaction.date.toDate() {
                let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
                let month = "\(calendarDate.month ?? 0).\(calendarDate.year ?? 0)"
                if transactionsMap[month] != nil {
                    transactionsMap[month]!.append(transaction)
                } else {
                    transactionsMap[month] = [transaction]
                }
            }
            
        }
        return transactionsMap
    }
    
    func getSortedMonthlyTransactions() -> [MonthlyTransactions] {
        var monthlyTransactions: [MonthlyTransactions] = []
        getMonthToTransactionsMap().forEach { mapInput in
            let (key, value) = mapInput
            if let keyDate = key.toDateWithoutDays() {
                let calendarComponents = Calendar.current.dateComponents([.month, .year], from: keyDate)
                var dateComponents = DateComponents()
                dateComponents.month = calendarComponents.month
                dateComponents.year = calendarComponents.year
                if let date = Calendar.current.date(from: dateComponents) {
                    monthlyTransactions.append(MonthlyTransactions(month: date, transactions: value.sorted(by: {$0.date.toDate()!.timeIntervalSince1970 > $1.date.toDate()!.timeIntervalSince1970})))
                }
            }
        }
        return monthlyTransactions.sorted(by: {$0.month.timeIntervalSince1970 > $1.month.timeIntervalSince1970})
    }
}
