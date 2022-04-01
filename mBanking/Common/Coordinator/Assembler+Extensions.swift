//
//  Assembler+Extensions.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import Foundation
import Swinject

extension Assembler {
    static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler([
            AppAssembly()
        ], container: container)
        return assembler
    }()
}
