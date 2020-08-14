//
//  CharacterDetailViewModel.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

/// ViewModel's Delegate is the View
protocol CharacterDetailViewModelDelegate: class {
    func reloadLabel()
    func reloadIcon(withImage: UIImage)
}

protocol CharacterDetailViewModelProtocol {
    var character: Character { get set }
    var image: UIImage { get set }
    var delegate: CharacterDetailViewModelDelegate? { get set }
    var navigationDelegate: NavigationDelegate? { get set }
}

class CharacterDetailViewModel: CharacterDetailViewModelProtocol {

    // MARK: - Properties

    var character: Character
    var image: UIImage
    weak var delegate: CharacterDetailViewModelDelegate?
    weak var navigationDelegate: NavigationDelegate?

    // MARK: - Init

    init(delegate: CharacterDetailViewModelDelegate, navigation: NavigationDelegate, character: Character, image: UIImage) {
        self.character = character
        self.image = image
        self.delegate = delegate
        self.navigationDelegate = navigation

        configureDetailView()
    }

    // MARK: - Configure

    func configureDetailView() {
        delegate?.reloadIcon(withImage: image)
        delegate?.reloadLabel()
    }

}
