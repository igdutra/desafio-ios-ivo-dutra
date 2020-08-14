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
    var fetchingMore: Bool

    var viewModel: CharactersViewModelProtocol?

    // MARK: - Init

    override init(frame: CGRect) {
        tableView = UITableView()
        cellId = "cell"
        fetchingMore = false

        super.init(frame: frame)

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

        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? CharactersTableViewCell {
            // Update CentralImageView or use the placeholder before request is finished
            cell.centralImageView.image = viewModel.images[indexPath.row] ?? UIImage.Default.photoPlaceholder!

            // Add title according to the day
            cell.titleLabel.text = viewModel.characters[indexPath.row].name

            return cell
        }

        return UITableViewCell()
    }

    // MARK: - Navigation

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel,
              let image = viewModel.images[indexPath.row]
        else { return }

        let character = viewModel.characters[indexPath.row]

        viewModel.navigationDelegate?.goToDetail(forCharacter: character, withImage: image)
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
        tableView.register(CharactersTableViewCell.self, forCellReuseIdentifier: cellId)
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

    // MARK: - Infinite scroll

extension CharactersView {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        // Calculated automatically, considered all images
        let contentHeight = scrollView.contentSize.height

        // If the scroll action was greater than the content - device size
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                fetchMoreImages()
            }
        }
    }

    func fetchMoreImages() {
        // Prevent calling several times
        fetchingMore = true
        viewModel?.get20Characters { [weak self] in
            self?.fetchingMore = false
        }
    }
}
