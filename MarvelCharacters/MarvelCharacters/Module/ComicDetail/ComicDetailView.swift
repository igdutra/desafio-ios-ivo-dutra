//
//  ComicDetailView.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class ComicDetailView: UIView {

    // MARK: - Properties

    var cellId: String

    var viewModel: ComicDetailViewModelProtocol?

    // MARK: - Init

    override init(frame: CGRect) {
        cellId = "cell"

        super.init(frame: frame)
        self.backgroundColor = .orange

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

    // MARK: - Delegate

extension ComicDetailView: ComicDetailViewModelDelegate {
     
    func reload() {

    }

}

    // MARK: - ViewCodable

extension ComicDetailView: ViewCodable {
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
