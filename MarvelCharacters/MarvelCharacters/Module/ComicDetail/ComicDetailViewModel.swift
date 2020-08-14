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
    var character: Character { get set }
    var delegate: ComicDetailViewModelDelegate? { get set }
}

class ComicDetailViewModel: ComicDetailViewModelProtocol {

    // MARK: - Properties
    var character: Character
    weak var delegate: ComicDetailViewModelDelegate?

    // MARK: - Init

    init(delegate: ComicDetailViewModelDelegate, character: Character) {
        self.delegate = delegate
        self.character = character
    }

}
