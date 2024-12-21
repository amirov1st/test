//
//  LoginCoordinator.swift
//  CoordinatorProMax
//
//  Created by Amirov Foma on 15.12.2024.
//

import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func showLoginViewController()
}

final class LoginCoordinator: LoginCoordinatorProtocol {
    
    weak var finishDelegate: CoordinatorDidFinishDelagate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func start() {
        showLoginViewController()
    }
    
    func showLoginViewController() {
        let loginViewController: LoginViewController = .init()
        loginViewController.didSentEventClosure = { [weak self] event in
            self?.finish()
        }
        
        navigationController.pushViewController(loginViewController, animated: true)
    }
}
