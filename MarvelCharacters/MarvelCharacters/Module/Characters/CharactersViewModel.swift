//
//  CharactersViewModel.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

/// ViewModel's Delegate is the View
protocol CharactersViewModelDelegate: class {
    func reloadTableView()
}

protocol CharactersViewModelProtocol {
    var characters: [Character] { get set }
    var images: [Int: UIImage] { get set }
    var services: MarvelCharactersServiceProtocol { get set }
    var delegate: CharactersViewModelDelegate? { get set }
    var navigationDelegate: NavigationDelegate? { get set }

    func get20Characters(_ completion: @escaping () -> Void)
}

class CharactersViewModel: CharactersViewModelProtocol {

    // MARK: - Properties

    var characters: [Character]
    var images: [Int: UIImage]

    var services: MarvelCharactersServiceProtocol
    weak var delegate: CharactersViewModelDelegate?
    weak var navigationDelegate: NavigationDelegate?

    // MARK: - Init

    init(services: MarvelCharactersServiceProtocol, delegate: CharactersViewModelDelegate, navigation: NavigationDelegate) {
        self.services = services
        self.delegate = delegate
        self.navigationDelegate = navigation

        characters = []
        images = [:]

        // Each request will add 20 characters to the array
        get20Characters()
    }

    // MARK: - Get Characters

    func get20Characters(_ completion: @escaping () -> Void = { }) {

        services.requestCharacters { [weak self] characters in
            if let characters = characters {

                self?.characters.append(contentsOf: characters)
                // Make sure that table view displays the results
                self?.delegate?.reloadTableView()
                // Only after all characters where loaded, perfom the request for the images using infite scroll.
                self?.fetch20Images {
                    // Make sure that table view displays the results
                    self?.delegate?.reloadTableView()
                    // Set View's fetchingMore back to false
                    completion()
                }

            } else {
                print("\ncharactersArray = nil\n")
            }
        }

    }

    // MARK: - Fetch images

    /// If no image was requested, range is 0...20
    /// If some images where alread loaded, then grab the images always inside a +20 interval
    /// Completion: set scroll flag back to false
    func fetch20Images(_ completion: @escaping () -> Void) {

        let range = (images.count)...(images.count + 19) // 20 total

        // Fetch images containing in range
        for id in range {
            // Get the correct image URL, from the correct position in the array.
            // If no URL was created, just leave the position in the array empty.
            // No problem because it is a dictionary
            guard let url = characters[id].getImageURL() else { continue }

            services.fetchSingleImage(at: url) { [weak self] (image) in

                // Save image in the array. Images are all portrait_medium, therefore no resize is needed 
                self?.images[id] = image.withRoundedCorners(radius: 12)

                // If last photo was requested, set scroll flag back to false
                if id == range.max() {
                    // Increment services offset when operation was finished
                    self?.services.offset += 20
                    // Reload Data
                    completion()
                }
            }
        }
    }

}
