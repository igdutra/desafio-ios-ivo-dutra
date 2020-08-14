//
//  CharactersViewMock.swift
//  MarvelCharactersTests
//
//  Created by Ivo Dutra on 11/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

@testable import MarvelCharacters

class CharactersViewMock: CharactersViewModelDelegate {

    // MARK: - Properties

    var called: Bool

    // MARK: - Init

    init() {
        called = false
    }

    // MARK: - Delegate

    func reloadTableView() {
        called = true
    }

}
