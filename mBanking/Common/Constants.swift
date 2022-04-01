//
//  Constants.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import Foundation

struct K {
    
    struct Strings {
        static let appName = "mBanking"
        static let ok = "Ok"
    }
    
    struct Networking {
        static let baseUrl = "https://mportal.asseco-see.hr/builds/"
        static let fetchAcounts = "ISBD_public/Zadatak_1.json"
    }
    
    struct Keychain {
        static let service = "com.croentrain.mbanking"
        static let PINCode = "pincode"
    }
    
    struct Error {
        static let incorrectPIN = "PIN is incorrect. Please try again."
        static let somethingWentWrong = "Something went wrong, please try again."
    }
    
}
