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

    var titleLabel: UILabel
    var comicImageView: UIImageView

    var viewModel: ComicDetailViewModelProtocol? {

        didSet {
            configure()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        titleLabel = UILabel()
        comicImageView = UIImageView()

        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - Delegate

extension ComicDetailView: ComicDetailViewModelDelegate {

     // Guarantees that label is configured when the expensive comic is found
    func reload() {
        configure()
    }

}

    // MARK: - View Codable

extension ComicDetailView: ViewCodable {

    func configure() {
        guard let viewModel = viewModel else { return }

        let description = viewModel.expensiveComic?.title ?? "Title"

        configureLabel(withDescription: description)
    }

    func setupHierarchy() {
        self.addSubviews(titleLabel, comicImageView)
    }

    func setupConstraints() {
        setCharacterImageViewConstraints()
        settitleLabelConstraints()
    }

    func render() {
        self.backgroundColor = .white
    }

      // MARK: - ViewCodable Helpers

    func configureIcon(withImage image: UIImage) {
        DispatchQueue.main.async {
            self.comicImageView.image = image
        }
    }

    func configureLabel(withDescription description: String) {
        // UI Code should run on main Thread
        DispatchQueue.main.async {
            self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.titleLabel.textAlignment = .center
            // OBS: As requested, "Os campos de texto devem ter no máximo 3 linhas"
            self.titleLabel.numberOfLines = 3
            self.titleLabel.text = description
        }
    }

    func setCharacterImageViewConstraints() {
           comicImageView.setConstraints { (view) in
               view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
               view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
           }
       }

    func settitleLabelConstraints() {
        titleLabel.setConstraints { (view) in
            // At least keep distance greater then 16 points
            view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
            // Give a label a width (leading and trailing) that for a given font Size it will calculate its own height
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
    }

}
