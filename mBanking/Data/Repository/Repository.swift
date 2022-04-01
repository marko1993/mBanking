//
//  Repository.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import Foundation
import RxSwift

enum RepositoryType {
    case main, mock
    
    var name: String {
        switch self {
        case .main:
            return "main"
        case .mock:
            return "mock"
        }
    }
}

protocol Repository {
    func savePINCode(_ code: String)
    func isPINCodeSaved() -> Bool
    func isPINCodeCorrect(_ code: String) -> Bool
    func fetchAcountDetails() -> Observable<TransactionsDetailsResponse>
    func logout()
}
