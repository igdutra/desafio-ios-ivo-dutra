//
//  CharactersView.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//
// TODO: renomear cabeçalho

import UIKit

class CharactersView: UIView {

    // MARK: - Properties

    var cellId: String

    var viewModel: ViewModelProtocol?

    // MARK: - Init

    override init(frame: CGRect) {
        cellId = "cell"

        super.init(frame: frame)
        self.backgroundColor = .purple

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

    // MARK: - Delegate

extension CharactersView: CharactersViewModelDelegate {
     
    func reload() {

    }

}

    // MARK: - ViewCodable

extension CharactersView: ViewCodable {
    func configure() {

    }

    func setupHierarchy() {

    }

    func setupConstraints() {

    }

    func render() {

    }

     // MARK: - ViewCodable Helpers

}
