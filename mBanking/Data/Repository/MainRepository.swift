//
//  MainRepository.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import Foundation
import RxSwift
import RxCocoa

class MainRepository: Repository {
    
    let networkService: NetworkService
    let keychainService: KeychainService
    let disposeBag = DisposeBag()
    
    init(networkService: NetworkService, keychainService: KeychainService) {
        self.networkService = networkService
        self.keychainService = keychainService
    }
    
    func savePINCode(_ code: String)  {
        keychainService.savePINCode(code)
    }
    
    func isPINCodeSaved() -> Bool {
        return keychainService.getPINCode() != nil
    }
    
    func isPINCodeCorrect(_ code: String) -> Bool {
        return keychainService.getPINCode() == code
    }
    
    func fetchAcountDetails() -> Observable<TransactionsDetailsResponse> {
        let resources = Resources<TransactionsDetailsResponse, EmptyRequestBody>(
            path: K.Networking.fetchAcounts,
            requestType: .GET,
            bodyParameters: nil,
            httpHeaderFields: nil,
            queryParameters: nil
        )
        return  networkService.performRequest(resources: resources, retryCount: 1)
    }

    func logout() {
        keychainService.deletePINCode()
    }
    
}
