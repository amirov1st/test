//
//  TabBarPage.swift
//  CoordinatorProMax
//
//  Created by Amirov Foma on 21.12.2024.
//

import Foundation

enum TabBarPage {
    case ready, steady, go
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .ready
        case 1:
            self = .steady
        case 2:
            self = .go
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .ready:
            "Ready"
        case .steady:
            "Steady"
        case .go:
            "Go"
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .ready:
            0
        case .steady:
            1
        case .go:
            2
        }
    }
}
