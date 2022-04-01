//
//  BaseView.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import UIKit

protocol BaseView where Self: UIView {
    func addSubviews()
    func styleSubviews()
    func positionSubviews()
}

extension BaseView {
    func setupView() {
        addSubviews()
        styleSubviews()
        positionSubviews()
    }
}
