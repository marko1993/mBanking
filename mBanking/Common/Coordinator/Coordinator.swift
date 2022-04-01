//
//  Coordinator.swift
//  mBanking
//
//  Created by Marko Matijević on 25.03.2022..
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    
}
