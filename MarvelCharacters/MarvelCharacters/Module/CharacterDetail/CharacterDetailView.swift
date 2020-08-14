//
//  DetailView.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class CharacterDetailView: UIView {

    // MARK: - Properties

    var descriptionLabel: UILabel
    var characterImageView: UIImageView
    var comicsButton: UIButton

    var viewModel: CharacterDetailViewModelProtocol? {
        // Guarantees that label is configured when viewModel is set
        didSet {
            configure()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        descriptionLabel = UILabel()
        characterImageView = UIImageView()
        comicsButton = UIButton()

        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - Delegate

extension CharacterDetailView: CharacterDetailViewModelDelegate {

    func reloadLabel() {
        configure()
    }

    func reloadIcon(withImage image: UIImage) {
        configureIcon(withImage: image)
    }
}

    // MARK: - Button

extension CharacterDetailView {

    @objc func buttonPressed(sender: UIButton!) {
        viewModel?.navigationDelegate?.goToComicDetail()
    }
}

    // MARK: - View Codable

extension CharacterDetailView: ViewCodable {

    func configure() {
        guard let viewModel = viewModel else { return }

        let description = (viewModel.character.characterDescription.isEmpty) ?
                            "No Description :'(" : viewModel.character.characterDescription

        configureLabel(withDescription: description)

        configureButton()
    }

    func setupHierarchy() {
        self.addSubviews(descriptionLabel, characterImageView, comicsButton)
    }

    func setupConstraints() {
        setCharacterImageViewConstraints()
        setDescriptionLabelConstraints()
        setComicsButtonConstraints()
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

    func configureLabel(withDescription description: String) {
        // UI Code should run on main Thread
        DispatchQueue.main.async {
            self.descriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.descriptionLabel.textAlignment = .center
            // OBS: As requested, "Os campos de texto devem ter no máximo 3 linhas"
            self.descriptionLabel.numberOfLines = 3
            self.descriptionLabel.text = description
        }
    }

    func configureButton() {
        comicsButton.addTarget(self, action: #selector(CharacterDetailView.buttonPressed(sender:)), for: .touchUpInside)

        DispatchQueue.main.async {
            self.comicsButton.setTitle(" Check its most expensive Comic!  ", for: .normal)
            self.comicsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            self.comicsButton.setTitleColor(.white, for: .disabled)
            self.comicsButton.titleLabel?.textAlignment = .center
            self.comicsButton.layer.cornerRadius = 12
            self.comicsButton.backgroundColor = .red
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

    func setComicsButtonConstraints() {
        comicsButton.setConstraints { (view) in
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -84).isActive = true
        }
    }

}
