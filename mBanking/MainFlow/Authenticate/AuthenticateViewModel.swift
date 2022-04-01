//
//  AuthenticateViewModel.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import Foundation
import RxSwift
import RxCocoa

class AuthenticateViewModel: BaseViewModel {
    
    func authenticate(PINCode: String)  {
        if self.isPINCodeSaved() {
            if isCorrectPINCode(PINCode) {
                presentTransactionsViewController()
            } else {
                self.errorMessage.accept(K.Error.incorrectPIN)
            }
        } else {
            savePINCode(PINCode)
            presentTransactionsViewController()
        }
    }
    
    private func savePINCode(_ code: String) {
        repository.savePINCode(code)
    }
    
    func isPINCodeSaved() -> Bool {
        return repository.isPINCodeSaved()
    }
    
    private func isCorrectPINCode(_ code: String) -> Bool {
        return repository.isPINCodeCorrect(code)
    }
    
    func presentTransactionsViewController() {
        (self.coordinator as? AppCoordinator)?.presentTransactionsScreen()
    }
    
}
