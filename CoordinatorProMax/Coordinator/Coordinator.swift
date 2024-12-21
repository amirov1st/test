//
//  Coordinator.swift
//  CoordinatorProMax
//
//  Created by Amirov Foma on 15.12.2024.
//

import UIKit

enum CoordinatorType {
    case app, login, tab
}

protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorDidFinishDelagate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }
    
    init(_ navigationController: UINavigationController)
    
    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

protocol CoordinatorDidFinishDelagate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
