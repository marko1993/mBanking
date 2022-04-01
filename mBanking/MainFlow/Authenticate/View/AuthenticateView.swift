//
//  AuthenticateView.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import UIKit
import RxSwift
import RxCocoa

class AuthenticateView: UIView, BaseView {
    
    private let titleLabel = UILabel()
    private let codeView = CodeView()
    private let numberPadView = NumberPadView()
    let continueButton = PrimaryButton(title: "Continue")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func setUpForNewPINCode(_ setupForNewPIN: Bool) {
        titleLabel.text = setupForNewPIN ? "Please set new PIN code" : "Please enter your PIN code"
        codeView.shouldHideCode = setupForNewPIN
    }
    
    func getPINCode() -> String {
        return codeView.getPINCode()
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(codeView)
        addSubview(numberPadView)
        addSubview(continueButton)
    }
    
    func styleSubviews() {
        titleLabel.font = .systemFont(ofSize: 25)
        titleLabel.textAlignment = .center
        
        codeView.delegate = self

        numberPadView.delegate = self
        
        continueButton.setDisabled(true)
    }
    
    func positionSubviews() {
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        titleLabel.constrainHeight(80)
        
        codeView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 40, right: 20))
        codeView.constrainHeight(60)
        
        numberPadView.anchor(top: codeView.bottomAnchor, leading: leadingAnchor, bottom: continueButton.topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 40, left: 20, bottom: 40, right: 20))
        
        continueButton.anchor(bottom: bottomAnchor, size: CGSize(width: 180, height: 60))
        continueButton.centerX(inView: self)
    }

}

extension AuthenticateView: CodeViewDelegate {
    func codeViewDelegate(_ codeView: CodeView, valueDidChange value: String) {
        continueButton.setDisabled(value.count < 4)
    }
}

extension AuthenticateView: NumberPadViewDelegate {
    func numberPadViewDelegate(_ numberPad: NumberPadView, didPress number: Int) {
        codeView.addCharacter(character: String(number))
    }
    
    func numberPadViewDelegate(_ numberPad: NumberPadView, didPressDelete: Bool) {
        codeView.removeCharacter()
    }
    
}
