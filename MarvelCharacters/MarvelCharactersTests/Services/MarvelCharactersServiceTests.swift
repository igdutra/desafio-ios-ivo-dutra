//
//  MarvelCharactersServiceTests.swift
//  MarvelCharactersTests
//
//  Created by Ivo Dutra on 11/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class MarvelCharactersServiceTests: XCTestCase {

    var sut: MarvelCharactersService!

    override func setUp() {
        super.setUp()

        sut = MarvelCharactersService()
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    // MARK: - Request Success

    // This method should be tested asynchronously, because it does a web request

    func testRequestCharactersSuccess() {

        // Create an expectation for a background download task
        let expectation = XCTestExpectation(description: "Download 20 characters")
        // Offset = 0
        sut.offset = 0
        // Name of the first character
        let name = "3-D Man"

        sut.requestCharacters { (charactersArray) in
            // Assert that infos match and fulfill expectation
            if let characters = charactersArray {
                let character = characters[0]
                XCTAssertEqual(character.name, name, "Name should be 3-D Man")

                // Assert that are exactly 20 records
                XCTAssertEqual(characters.count, 20, "There should be exactly 20 records")
                
                expectation.fulfill()
            }
        }

        // Wait until the expectation is fulfilled, with a timeout of 5 seconds
        wait(for: [expectation], timeout: 5.0)
    }

     // MARK: - Request Error

    func testRequestCharactersError() {

        // Create an expectation for a background download task
        let expectation = XCTestExpectation(description: "Download 20 characters")

        // Change the base URL, so no photoInfo is returned
        sut.baseMarvelURL = URL(string: "https://apple.com")!

        sut.requestCharacters { (charactersArray) in

                // Assert that no info is returned and fulfill expectation
                XCTAssertNil(charactersArray, "Characters should be nil")
                expectation.fulfill()
        }

        // Wait until the expectation is fulfilled, with a timeout of 5 seconds
        wait(for: [expectation], timeout: 5.0)
    }

}
