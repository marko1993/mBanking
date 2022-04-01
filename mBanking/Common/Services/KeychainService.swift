//
//  KeychainService.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import Foundation
import KeychainAccess

class KeychainService {
    let keychain = Keychain(service: K.Keychain.service)
    
    func savePINCode(_ code: String) {
        keychain[K.Keychain.PINCode] = code
    }
    
    func getPINCode() -> String? {
        return keychain[K.Keychain.PINCode]
    }
    
    func deletePINCode() {
        keychain[K.Keychain.PINCode] = nil
    }
    
}
