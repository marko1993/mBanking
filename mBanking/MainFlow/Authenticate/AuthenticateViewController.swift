//
//  AuthenticateViewController.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import UIKit

class AuthenticateViewController: BaseViewController {
    
    let viewModel: AuthenticateViewModel
    private let authenticateView = AuthenticateView()
    
    init(viewModel: AuthenticateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(authenticateView)
        checkIfPINCodeIsSaved()
        setupBinding()
    }
    
    private func setupBinding() {
        bind(errorMessage: self.viewModel.errorMessage.asObservable())
        authenticateView.continueButton.onTap(disposeBag: disposeBag) {
            self.viewModel.authenticate(PINCode: self.authenticateView.getPINCode())
        }
    }
    
    private func checkIfPINCodeIsSaved() {
        authenticateView.setUpForNewPINCode(!viewModel.isPINCodeSaved())
    }
    
}
