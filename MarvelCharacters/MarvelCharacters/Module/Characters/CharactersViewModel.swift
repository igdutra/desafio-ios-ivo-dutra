//
//  CharactersViewModel.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

/// ViewModel's Delegate is the View
protocol CharactersViewModelDelegate: class {
    func reload()
}

protocol CharactersViewModelProtocol {
    var characters: [Character] { get set }
    var services: MarvelCharactersServiceProtocol { get set }
    var delegate: CharactersViewModelDelegate? { get set }
    var navigationDelegate: NavigationDelegate? { get set }
}

class CharactersViewModel: CharactersViewModelProtocol {

    // MARK: - Properties

    var characters: [Character]

    var services: MarvelCharactersServiceProtocol
    weak var delegate: CharactersViewModelDelegate?
    weak var navigationDelegate: NavigationDelegate?

    // MARK: - Init

    init(services: MarvelCharactersServiceProtocol, delegate: CharactersViewModelDelegate, navigation: NavigationDelegate) {
        self.services = services
        self.delegate = delegate
        self.navigationDelegate = navigation

        characters = []

        // Each request will add 20 characters to the array
        get20Characters {
            // Only after all characters where loaded, perfom the request for the images using infite scroll.

        }


    }

    // MARK: - Get Characters

    func get20Characters(completion: @escaping () -> Void) {

        services.requestCharacters { [weak self] characters in
            if let characters = characters {
                self?.characters.append(contentsOf: characters)
                // Once the array is incremeted, increment offset count
                self?.services.offset += 20
                completion()
            } else {
                print("\ncharactersArray = nil\n")
            }
        }

    }
}
