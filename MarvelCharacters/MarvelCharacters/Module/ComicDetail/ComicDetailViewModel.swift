//
//  ComicDetailViewModel.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

/// ViewModel's Delegate is the View
protocol ComicDetailViewModelDelegate: class {
    func reload()
}

protocol ComicDetailViewModelProtocol {
    var delegate: ComicDetailViewModelDelegate? { get set }
    var navigationDelegate: CharacterDetailNavigationDelegate? { get set }
}

class ComicDetailViewModel: ComicDetailViewModelProtocol {

    // MARK: - Properties

    weak var delegate: ComicDetailViewModelDelegate?
    weak var navigationDelegate: CharacterDetailNavigationDelegate?

    // MARK: - Init

    init(delegate: ComicDetailViewModelDelegate, navigation: CharacterDetailNavigationDelegate) {
        self.delegate = delegate
        self.navigationDelegate = navigation
    }

}
