//
//  TabCoordinator.swift
//  CoordinatorProMax
//
//  Created by Amirov Foma on 21.12.2024.
//

import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

final class TabCoordinator: NSObject, TabCoordinatorProtocol {
    
    weak var finishDelegate: CoordinatorDidFinishDelagate?
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .tab }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        let pages: [TabBarPage] = [.ready, .steady, .go]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        preparetabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page  = TabBarPage.init(index: index) else { return }
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func currentPage() -> TabBarPage? {
        TabBarPage.init(index: tabBarController.selectedIndex)
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // some implementation
    }
}

private extension TabCoordinator {
    func preparetabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.ready.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        
        navigationController.viewControllers = [tabBarController]
    }
    
    func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.tabBarItem = UITabBarItem(
            title: page.pageTitleValue(),
            image: nil,
            tag: page.pageOrderNumber()
        )
        
        switch page {
        case .ready:
            let readyVC = ReadyViewController()
            readyVC.didSentEventClosure = { [weak self] event in
                switch event {
                case .ready:
                    self?.selectPage(.ready)
                }
            }
            
            navigationController.pushViewController(readyVC, animated: true)
        case .steady:
            let steadyVC = SteadyViewController()
            steadyVC.didSentEventClosure = { [weak self] event in
                switch event {
                case .steady:
                    self?.selectPage(.steady)
                }
            }
            
            navigationController.pushViewController(steadyVC, animated: true)
        case .go:
            let goVC = GoViewController()
            goVC.didSentEventClosure = { [weak self] event in
                switch event {
                case .go:
                    self?.selectPage(.go)
                }
            }
            
            navigationController.pushViewController(goVC, animated: true)
        }
        
        return navigationController
    }
}

