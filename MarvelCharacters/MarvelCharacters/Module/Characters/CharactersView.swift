//
//  CharactersView.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class CharactersView: UIView {

    // MARK: - Properties

    var tableView: UITableView
    var cellId: String

    var viewModel: CharactersViewModelProtocol?

    // MARK: - Init

    override init(frame: CGRect) {
        tableView = UITableView()
        cellId = "cell"

        super.init(frame: frame)
        self.backgroundColor = .purple

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

    // MARK: - Table View

extension CharactersView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }

        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? CharachtersTableViewCell {
            // Update CentralImageView or use the placeholder before request is finished
//            cell.centralImageView.image = viewModel.images[indexPath.row] ?? UIImage.Default.photoPlaceholder!
            cell.centralImageView.image = UIImage.Default.photoPlaceholder!

            // Add title according to the day
            cell.titleLabel.text = viewModel.characters[indexPath.row].name

            return cell
        }

        return UITableViewCell()
    }
}

    // MARK: - Delegate

extension CharactersView: CharactersViewModelDelegate {

    /// Reload Table View on the main Thread
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

    // MARK: - ViewCodable

extension CharactersView: ViewCodable {
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharachtersTableViewCell.self, forCellReuseIdentifier: cellId)
    }

    func setupHierarchy() {
        self.addSubviews(tableView)
    }

    func setupConstraints() {
        tableView.setConstraints { (view) in
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
    }
}
