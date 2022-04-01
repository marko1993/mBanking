//
//  NumberPadItem.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import UIKit

class NumberPadItem: UIView, BaseView {
    
    let button = UIButton()
    private let number: Int
    
    init(number: Int) {
        self.number = number
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(button)
    }
    
    func styleSubviews() {
        button.setTitle("\(number)", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 32)
        button.setTitleColor(UIColor.systemTeal, for: .normal)
        button.tag = number
    }
    
    func positionSubviews() {
        button.fillSuperview()
    }
    
}
