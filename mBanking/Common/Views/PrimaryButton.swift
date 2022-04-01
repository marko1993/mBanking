//
//  PrimaryButton.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import UIKit

class PrimaryButton: UIButton {
    
    private let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        setTitleColor(UIColor.black.withAlphaComponent(0.3), for: .disabled)
        titleLabel?.font = .systemFont(ofSize: 25)
        layer.borderColor = isEnabled ? UIColor.systemTeal.cgColor : UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    
    func setDisabled(_ disabled: Bool)  {
        isEnabled = !disabled
        layer.borderColor = isEnabled ? UIColor.systemTeal.cgColor : UIColor.lightGray.cgColor
    }
    
}
