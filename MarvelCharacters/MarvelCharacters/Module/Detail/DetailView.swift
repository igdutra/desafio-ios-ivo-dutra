//
//  DetailView.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class DetailView: UIView {

    // MARK: - Properties

    var cellId: String

    var viewModel: DetailViewModelProtocol?

    // MARK: - Init

    override init(frame: CGRect) {
        cellId = "cell"

        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

    // MARK: - Delegate

extension DetailView: DetailViewModelDelegate {
     
    func reload() {

    }

}

    // MARK: - ViewCodable

extension DetailView: ViewCodable {
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
