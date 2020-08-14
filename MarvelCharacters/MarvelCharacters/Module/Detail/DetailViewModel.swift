//
//  DetailViewModel.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

/// ViewModel's Delegate is the View
protocol DetailViewModelDelegate: class {
    func reloadLabel()
    func reloadIcon(withImage: UIImage)
}

protocol DetailViewModelProtocol {
    var character: Character { get set }
    var image: UIImage { get set }
    var delegate: DetailViewModelDelegate? { get set }
    var navigationDelegate: NavigationDelegate? { get set }
}

class DetailViewModel: DetailViewModelProtocol {

    // MARK: - Properties

    var character: Character
    var image: UIImage
    weak var delegate: DetailViewModelDelegate?
    weak var navigationDelegate: NavigationDelegate?

    // MARK: - Init

    init(delegate: DetailViewModelDelegate, navigation: NavigationDelegate, character: Character, image: UIImage) {
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
