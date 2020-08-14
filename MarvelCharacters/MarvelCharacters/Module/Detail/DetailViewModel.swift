//
//  DetailViewModel.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

// APAGAR
class Services: ServicesProtocol {}
protocol ServicesProtocol {}

/// ViewModel's Delegate is the View
protocol DetailViewModelDelegate: class {
    func reload()
}

protocol DetailViewModelProtocol {
    var services: ServicesProtocol { get set }
    var delegate: DetailViewModelDelegate? { get set }
    var navigationDelegate: NavigationDelegate? { get set }
}

class DetailViewModel: DetailViewModelProtocol {

    // MARK: - Properties

    var services: ServicesProtocol
    weak var delegate: DetailViewModelDelegate?
    weak var navigationDelegate: NavigationDelegate?

    // MARK: - Init

    init(services: ServicesProtocol, delegate: DetailViewModelDelegate, navigation: NavigationDelegate) {
        self.services = services
        self.delegate = delegate
        self.navigationDelegate = navigation
    }

}
