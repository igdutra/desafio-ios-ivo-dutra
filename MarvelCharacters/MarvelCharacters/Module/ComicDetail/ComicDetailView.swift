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
    var descriptionLabel: UILabel
    var priceLabel: UILabel

    var viewModel: ComicDetailViewModelProtocol? {
        didSet {
            configure()
            // Set placeholder before image is loaded
            configureIcon(withImage: nil)
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        titleLabel = UILabel()
        comicImageView = UIImageView()
        descriptionLabel = UILabel()
        priceLabel = UILabel()

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

        let title = viewModel.expensiveComic?.title ?? ""
        let description = viewModel.expensiveComic?.resultDescription ??  "No Description :'("
        let price: String = "$ " + (viewModel.expensiveComic?.prices[0].price.description ?? "?")

        configureLabel(title: title, description: description, price: price)
    }

    func setupHierarchy() {
        self.addSubviews(titleLabel, comicImageView, descriptionLabel, priceLabel)
    }

    func setupConstraints() {
        setCharacterImageViewConstraints()
        setTitleLabelConstraints()
        setDescriptionLabelConstraints()
        setPriceLabelConstraints()
    }

    func render() {
        self.priceLabel.textColor = .red
        self.backgroundColor = .white
    }

      // MARK: - ViewCodable Helpers

    func configureIcon(withImage image: UIImage?) {
        DispatchQueue.main.async {
            self.comicImageView.image = image ?? UIImage.Default.imagePlaceholder
        }
    }

    func configureLabel(title: String, description: String, price: String) {
        // UI Code should run on main Thread
        DispatchQueue.main.async {
            self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.priceLabel.font = UIFont.boldSystemFont(ofSize: 18)

            self.titleLabel.textAlignment = .center
            self.descriptionLabel.textAlignment = .center

            // OBS: As requested, "Os campos de texto devem ter no máximo 3 linhas"
            self.titleLabel.numberOfLines = 3
            self.descriptionLabel.numberOfLines = 3

            self.titleLabel.text = title
            self.descriptionLabel.text = description
            self.priceLabel.text = price
        }
    }

    func setCharacterImageViewConstraints() {
           comicImageView.setConstraints { (view) in
               view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
               view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
           }
       }

    func setTitleLabelConstraints() {
        titleLabel.setConstraints { (view) in
            // At least keep distance greater then 16 points
            view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
            // Give a label a width (leading and trailing) that for a given font Size it will calculate its own height
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
    }

    func setDescriptionLabelConstraints() {
        descriptionLabel.setConstraints { (view) in
            // At least keep distance greater then 32 points
            view.topAnchor.constraint(equalTo: comicImageView.bottomAnchor, constant: 52).isActive = true
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
    }

    func setPriceLabelConstraints() {
        priceLabel.setConstraints { (view) in
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -102).isActive = true
        }
    }

}
