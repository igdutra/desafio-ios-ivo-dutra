//
//  CharactersViewModel.swift
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
protocol CharactersViewModelDelegate: class {
    func reload()
}

protocol ViewModelProtocol {
    var services: ServicesProtocol { get set }
    var delegate: CharactersViewModelDelegate? { get set }
    var navigationDelegate: NavigationDelegate? { get set }
}

class ViewModel: ViewModelProtocol {

    // MARK: - Properties

    var services: ServicesProtocol
    weak var delegate: CharactersViewModelDelegate?
    weak var navigationDelegate: NavigationDelegate?

    // MARK: - Init

    init(services: ServicesProtocol, delegate: CharactersViewModelDelegate, navigation: NavigationDelegate) {
        self.services = services
        self.delegate = delegate
        self.navigationDelegate = navigation
    }

}
