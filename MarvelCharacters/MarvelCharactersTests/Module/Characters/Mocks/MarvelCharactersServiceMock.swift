//
//  MarvelCharactersServiceMock.swift
//  MarvelCharactersTests
//
//  Created by Ivo Dutra on 11/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit
@testable import MarvelCharacters

class MarvelCharactersServiceMock: MarvelCharactersServiceProtocol {

    // MARK: - Properties

    var offset: Int
    var called: Bool

    // MARK: - Init

    init() {
        offset = 0
        called = false
    }

    // MARK: - Delegate

    func requestCharacters(completion: @escaping ([Character]?) -> Void) {
        let character = mockCharacter()
        var array: [Character] = []

        // Assert that index won't be out of range
        for _ in 1...20 {
            array.append(character)
        }

        // So that if let characters from services.requestCharacters gets executed
        completion(array)
    }

    func fetchSingleImage(at url: URL, _ completion: @escaping (UIImage) -> Void) {
        // So that fetch20Images completion gets executed
        completion(UIImage())
    }

    func mockCharacter() -> Character {
        return Character(id: 1,
                        name: "MockedCharacter",
                        characterDescription: "",
                        modified: "",
                        // Needed to create a URL
                        thumbnail: Thumbnail(path: "http", thumbnailExtension: Extension(rawValue: "jpg")),
                        resourceURI: "",
                        comics: Comics(available: 0, collectionURI: "", items: nil, returned: 0),
                        series: Comics(available: 0, collectionURI: "", items: nil, returned: 0),
                        stories: Stories(available: 0, collectionURI: "", items: nil, returned: 0),
                        events: Comics(available: 0, collectionURI: "", items: nil, returned: 0),
                        urls: nil)
    }

}
