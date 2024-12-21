//
//  GoViewController.swift
//  CoordinatorProMax
//
//  Created by Amirov Foma on 21.12.2024.
//

import UIKit

final class GoViewController: UIViewController {
    var didSentEventClosure: ((GoViewController.Event) -> Void)?

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    deinit {
        print("LoginViewController deinit")
    }
    
    @objc private func didTapLoginButton() {
        didSentEventClosure?(.go)
    }
}

extension GoViewController {
    enum Event {
        case go
    }
}
