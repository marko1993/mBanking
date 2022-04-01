//
//  CodeViewItem.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import UIKit

class CodeViewItem: UIView, BaseView {
    
    private let label = UILabel()
    private let bottomLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(label)
        addSubview(bottomLine)
    }
    
    func styleSubviews() {
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 22)
        
        bottomLine.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.3)
    }
    
    func positionSubviews() {
        label.fillSuperview()
        
        bottomLine.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        bottomLine.constrainHeight(1)
    }

    func setCharacter(character: String) {
        label.text = character
    }
    
    func shouldShowBottomLine(_ shouldShow: Bool) {
        bottomLine.backgroundColor = shouldShow ? UIColor.systemTeal : UIColor.systemTeal.withAlphaComponent(0.3)
    }
    
}
