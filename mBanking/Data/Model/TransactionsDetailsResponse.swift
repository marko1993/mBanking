//
//  TransactionsDetailsResponse.swift
//  mBanking
//
//  Created by Marko Matijević on 26.03.2022..
//

import Foundation

struct TransactionsDetailsResponse: Decodable {
    let userId: String
    let acounts: [Acount]
}
