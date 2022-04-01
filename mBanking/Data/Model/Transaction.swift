//
//  Transaction.swift
//  mBanking
//
//  Created by Marko Matijević on 26.03.2022..
//

import Foundation

struct Transaction: Decodable {
    let id: String
    let date: String
    let description: String
    let amount: String
    let type: String?
}
