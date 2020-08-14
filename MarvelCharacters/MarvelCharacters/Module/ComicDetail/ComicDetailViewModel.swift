//
//  ComicDetailViewModel.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

/// ViewModel's Delegate is the View
protocol ComicDetailViewModelDelegate: class {
    func reload()
    func configureIcon(withImage image: UIImage?)
}

protocol ComicDetailViewModelProtocol {
    var expensiveComic: Comic? { get set }
    var comicImage: UIImage? { get set }
    var delegate: ComicDetailViewModelDelegate? { get set }
}

class ComicDetailViewModel: ComicDetailViewModelProtocol {

    // MARK: - Properties
    var character: Character
    var comics: [Comic]
    var expensiveComic: Comic?
    var comicImage: UIImage? {
        didSet {
            delegate?.reload()
            delegate?.configureIcon(withImage: comicImage?.withRoundedCorners(radius: 12))
        }
    }

    var services: MarvelComicsServiceProtocol
    weak var delegate: ComicDetailViewModelDelegate?

    // MARK: - Init

    init(services: MarvelComicsServiceProtocol, delegate: ComicDetailViewModelDelegate, character: Character) {
        self.services = services
        self.delegate = delegate
        self.character = character
        self.comics = []

        // Request all comics
        getAllComics()
    }

    // MARK: - Get comics

    func getAllComics() {
        services.requestComics(forCharacter: character.id) {  [weak self] (comicsArray) in
            if let comics = comicsArray {
                // Array will not be incremeted over time
                self?.comics = comics

                self?.filterMostExpensiveComic()
            }
        }
    }

    // MARK: - Filter

    func filterMostExpensiveComic() {

        let prices = comics.map { (comic) -> (Int, Double) in
            return (comic.id, comic.prices[0].price)
        }

        if let maxItem = prices.max(by: {$0.1 < $1.1 }) {
            let comic = comics.filter { (comic) -> Bool in
                return comic.id == maxItem.0
            }

            // Save the expensive comic
            self.expensiveComic = comic[0]
            // Retrieve Foto
            getComicImage()
        }
    }

    // MARK: - Image

    func getComicImage() {
        guard let comic = self.expensiveComic,
              let url = self.expensiveComic?.getImageURL()
        else { return }

        services.fetchSingleImage(at: url) { (image) in
            self.comicImage = image
        }

    }
}
