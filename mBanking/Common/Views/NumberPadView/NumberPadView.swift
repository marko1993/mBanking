//
//  NumberPadView.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import UIKit
import RxSwift

protocol NumberPadViewDelegate: AnyObject {
    func numberPadViewDelegate(_ numberPad: NumberPadView, didPress number: Int)
    func numberPadViewDelegate(_ numberPad: NumberPadView, didPressDelete: Bool)
}

class NumberPadView: UIView, BaseView {
    
    private let disposeBag = DisposeBag()
    weak var delegate: NumberPadViewDelegate?
    
    private let containerStackView = UIStackView()
    private let firstLineStackView = UIStackView()
    private let secondLineStackView = UIStackView()
    private let thirdLineStackView = UIStackView()
    private let fourthLineStackView = UIStackView()
    private let deleteView = UIView()
    let deleteButton = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupNumberPadItems()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNumberPadItems() {
        setNumbersInRange(start: 1, end: 3, stack: firstLineStackView)
        setNumbersInRange(start: 4, end: 6, stack: secondLineStackView)
        setNumbersInRange(start: 7, end: 9, stack: thirdLineStackView)
        setupBottomRow()
    }
    
    private func setNumbersInRange(start: Int, end: Int, stack: UIStackView) {
        for i in start...end {
            let itemView = NumberPadItem(number: i)
            itemView.button.onTap(disposeBag: disposeBag) {
                self.delegate?.numberPadViewDelegate(self, didPress: i)
            }
            stack.addArrangedSubview(itemView)
        }
    }
    
    private func setupBottomRow() {
        fourthLineStackView.addArrangedSubview(UIButton())
        
        let zeroButton = NumberPadItem(number: 0)
        zeroButton.button.onTap(disposeBag: disposeBag) {
            self.delegate?.numberPadViewDelegate(self, didPress: 0)
        }
        fourthLineStackView.addArrangedSubview(zeroButton)
        
        fourthLineStackView.addArrangedSubview(deleteView)
    }
    
    func addSubviews() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(firstLineStackView)
        containerStackView.addArrangedSubview(secondLineStackView)
        containerStackView.addArrangedSubview(thirdLineStackView)
        containerStackView.addArrangedSubview(fourthLineStackView)
        deleteView.addSubview(deleteButton)
    }
    
    func styleSubviews() {
        containerStackView.axis = .vertical
        containerStackView.distribution = .fillEqually
        containerStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerStackView.spacing = 5
        
        containerStackView.arrangedSubviews.forEach { item in
            (item as! UIStackView).axis = .horizontal
            (item as! UIStackView).distribution = .fillEqually
            (item as! UIStackView).autoresizingMask = [.flexibleWidth, .flexibleHeight]
            (item as! UIStackView).spacing = 5
        }
        
        deleteButton.image = UIImage(systemName: "delete.left")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemTeal)
    }
    
    func positionSubviews() {
        containerStackView.fillSuperview()
        
        deleteButton.anchor(size: CGSize(width: 40, height: 40))
        deleteButton.centerInSuperview()
    }
    
    func setupBinding() {
        deleteButton.onTap(disposeBag: disposeBag) {
            self.delegate?.numberPadViewDelegate(self, didPressDelete: true)
        }
    }

}
