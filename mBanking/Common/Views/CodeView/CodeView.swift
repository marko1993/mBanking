//
//  CodeView.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import UIKit

protocol CodeViewDelegate: AnyObject {
    func codeViewDelegate(_ codeView: CodeView, valueDidChange value: String)
}

class CodeView: UIView, BaseView {
    
    private var currentPosition: Int = 0
    private var characters: String = ""
    weak var delegate: CodeViewDelegate?
    var shouldHideCode: Bool = false
    
    private var containerStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupCodeViewItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getPINCode() -> String {
        return characters
    }
    
    func addCharacter(character: String) {
        if currentPosition <= 5 {
            (containerStackView.arrangedSubviews[currentPosition] as! CodeViewItem).setCharacter(character: shouldHideCode ? "*" : character)
            characters.append(character)
            currentPosition += 1
            delegate?.codeViewDelegate(self, valueDidChange: characters)
            updateBottomLinePosition()
        }
    }
    
    func removeCharacter() {
        if currentPosition > 0 {
            (containerStackView.arrangedSubviews[currentPosition - 1] as! CodeViewItem).setCharacter(character: "")
            characters.removeLast()
            currentPosition -= 1
            delegate?.codeViewDelegate(self, valueDidChange: characters)
            updateBottomLinePosition()
        }
    }
    
    private func setupCodeViewItems() {
        for _ in 0..<6 {
            let itemView = CodeViewItem()
            containerStackView.addArrangedSubview(itemView)
        }
        (containerStackView.arrangedSubviews[0] as! CodeViewItem).shouldShowBottomLine(true)
    }
    
    private func updateBottomLinePosition() {
        containerStackView.arrangedSubviews.forEach { item in
            (item as! CodeViewItem).shouldShowBottomLine(false)
        }
        if currentPosition < 6 && currentPosition >= 0 {
            (containerStackView.arrangedSubviews[currentPosition] as! CodeViewItem).shouldShowBottomLine(true)
        }
    }
    
    func addSubviews() {
        addSubview(containerStackView)
    }
    
    func styleSubviews() {
        containerStackView.axis = .horizontal
        containerStackView.distribution = .fillEqually
        containerStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerStackView.spacing = 10
    }
    
    func positionSubviews() {
        containerStackView.fillSuperview()
    }
}
