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

    var descriptionLabel: UILabel
    var characterImageView: UIImageView

    var viewModel: DetailViewModelProtocol? {
        // Guarantees that label is configured when viewModel is set
        didSet {
            configure()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        descriptionLabel = UILabel()
        characterImageView = UIImageView()

        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - Delegate

extension DetailView: DetailViewModelDelegate {

    func reloadLabel() {
        configure()
    }

    func reloadIcon(withImage image: UIImage) {
        configureIcon(withImage: image)
    }
}

    // MARK: - View Codable

extension DetailView: ViewCodable {

    func configure() {
        guard let viewModel = viewModel else { return }

        let description = (viewModel.character.characterDescription.isEmpty) ?
                            "No Description :'(" : viewModel.character.characterDescription

        // UI Code should run on main Thread
        DispatchQueue.main.async {
            self.descriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.descriptionLabel.textAlignment = .center
            self.descriptionLabel.numberOfLines = 0
            self.descriptionLabel.text = description
            // After the view is configured
            self.setDescriptionLabelConstraints()
        }
    }

    func setupHierarchy() {
        self.addSubviews(descriptionLabel, characterImageView)
    }

    func setupConstraints() {
        setCharacterImageViewConstraints()
        // Label constraints are set later
    }

    func render() {
        self.backgroundColor = .white
    }

      // MARK: - ViewCodable Helpers

    func configureIcon(withImage image: UIImage) {
        DispatchQueue.main.async {
            self.characterImageView.image = image
        }
    }

    func setCharacterImageViewConstraints() {
           characterImageView.setConstraints { (view) in
               view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
               view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
           }
       }

    func setDescriptionLabelConstraints() {
        descriptionLabel.setConstraints { (view) in
            // At least keep distance greater then 16 points
            view.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 16).isActive = true
            // Give a label a width (leading and trailing) that for a given font Size it will calculate its own height
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
    }

}
